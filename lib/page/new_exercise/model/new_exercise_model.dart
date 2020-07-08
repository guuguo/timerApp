import 'package:flutter/widgets.dart';
import 'package:timer/entiy/ExeciseEntity.dart';

class NewExerciseModel extends ChangeNotifier {
  ExerciseEntity entity;

  NewExerciseModel(){
    entity=ExerciseEntity()..title="好好运动";
  }
}
