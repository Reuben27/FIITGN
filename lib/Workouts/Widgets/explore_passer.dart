import '../models/WorkoutModel.dart';

class ExploreArguments {
  int dayNum;
  Map<String, WorkoutModel> workoutsForDays;

  ExploreArguments({this.dayNum, this.workoutsForDays});
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

  static List<List<WorkoutModel>> returnListWorkouts(ExploreArguments args) {
    Map<String, WorkoutModel> workouts = args.workoutsForDays;
    List<WorkoutModel> workoutList = [];
    workouts.forEach((key, value) {
      workoutList.add(value);
    });

    List<List<WorkoutModel>> list = [];
    list.add(workoutList);
    return list;
  }
}
