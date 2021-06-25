const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const database = admin.firestore();
exports.scheduledFunctionCrontab = functions.pubsub.schedule("* * * * *")
    .timeZone("Asia/Kolkata")
    .onRun(async (context) => {
        var date = new Date();
        var d = new Date(date.getTime() + 340 * 60 * 1000);
        var min = d.getMinutes();
        var hour = d.getHours();
        // console.log(min);
        database.collection("Notifications").get().then(function (querySnapshot) {
            querySnapshot.forEach(function (doc) {
            const timemap = doc.data()["TimeMap"];
            const numberofnoti = doc.data()["numberofnoti"];
            const tokenid = doc.data()["TokenID"];
            // console.log("Hello1");
            for(let i=1;i<=numberofnoti;i++){
                const time = timemap[i.toString()]["time"];
                // console.log(time);
                // console.log("Hello2");
                if ((time["hour"] == hour) && (time["minute"] == min)){
                    // console.log("Hello3");
                    const workoutid = timemap[i.toString()]["workoutName"];
                    // console.log(workoutid);
                    sendNotification(workoutid,tokenid);
                }
            }
            function sendNotification(workoutid, tokenid) {
                let title = "Workout Reminder"
                let body = "Your workout "+workoutid+" will begin in 10 minutes.";

                const message ={
                    notification : {
                        title: title,
                        body: body
                    },
                    token: tokenid,
                    data: {
                        route: workoutid,
                    }
                };

                admin.messaging().send(message).then(response =>{
                    return console.log("Successfully sent notification");
                }).catch(function (error) {
                    console.log("Error while sending notification: ", error);
                });
            }
        });
    })
    .catch (function(error) {
            console.log("Error getting documents: ", error);
        });
    return null;
});