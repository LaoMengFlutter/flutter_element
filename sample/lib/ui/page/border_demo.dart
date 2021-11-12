import 'package:flutter/material.dart';
import 'package:flutter_element/widgets.dart';

class BorderDemo extends StatelessWidget {
  const BorderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 12,
            width: double.infinity,
          ),
          Container(
            height: 40,
            width: 100,
            child: const EBorder(
              child: Text('data'),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 40,
            width: 100,
            child: const EBorder(
              type: BorderType.dashed,
              shape: BorderShape.round,
              style: EleBorderThemeData(
                color: Colors.yellow,
                strokeWidth: 2,
                radius: Radius.circular(8),
              ),
              child: Text('data'),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 40,
            width: 100,
            child: const EBorder(
              type: BorderType.dashed,
              child: Text('data1'),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 40,
            width: 100,
            child: const EBorder(
              type: BorderType.dashed,
              shape: BorderShape.circle,
              child: Text('data2'),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 40,
            width: 100,
            child: const EBorder(
              type: BorderType.dashed,
              shape: BorderShape.rrect,
              style: EleBorderThemeData(),
              child: Text('data3'),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 40,
            width: 100,
            child: const EBorder(
              type: BorderType.dashed,
              shape: BorderShape.rrect,
              style: EleBorderThemeData(color: Colors.red),
              child: Text('data'),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 40,
            width: 100,
            child: const EBorder(
              type: BorderType.dashed,
              shape: BorderShape.rrect,
              style: EleBorderThemeData(
                color: Colors.red,
                strokeWidth: 3,
              ),
              child: Text('data'),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 40,
            width: 200,
            child: const EBorder(
              type: BorderType.dashed,
              shape: BorderShape.rrect,
              style: EleBorderThemeData(
                color: Colors.red,
                strokeWidth: 3,
                dashGap: 5,
                dashWidth: 5,
              ),
              child: Text('data'),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 40,
            width: 200,
            child: const EBorder(
              type: BorderType.dashed,
              shape: BorderShape.rrect,
              style: EleBorderThemeData(
                color: Colors.red,
                strokeWidth: 1,
                dashGap: 5,
                dashWidth: 10,
              ),
              child: Text('data'),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 40,
            width: 200,
            child: const EBorder(
              type: BorderType.dashed,
              shape: BorderShape.rrect,
              style: EleBorderThemeData(
                  color: Colors.red, radius: Radius.circular(5)),
              child: Text('data'),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 40,
            width: 200,
            child: const EBorder(
              type: BorderType.dashed,
              shape: BorderShape.line,
              style: EleBorderThemeData(
                  color: Colors.red, radius: Radius.circular(5)),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 40,
            width: 200,
            child: const EBorder(
              shape: BorderShape.line,
            ),
          ),
          Container(
            height: 50,
            width: 50,
            child: const EBorder(
              shape: BorderShape.line,
              direction: BorderLineDirection.vertical,
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 40,
            width: 200,
            child: EBorder(
              shape: BorderShape.line,
              type: BorderType.dashed,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text('data'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
