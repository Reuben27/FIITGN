// exports.scheduledFunction = functions.pubsub.schedule
// ('every 5 minutes').onRun((context) => {
//     console.log('This will be run every 5 minutes!');
//     return null;
// });
// Database se hour + minute + tokenID + workoutID
// var noti = firebase.database("Notifications");
// exports.createUser = functions.firestore
//     .document("Notifications/{tokenid}")
//     .onCreate((snap, context) => {
//         const newValue = snap.data();
//         const timemap = newValue.TimeMap;
//         const numberofnoti = newValue.numberofnoti;
//         console.log(timemap);
//         console.log(numberofnoti);
//         const hour = timemap[numberofnoti.toString()]["time"]["hour"];
//         const minute = timemap[numberofnoti.toString()]["time"]["minute"];
//         const workoutID = timemap[numberofnoti.toString()]["workoutid"];
//         console.log(hour);
//         console.log(minute);
//         console.log(workoutID);
//     });
// exports.updateUser = functions.firestore
//     .document("Notifications/{tokenid}")
//     .onUpdate((change, context) => {
//         const newValue = change.after.data();
//         const timemap = newValue.TimeMap;
//         const numberofnoti = newValue.numberofnoti;
//         console.log(timemap);
//         console.log(numberofnoti);
//         const hour = timemap[numberofnoti.toString()]["time"]["hour"];
//         const minute = timemap[numberofnoti.toString()]["time"]["minute"];
//         const workoutID = timemap[numberofnoti.toString()]["workoutid"];
//         console.log(hour);
//         console.log(minute);
//         console.log(workoutID);
//     });
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const database = admin.firestore();
exports.scheduledFunctionCrontab = functions.pubsub.schedule("* * * * *")
    .timeZone("Asia/Kolkata")
    .onRun(async (context) => {

        return null;
    });