import 'package:flutter/widgets.dart';
import 'package:timer/entiy/ExeciseEntity.dart';

enum NextSecondStatus {
  ///休息开始
  restStart,

  ///休息中
  resting,

  ///运动结束
  end,

  ///运动开始
  exerciseStart,

  ///运动中,每秒或者每个动作  滴滴
  exercising,

  ///每组的其中一个运动中
  timesActionExercising,
}

class TimerModel extends ChangeNotifier {
  List<ActionEntity> list = [];

  TimerModel();

  ///初始化列表
  void _initList() {
    list.clear();
    for (var i = 0; i < _exercise.actionList.length; i++) {
      list = _exercise.actionList;
    }
  }

  ExerciseEntity _exercise;

  set exercise(ExerciseEntity value) {
    _exercise = value;
    _initList();
  }

  ///当前秒数
  int _secondCount = 0;

  ///展示的数字  时间或者次数
  int get showTimes {
    final action = list[index];
    if ((action?.times ?? 1) > 1) {
      return _secondCount ~/ action.duration;
    }
    return action.duration - _secondCount;
  }

  ExerciseEntity get exercise => _exercise;

  ///到第几个index了
  int index = 0;

  /// 返回 true 代表可以继续  返回false 代表结束
  NextSecondStatus nextSecond() {
    _secondCount++;
    final lastAction = list[index];

    ///这个运动的总时间是否已经过了(这个运动是否做好)
    if (_secondCount >= lastAction.realDuration()) {
      index++;
      _secondCount = 0;
    }
    if (index >= list.length) {
      notifyListeners();
      index = 0;
      return NextSecondStatus.end;
    } else {
      notifyListeners();

      final action = list[index];

      ///是否在同一个运动
      if (lastAction.isRelax == action.isRelax) {
        if (action.isRelax)

          ///如果是次数运动
          return NextSecondStatus.resting;
        else if (action.times > 1 && _secondCount % action.times != 0)
          return NextSecondStatus.timesActionExercising;
        else
          return NextSecondStatus.exercising;
      }

      /// 上次是(休息) 这次是(运动)
      if (!action.isRelax) {
        return NextSecondStatus.exerciseStart;
      } else
        return NextSecondStatus.restStart;
    }
  }

  bool isActive() => index != 0 || _secondCount != 0;

  String getCurrentTitle() => list[index].title;

  ///恢复初始
  void reset() {
    index = 0;
    _secondCount = 0;
    notifyListeners();
  }

  String showTimeStr() => isActive() ? (showTimes).toString() : '未开始';
}

class TimerBean {
  Duration duration;
  String title;

  TimerBean(this.duration, this.title);
}
