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

  ///运动中
  exercising,
}

class TimerModel extends ChangeNotifier {
  List<TimerBean> list = [];

  TimerModel() ;

  ///初始化列表
  void _initList() {
    list.clear();
    for (var i = 0; i < _exercise.titleList.length; i++) {
      final title =_exercise.titleList[i];
      for (var j = 0; j <_exercise.exerciseTimesPerAction; j++) {
        list.add(TimerBean(Duration(seconds:_exercise.doTime), title));
        list.add(TimerBean(Duration(seconds:_exercise.relaxTime), "休息"));
      }
    }
  }

  ExerciseEntity _exercise ;


  set exercise(ExerciseEntity value) {
    _exercise = value;
    _initList();
  }

  ///当前秒数
  int secondCount = 0;

  ///到第几个index了
  int index = 0;

  /// 返回 true 代表可以继续  返回false 代表结束
  NextSecondStatus nextSecond() {
    final lastIndex = index;
    secondCount++;
    if (secondCount >= list[index].duration.inSeconds) {
      index++;
      secondCount = 0;
    }
    if (index >= list.length) {
      notifyListeners();
      index = 0;
      return NextSecondStatus.end;
    } else {
      notifyListeners();

      /// 上次是奇数(休息) 这次是偶数(运动)
      if (lastIndex.isOdd && index.isEven) {
        return NextSecondStatus.exerciseStart;
      } else if (lastIndex.isEven && index.isEven) {
        return NextSecondStatus.exercising;
      } else if (lastIndex.isEven && index.isOdd) {
        return NextSecondStatus.restStart;
      } else if (lastIndex.isOdd && index.isOdd) {
        return NextSecondStatus.resting;
      } else {
        return NextSecondStatus.resting;
      }
    }
  }

  bool isActive() => index != 0 || secondCount != 0;

  String getCurrentTitle() => list[index].title;

  ///恢复初始
  void reset() {
    index = 0;
    secondCount = 0;
    notifyListeners();
  }

  String showTimeStr() => isActive()
      ? (list[index].duration.inSeconds - secondCount).toString()
      : '未开始';
}

class TimerBean {
  Duration duration;
  String title;

  TimerBean(this.duration, this.title);
}
