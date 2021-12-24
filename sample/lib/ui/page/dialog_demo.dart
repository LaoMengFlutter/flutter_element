import 'package:element_ui/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogDemo extends StatelessWidget {
  const DialogDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            EButton(
              onPressed: () {
                // EDialog.showConfirmDialog(context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return EAlertDialog(
                        title: Text('提示'),
                        titleCenter: true,
                        content: Text('1、提示 \n1、提示'),
                        contentCenter: true,
                        actions: [
                          EButton(
                            child: Container(
                              child: Text('取消'),
                              width: double.infinity,
                              alignment: Alignment.center,
                            ),
                            borderStyle: EButtonBorderStyle.none,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          EButton(
                            child: Container(
                              child: Text('确认'),
                              width: double.infinity,
                              alignment: Alignment.center,
                            ),
                            radius: BorderRadius.zero,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          // EButton(
                          //   child: Container(
                          //     child: Text('取消3'),
                          //     width: 200,
                          //     alignment: Alignment.center,
                          //   ),
                          //   onPressed: () {
                          //     Navigator.of(context).pop();
                          //   },
                          // ),
                        ],
                        actionType: DialogActionType.cupertino,
                        scrollable: true,
                        maxContentHeight: 200,
                        actionsAlignment: MainAxisAlignment.center,
                      );
                      return CupertinoAlertDialog(
                        title: Text('提示'),
                        content: Text(
                            '1、提示 \n1、提示 \n1、提示 \n1、提示 \n1、提示 \n1、提示 \n1、提示 \n1、提示 \n'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('No'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text('Yes'),
                            isDestructiveAction: true,
                            onPressed: () {
                              // Do something destructive.
                            },
                          ),
                          // CupertinoDialogAction(
                          //   child: const Text('Yes1'),
                          //   isDestructiveAction: true,
                          //   onPressed: () {
                          //     // Do something destructive.
                          //   },
                          // )
                        ],
                      );
                    });
              },
              child: Text('基础用法'),
            ),
          ],
        ),
      ),
    );
  }
}
