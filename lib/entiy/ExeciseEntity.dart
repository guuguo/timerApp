class ExerciseEntity {
  ///运动名字
  var title = "";

  ///运动时间
  var doTime = 10;

  ///休息时间
  var relaxTime = 20;

  ///动作数组
  var titleList = ["抬手俯卧撑", "下斜俯卧撑", "蜘蛛俯卧撑", "平移俯卧撑", "碰肩俯卧撑"];

  ///每个动作的组数
  var exerciseTimesPerAction = 4;

  ExerciseEntity(
      {this.title,
      this.doTime,
      this.relaxTime,
      this.titleList,
      this.exerciseTimesPerAction});
}

final pushUpBean = ExerciseEntity(
    title: "间隔俯卧撑训练",
    doTime: 10,
    relaxTime: 20,
    titleList: ["抬手俯卧撑", "下斜俯卧撑", "蜘蛛俯卧撑", "平移俯卧撑", "碰肩俯卧撑"],
    exerciseTimesPerAction: 4);

final handBean = ExerciseEntity(
    title: "手臂训练",
    doTime: 30,
    relaxTime: 60,
    titleList: ["手臂弯举7.5-10kg", "手臂爆发弯举10-12.5kg", "屈臂悬垂", "三头肌下拉","躺平三后举"],
    exerciseTimesPerAction: 4);

