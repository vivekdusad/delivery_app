
var admin = require("firebase-admin");
const express = require('express')
const app = express()
require('dotenv').config()
var bodyParser = require('body-parser');
const port = process.env.PORT || 3000
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
var serviceAccount = require("./delivery.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://deliveryapp-6b08d-default-rtdb.firebaseio.com"
});

app.get('/', (req, res) => {
  res.send('Hello World!')
})
app.get('/ready', (req, res) => {
  res.send('ready')
})

app.post('/', function (req, res) {
  var data = req.body;
  console.log(req.body['user_id']);

  admin.messaging().sendToTopic(
    "order",
    {
      data: {
        "user_id": data['user_id'],
        "order_id": data['order_id'],
        "order": data['order']
      },
      notification: {
        title: "New Order!",
        body: "click to see this.",
        sound: 'default',
        android_channel_id: "high_importance_channel",

      },
    },
    { priority: "high" }
  ).then(
    console.log("sent")
  );
  res.send('Posted')
})
app.post('/ready', function (req, res) {
  var data = req.body;
  console.log(req.body['token']);
  var token = req.body['token'];
  const message = {
    data: {
      score: '850',
      time: '2:45'
    },
    notification: {
      title: data['title'],
      body: data['desc'],
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
  res.send('Posted')
})

app.listen(port, () => {
  console.log("Example app listening at http://localhost:3000")
})






