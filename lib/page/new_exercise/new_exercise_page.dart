import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/entiy/ExeciseEntity.dart';
import 'package:timer/view/simple_widget.dart';

import 'model/new_exercise_model.dart';
import 'num_pad_dialog.dart';

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
                      child: ListView.separated(
                        padding: EdgeInsets.only(bottom: 20),
                        separatorBuilder: (c, i) => SizedBox(height: 10),
                        itemCount: model.entity.actionList.length + 1,
                        itemBuilder: (c, index) {
                          if (index == model.entity.actionList.length) return buildAddNewAcionWidget();
                          return buildAction(model.entity.actionList[index], index);
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

  Widget buildAction(ActionEntity action, int index) {
    return Container(
      alignment: Alignment.center,
      decoration:
          RoundDecoration.circular(color: action.isRelax ? Colors.grey.shade400 : Colors.blue.shade700, radius: 4),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: action.isRelax ? 4.0 : 10),
      child: Container(
        height: 30,
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Text(
                  action.title,
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, fontWeight: action.isRelax ? FontWeight.normal : FontWeight.bold),
                ),
              ),
            ),
            Positioned(right: 10,top:0,bottom: 0,child: IconButton(icon:Icon(Icons.cancel,color: Colors.blueGrey,),padding: EdgeInsets.all(4),onPressed: (){
              model.deleteAction(action);
            },))
          ],
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
          showDialog(
              context: context,
              builder: (c) => NumPadDialog((times, title) {
                    model.addAction(times, title);
                  }));
        } else if (title == "时间运动") {
        } else if (title == "休息") {
          model.addRelax(30);
        }
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
