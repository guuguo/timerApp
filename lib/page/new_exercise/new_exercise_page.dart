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

  var model = NewExerciseModel();
  final colors = [
    Colors.red,
    Colors.blueAccent,
    Colors.amber,
    Colors.deepPurple,
    Colors.purple
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<NewExerciseModel>.value(
        value: model,
        child: Consumer<NewExerciseModel>(
          builder: (context, model, child) {
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(onTap: () {}, child: Text("快速开始"))
                    ],
                  ),
                  ListView.builder(
                      padding: EdgeInsets.all(15),
                      itemCount: model.list.length,
                      itemBuilder: (c, index) {
                        final it = model.list[index];
                        final color = colors[index % 5];

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                RouteName.exercisePage,
                                arguments: it);
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            width: 100,
                            height: 100,
                            decoration: RoundDecoration.circular(color: color),
                            child: Text(it.title,
                                style:
                                    Theme.of(context).primaryTextTheme.body1),
                          ),
                        );
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
