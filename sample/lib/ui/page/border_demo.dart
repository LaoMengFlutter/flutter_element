import 'package:flutter/material.dart';
import 'package:element_ui/widgets.dart';

class BorderDemo extends StatelessWidget {
  const BorderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12, width: double.infinity),
            SizedBox(
              height: 40,
              width: 100,
              child: const EBorder(
                style: EBorderStyle(
                  strokeWidth: 10,
                ),
                child: Text('data'),
              ),
            ),
            SizedBox(height: 12),
            const EBorder(
              child: Text('data'),
            ),
            SizedBox(height: 12),
            const EBorder(
              mainAxisSize: MainAxisSize.min,
              child: Text('data min'),
            ),
            SizedBox(height: 12),
            const EBorder(
              mainAxisSize: MainAxisSize.min,
              style: EBorderStyle(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
              child: Text('data'),
            ),
            SizedBox(height: 12),
            Container(
              height: 40,
              width: 100,
              child: EBorder(
                type: BorderType.dashed,
                shape: BorderShape.round,
                child: Text('data'),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(height: 12),
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
                style: EBorderStyle(),
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
                style: EBorderStyle(color: Colors.red),
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
                style: EBorderStyle(
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
                style: EBorderStyle(
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
              child: EBorder(
                type: BorderType.dashed,
                shape: BorderShape.rrect,
                style: EBorderStyle(
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
              child: EBorder(
                type: BorderType.dashed,
                shape: BorderShape.rrect,
                style: EBorderStyle(
                    color: Colors.red, radius: BorderRadius.circular(5)),
                child: Text('data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
