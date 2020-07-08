class SimpleExerciseEntity {
  ///运动名字
  var title = "";

  ///运动时间
  var doTime = 10;

  ///休息时间
  var relaxTime = 20;

  ///动作数组
  var titleList = [];

  ///每个动作的组数
  var exerciseTimesPerAction = 4;

  ///是次数吗 次数大于1,的时候,那就是
  int times;

  SimpleExerciseEntity(
      {this.title, this.doTime, this.relaxTime, this.titleList, this.exerciseTimesPerAction, this.times = 1});

  ExerciseEntity toExerciseEntity() {
    final List<ActionEntity> list = [];
    titleList.forEach((title) {
      list.add(ActionEntity(title: title, isRelax: false, duration: doTime, times: times));
      list.add(ActionEntity(title: title, isRelax: true, duration: relaxTime));
    });
    return ExerciseEntity(title: title, actionList: list);
  }
}

class ActionEntity {
  ///运动名字
  var title = "";

  ///运动时间 秒 每组或者每个
  var duration = 10;

  ActionEntity.relax(this.duration) {
    title = "休息${this.duration}秒";
    isRelax = true;
  }

  ///图片链接
  var photoUrl = "";

  ///是休息吗
  bool isRelax;

  ///是次数吗 次数大于1,的时候,那就是
  int times = 1;

  ActionEntity({this.title, this.duration, this.isRelax = false, this.times = 1});

  int realDuration() => times > 1 ? duration * times : duration;
}

class ExerciseEntity {
  ///运动名字
  var title = "";

  ///动作数组
  List<ActionEntity> actionList;

  ExerciseEntity({this.title, this.actionList}) {
    this.actionList = this.actionList ?? [];
  }
}

final pushUpBean = SimpleExerciseEntity(
        title: "间隔俯卧撑训练",
        doTime: 10,
        relaxTime: 20,
        titleList: [
          "抬手俯卧撑",
          "下斜俯卧撑",
          "蜘蛛俯卧撑",
          "平移俯卧撑",
          "碰肩俯卧撑",
        ],
        exerciseTimesPerAction: 4)
    .toExerciseEntity();

final handBean = SimpleExerciseEntity(
        title: "手臂训练",
        doTime: 2,
        relaxTime: 60,
        times: 8,
        titleList: ["手臂弯举7.5-10kg", "手臂爆发弯举10-12.5kg", "屈臂悬垂", "三头肌下拉", "躺平三后举"],
        exerciseTimesPerAction: 4)
    .toExerciseEntity();
final fiveFitBean = ExerciseEntity(title: "五分钟居家燃脂训练", actionList: [
  ActionEntity(title: "登山式", duration: 30),
  ActionEntity(title: "侧踢腿", duration: 20),
  ActionEntity(title: "深蹲波比跳", duration: 10),
  ActionEntity.relax(10),
  ActionEntity(title: "登山式", duration: 10),
  ActionEntity(title: "侧踢腿", duration: 30),
  ActionEntity(title: "深蹲波比跳", duration: 20),
  ActionEntity.relax(20),
  ActionEntity(title: "登山式", duration: 20),
  ActionEntity(title: "侧踢腿", duration: 20),
  ActionEntity(title: "深蹲波比跳", duration: 20),
]);
