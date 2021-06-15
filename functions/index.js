const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
// exports.scheduledFunction = functions.pubsub.schedule('every 5 minutes').onRun((context) => {
//     console.log('This will be run every 5 minutes!');
//     return null;
// });


// Database se hour + minute + tokenID + workoutID

exports.scheduledFunctionCrontab = functions.pubsub.schedule('5 11 * * *')
    .timeZone("Asia/Kolkata") // Users can choose timezone - default is America/Los_Angeles
    .onRun((context) => {
        // Cloud messaging
        console.log('This will be run every day at 11:05 AM Eastern!');
        return null;
    });