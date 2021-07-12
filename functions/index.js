
var admin = require("firebase-admin");

const express = require('express')
const app = express()
const port = 3000
var serviceAccount = require("C:/Users/mkdus/OneDrive/Desktop/delivery_app/functions/delivery.json");
var payload = {
    data:{
        MyKey1:"Order"
    }
};
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://deliveryapp-6b08d-default-rtdb.firebaseio.com"
});
app.get('/', (req, res) => {
   res.send('Hello World!')
}) 
 
app.post('/', function (req, res) {
    admin.messaging().sendToTopic("order",payload).then(
        console.log("sent")
    );
    res.send('Posted')
})

app.listen(port, () => {
    console.log("Example app listening at http://localhost:3000")
})




