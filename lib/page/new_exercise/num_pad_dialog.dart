import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timer/commmon/utils.dart';
import 'package:timer/view/simple_widget.dart';

typedef NumActionConfirm = void Function(int times, String title);

class NumPadDialog extends StatefulWidget {
  NumPadDialog(this.confirm);

  final NumActionConfirm confirm;

  @override
  _NumPadDialogState createState() => _NumPadDialogState();
}

class _NumPadDialogState extends State<NumPadDialog> {
  String num = "";
  String title = "";
  final List<String> nums = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0","<-"];

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Center(
        child: Text("添加次数运动"),
      ),
      actions: [
        FlatButton(
          child: Text("确定"),
          onPressed: () {
            if (title.isEmpty) {
              showWarning(context, "运动名不能为空");
              return;
            }
            if (num.isEmpty) {
              showWarning(context, "运动次数不能为空");
              return;
            }
            widget.confirm(int.parse(num), title);
            Navigator.of(context).pop();
          },
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          CupertinoTextField(
            controller: TextEditingController(text: title),
            placeholder: "运动名",
            onChanged: (s){
              title=s;
            },
          ),
          SizedBox(height: 4),
          Container(
            height: 40,
            child: Text(
              num,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, wordSpacing: 8),
            ),
            alignment: Alignment.center,
            decoration: RoundDecoration.circular(color: Colors.grey.shade400, radius: 5),
          ),
          SizedBox(height: 5),
          Wrap(
            alignment: WrapAlignment.center,
            children: nums
                .map((e) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if(e=="<-"){
                            num=num.substring(0,max(0,num.length-1));
                            return;
                          }
                          if (num.length >= 3) {
                            showMessage( context,"一次性不要做太多哦~");
                            return;
                          }
                          num += e.toString();
                        });
                      },
                      child: Container(
                        width: 60,
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: RoundDecoration.circular(color: Colors.blue, radius: 4),
                        alignment: Alignment.center,
                        height: 40,
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
