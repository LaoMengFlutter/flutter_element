import 'package:flutter/material.dart';

import 'animations/animation_list.dart';
import 'page/widget_list.dart';

class NavigatorList extends StatelessWidget {
  NavigatorList({Key? key}) : super(key: key);

  final List _data = [
    {'title': 'Widget', 'page': WidgetList()},
    {'title': 'Animation', 'page': AnimationList()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return _data[index]['page'];
                }));
              },
              child: ListTile(
                title: Text('${_data[index]['title']}'),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: _data.length),
    );
  }
}
