import '../models/WorkoutModel.dart';

class CreateArguments {
  int dayNum;
  Map<String, WorkoutModel> workoutsForDays;

  CreateArguments({this.dayNum, this.workoutsForDays});
  int getDayNum() {
    return dayNum;
  }

  Map<String, WorkoutModel> getWorkoutsMap() {
    return workoutsForDays;
  }

  static WorkoutModel rest_model = WorkoutModel(
    creator_name: "Rest",
    creatorId: "Rest",
    workoutId: "RestId123",
    listOfOnGoingId: ['-1'],
    workoutName: "Rest",
    access: 'Private',
    creationDate: 'None',
    listOfExercisesId: ['-1'],
    listOfFollowersId: ['-1'],
    description: "This denotes Rest Day",
  );

  static List<List<WorkoutModel>> returnListWorkouts(CreateArguments args) {
    Map<String, WorkoutModel> workouts = args.workoutsForDays;
    List<WorkoutModel> workoutList = [];
    // workouts.forEach((key, value) {
    //   if (key != '-1') {
    //     workoutList.add(value);
    //   }
    // });
    // workoutList.add(workouts['']);
    workoutList.add(workouts['1']);
    workoutList.add(workouts['2']);
    workoutList.add(workouts['3']);
    workoutList.add(workouts['4']);
    workoutList.add(workouts['5']);
    workoutList.add(workouts['6']);
    workoutList.add(workouts['7']);
    List<List<WorkoutModel>> list = [];
    list.add(workoutList);
    return list;
  }
}
