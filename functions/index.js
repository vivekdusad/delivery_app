
var admin = require("firebase-admin");
const express = require('express')
const app = express()
var bodyParser = require('body-parser');
const port = 3000
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
var serviceAccount = require("E:/flutter_projects/delivery_app/functions/delivery.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://deliveryapp-6b08d-default-rtdb.firebaseio.com"
});

function sendToToken(title,desc,token){
  const message = {
    data: {
      score: '850',
      time: '2:45'
    },
    notification: {
      title: title,
      body: desc,
    },
    android:{
      priority:"high",
      notification:{
        sound:'default',
        priority:'max',
        defaultSound:true,
        channelId:"high_importance_channel",
      }
    },
    

    token: token
  };

  admin.messaging().send(message).then(
    console.log("sent")
  );
}

function sendToTopics(data,topic){
  admin.messaging().sendToTopic(
    topic,
    {
      data: {
        "user_id": data['user_id'],
        "order_id": data['order_id'],
        "order": data['order']
      },
      notification: {
        title: data['title'],
        body: data['desc'],
        sound: 'default',
        android_channel_id: "high_importance_channel",

      },
    },
    { priority: "high" }
  ).then(
    console.log("sent")
  );
}


app.get('/', (req, res) => {
  res.send('Hello World!')
})
app.get('/ready', (req, res) => {
  res.send('ready')
})

app.post('/', function (req, res) {
  var data = req.body;
  console.log(req.body['user_id']); 
  sendToTopics(req.body,"order");
  sendToToken(req.body['code'],"verify code with delivery boy",data['token']);
  res.send('Posted')
})

app.post('/cancel', function (req, res) {
  var data = req.body; 
  admin.messaging().sendToTopic(
    topic,
    {
      data: {
        "user_id": data['user_id'],
        "order_id": data['order_id'],        
      },
      notification: {
        title: data['title'],
        body: data['desc'],
        sound: 'default',
        android_channel_id: "high_importance_channel",

      },
    },
    { priority: "high" }
  ).then(
    console.log("sent")
  );
  sendToToken("Cancelled","Your Order is Cancelled",data['token']);
  res.send('Posted')
})

app.post('/ready', function (req, res) {
  var data = req.body;
  console.log(req.body['token']);
  var token = req.body['token'];
  sendToToken(data['title'],data['desc'],token);
  res.send('Posted')
})

app.listen(port, () => {
  console.log("Example app listening at http://localhost:3000")
})




