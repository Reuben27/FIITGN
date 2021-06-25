const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const database = admin.firestore();
exports.scheduledFunctionCrontab = functions.pubsub.schedule("* * * * *")
    .timeZone("Asia/Kolkata")
    .onRun(async (context) => {
        var date = new Date();
        var d = new Date(date.getTime() + 330 * 60 * 1000);
        var min = d.getMinutes();
        var hour = d.getHours();
        database.collection("Notifications").get().then(function (querySnapshot) {
            querySnapshot.forEach(function (doc) {
            const timemap = doc.data()["TimeMap"];
            const numberofnoti = doc.data()["numberofnoti"];
            const tokenid = doc.data()["TokenID"];
            for(let i=1;i<=numberofnoti;i++){
                const time = timemap[i.toString()]["time"];
                // console.log(time);
                if ((time["hour"] == hour) && (time["minute"] == min)){
                    const workoutid = timemap[i.toString()]["workoutid"];
                    sendNotification(workoutid,tokenid);
                }
            }
            function sendNotification(workoutid, tokenid) {
                let title = "Workout Reminder"
                let body = "You have a workout to be done."

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