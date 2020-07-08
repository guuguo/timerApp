import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/routers/router.dart';
import 'package:timer/view/simple_widget.dart';

import 'model/home_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  var model = HomeModel();
  final colors = [Colors.red, Colors.blueAccent, Colors.amber, Colors.deepPurple, Colors.purple];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(middle: Text("运动计时器")),
      body: ChangeNotifierProvider<HomeModel>.value(
        value: model,
        child: Consumer<HomeModel>(
          builder: (context, model, child) {
            return SafeArea(
              child: ListView.builder(
                  padding: EdgeInsets.all(15),
                  itemCount: model.list.length + 1,
                  itemBuilder: (c, index) {
                    final exItem = index == model.list.length ? null : model.list[index];
                    final color = colors[index % 5];

                    return GestureDetector(
                      onTap: () {
                        if (index < model.list.length)
                          Navigator.of(context).pushNamed(RouteName.exercisePage, arguments: exItem);
                        else {
                          Navigator.of(context).pushNamed(RouteName.newExercisePage, arguments: exItem);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: 100,
                        height: 100,
                        decoration: RoundDecoration.circular(color: color),
                        child: Text(exItem?.title ?? "新增运动", style: Theme.of(context).primaryTextTheme.body1),
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
