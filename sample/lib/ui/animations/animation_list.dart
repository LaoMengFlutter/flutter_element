import 'package:flutter/material.dart';

import 'collapse_transition_demo.dart';

class AnimationList extends StatelessWidget {
  AnimationList({Key? key}) : super(key: key);

  final List _data = [
    {'title': 'CollapseTransition', 'page': const CollapseTransitionDemo()},
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