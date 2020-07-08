import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/entiy/ExeciseEntity.dart';
import 'package:timer/view/simple_widget.dart';

import 'model/timer_model.dart';

class TimerPage extends StatefulWidget {
  TimerPage(this.exercise);

  ExerciseEntity exercise;

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Timer timer;
  var model = TimerModel();

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  AudioCache audioPlayer;

  @override
  void initState() {
    print('initState');
    audioPlayer = AudioCache(prefix: 'mp3/');
    AudioPlayer.logEnabled = false;
    model.exercise = widget.exercise;
    print('setexercise');
    super.initState();
  }

  ///时间
  playTime() async {
    await audioPlayer.play('Etimer.mp3');
  }

  ///休息开始
  playRestStart() async {
    await audioPlayer.play('Eg_10_take_a_rest.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(widget.exercise.title),
      ),
      body: ChangeNotifierProvider<TimerModel>.value(
        value: model,
        child: Consumer<TimerModel>(
          builder: (context, model, child) {
            final isRelax = model.list[model.index].isRelax;
            return SafeArea(
              child: AnimatedTheme(
                data: isRelax ? ThemeData.dark() : ThemeData.light(),
                child: Builder(
                    builder: (context) => Container(
                          width: double.infinity,
                          color: Theme.of(context).cardColor,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  decoration: RoundDecoration.circular(color: Color(0xFF352ab4), radius: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30.0),
                                        child: Text(
                                          model.getCurrentTitle(),
                                          style: Theme.of(context).primaryTextTheme.headline3,
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          model.showTimeStr(),
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headline3
                                              .copyWith(fontWeight: FontWeight.w900, fontSize: 100),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: buildOpButton(context, model),
                              ),
                            ],
                          ),
                        )),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildOpButton(BuildContext context, TimerModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: ShapeDecoration(
                  shape: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).dividerColor))),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: model.list.length,
                itemBuilder: (c, i) => Text(
                  model.list[i].title,
                  style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
                ),
              ),
            ),
          ),
          Width(10),
          timer == null
              ? buildStartButton()
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          timer?.cancel();
                        },
                        child: Text(
                          '暂停',
                          style: Theme.of(context).primaryTextTheme.body1,
                        ),
                      ),
                    ),
                    Height(10),
                    Expanded(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          timer?.cancel();
                          timer=null;
                          model.reset();
                        },
                        child: Text(
                          '停止',
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }

  Widget buildStartButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      height: double.infinity,
      color: Theme.of(context).accentColor,
      onPressed: () {
        if (timer?.isActive == true) timer?.cancel();
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
          final state = model.nextSecond();
          if (state == NextSecondStatus.end)
            timer.cancel();
          else if (state == NextSecondStatus.exercising) {
            playTime();
          }
          if (state == NextSecondStatus.restStart) {
            playRestStart();
          }
        });
        setState(() {});
      },
      child: Text(
        '开始',
        style: Theme.of(context).primaryTextTheme.body1,
      ),
    );
  }
}
