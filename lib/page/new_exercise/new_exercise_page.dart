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
                          if (index == model.entity.actionList.length)
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
                                      buildAddItemButton("次数运动",0),
                                      buildAddItemButton("时间运动",1),
                                      buildAddItemButton("休息",2),
                                    ],
                                  ),
                                ],
                              ),
                            );
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

  Widget buildAddItemButton(String title,int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Text(title,style: TextStyle(color: Colors.white),),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        color: colors[index%5]
      ),
      margin: EdgeInsets.all(4),
    );
  }
}
