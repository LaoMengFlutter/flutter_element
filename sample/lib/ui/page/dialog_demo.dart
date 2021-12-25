
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
                        content: Text('确认删除吗'),
                        actions: [
                          EButton(
                            child: Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          EButton(
                            child: Text('确认'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Text('基础用法'),
            ),
            EButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return EAlertDialog(
                        title: Text('提示'),
                        titleCenter: true,
                        content: Text('确认删除吗'),
                        contentCenter:true ,
                        actions: [
                          EButton(
                            child: Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          EButton(
                            child: Text('确认'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Text('标题、内容居中'),
            ),
            EButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return EAlertDialog(
                        title: Text('提示'),
                        content: Text(' 1、内容 \n 2、内容 \n 3、内容 \n 4、内容 \n 5、内容 \n 6、内容 \n 7、内容 \n 8、内容 \n 9、内容'),
                        actions: [
                          EButton(
                            child: Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          EButton(
                            child: Text('确认'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                        scrollable: true,
                        maxContentHeight: 150,
                      );
                    });
              },
              child: Text('内容过多滚动'),
            ),
            EButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return EAlertDialog(
                        title: Text('提示'),
                        content: Text('1、内容'),
                        actions: [
                          EButton(
                            child: Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          EButton(
                            child: Text('确认'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                        actionsAlignment: MainAxisAlignment.end,
                      );
                    });
              },
              child: Text('按钮靠右'),
            ),
            EButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return EAlertDialog(
                        title: Text('提示'),
                        content: Text('1、内容'),
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
                        ],
                        actionType: DialogActionType.cupertino,
                      );
                    });
              },
              child: Text('按钮铺满'),
            ),
            EButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return EAlertDialog(
                        title: Text('提示'),
                        content: Text('1、内容'),
                        actions: [
                          EButton(
                            child: Container(
                              child: Text('立即升级'),
                              width: double.infinity,
                              alignment: Alignment.center,
                            ),
                            borderStyle: EButtonBorderStyle.fill,
                            radius: BorderRadius.circular(30),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          EButton(
                            child: Container(
                              child: Text('稍后再说'),
                              width: double.infinity,
                              alignment: Alignment.center,
                            ),
                            borderStyle: EButtonBorderStyle.stroke,
                            radius: BorderRadius.circular(30),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          EButton(
                            child: Container(
                              child: Text('明天提醒'),
                              width: double.infinity,
                              alignment: Alignment.center,
                            ),
                            borderStyle: EButtonBorderStyle.stroke,
                            radius: BorderRadius.circular(30),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Text('多个按钮上下排列'),
            ),
          ],
        ),
      ),
    );
  }
}
