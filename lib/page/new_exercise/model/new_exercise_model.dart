import 'package:flutter/widgets.dart';
import 'package:timer/entiy/ExeciseEntity.dart';

class NewExerciseModel extends ChangeNotifier {
  ExerciseEntity entity;

  NewExerciseModel(){
    entity=ExerciseEntity()..title="好好运动";
  }

  void addAction(int times,String title){
    entity.actionList.add(ActionEntity(title: title,duration: 30,times: times,isRelax: false));
    notifyListeners();
  } void deleteAction(ActionEntity action){
    entity.actionList.remove(action);
    notifyListeners();
  }
  void addRelax(int duration){
    entity.actionList.add(ActionEntity(title: "休息",duration: duration,isRelax: true));
    notifyListeners();
  }
}
