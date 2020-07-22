import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/routers/router.dart';
import 'package:timer/view/simple_widget.dart';

import 'model/new_exercise_model.dart';

class NewExercisePage extends StatefulWidget {
  @override
  _NewExercisePageState createState() => _NewExercisePageState();
}

class _NewExercisePageState extends State<NewExercisePage> {
  @override
  void initState() {
    super.initState();
  }

  final controller = TextEditingController();
  var model = NewExerciseModel();
  final colors = [Colors.red, Colors.blueAccent, Colors.amber, Colors.deepPurple, Colors.purple];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("添加新运动"),
      ),
      body: ChangeNotifierProvider<NewExerciseModel>.value(
        value: model,
        child: Consumer<NewExerciseModel>(
          builder: (context, model, child) {
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      controller: TextEditingController(text: model.entity?.title ?? ""),
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: "运动名"),
                    ),
                  ),
                  Expanded(
                    child: Offstage(
                      offstage: model.entity == null,
                      child: ListView.builder(
                        itemCount: model.entity.actionList.length + 1,
                        itemBuilder: (c, index) {
                          if (index == model.entity.actionList.length) return buildAddNewAcionWidget();
                          return Text(model.entity.actionList[index].title);
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  ///添加新项
  Container buildAddNewAcionWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(6),
      decoration: ShapeDecoration(shape: OutlineInputBorder()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("添加新项"),
          ),
          Wrap(
            children: [
              buildAddItemButton("次数运动", 0),
              buildAddItemButton("时间运动", 1),
              buildAddItemButton("休息", 2),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAddItemButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        if (title == "次数运动") {
          showDialog(context: context, builder: (c) => NumPadDialog());
        } else if (title == "时间运动") {
        } else if (title == "休息") {}
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            color: colors[index % 5]),
        margin: EdgeInsets.all(4),
      ),
    );
  }
}

class NumPadDialog extends StatefulWidget {
  @override
  _NumPadDialogState createState() => _NumPadDialogState();
}

class _NumPadDialogState extends State<NumPadDialog> {
  String num = "";
  final nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text("添加次数运动"),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 40,
            child: Text(
              num,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, wordSpacing: 8),
            ),
            alignment: Alignment.center,
            decoration: RoundDecoration.circular(color: Colors.grey.shade400, radius: 5),
          ),
          SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            children: nums
                .map((e) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if (num.length >= 3) {
                            Flushbar(
                              title:  "提示",
                              message:  "一次性不要做太多哦~",
                              duration:  Duration(seconds: 1),

                            )..show(context);
                            return;
                          }
                          num += e.toString();
                        });
                      },
                      child: Container(
                        width: 60,
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: RoundDecoration.circular(color: Colors.blue, radius: 4),
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          e.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
