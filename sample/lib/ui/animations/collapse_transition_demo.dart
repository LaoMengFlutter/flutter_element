import 'package:element_ui/animations.dart';
import 'package:element_ui/widgets.dart';
import 'package:flutter/material.dart';

class CollapseTransitionDemo extends StatefulWidget {
  const CollapseTransitionDemo({Key? key}) : super(key: key);

  @override
  _CollapseTransitionDemoState createState() => _CollapseTransitionDemoState();
}

class _CollapseTransitionDemoState extends State<CollapseTransitionDemo>
    with TickerProviderStateMixin {
  late AnimationController _controller1,
      _controller2,
      _controller3,
      _controller4;

  bool _isCollapse1 = false;
  bool _isCollapse2 = false;
  bool _isCollapse3 = false;
  bool _isCollapse4 = false;

  @override
  void initState() {
    super.initState();
    _controller1 =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller3 =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller4 =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var child = Container(
      color: Colors.white,
      height: 200,
      width: 300,
      child: EBorder(
        style: EBorderStyle(color: EleTheme.of(context).borderColorBase),
        child: EColorPicker(),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
              width: double.infinity,
            ),
            ECollapseTransition(
              collapse: _controller1,
              child: child,
            ),
            EButton(
              child: Text('向下'),
              onPressed: () {
                _isCollapse1 = !_isCollapse1;
                if (_isCollapse1) {
                  _controller1.forward();
                } else {
                  _controller1.reverse();
                }
              },
            ),
            ECollapseTransition(
              collapse: _controller4,
              direction: CollapseDirection.top,
              child: child,
            ),
            EButton(
              child: Text('向上'),
              onPressed: () {
                _isCollapse4 = !_isCollapse4;
                if (_isCollapse4) {
                  _controller4.forward();
                } else {
                  _controller4.reverse();
                }
              },
            ),
            Row(
              children: [
                ECollapseTransition(
                  collapse: _controller2,
                  direction: CollapseDirection.right,
                  child: child,
                ),
                EButton(
                  child: Text('向右'),
                  onPressed: () {
                    _isCollapse2 = !_isCollapse2;
                    if (_isCollapse2) {
                      _controller2.forward();
                    } else {
                      _controller2.reverse();
                    }
                  },
                ),
              ],
            ),
            Row(
              children: [
                EButton(
                  child: Text('向左'),
                  onPressed: () {
                    _isCollapse3 = !_isCollapse3;
                    if (_isCollapse3) {
                      _controller3.forward();
                    } else {
                      _controller3.reverse();
                    }
                  },
                ),
                ECollapseTransition(
                  collapse: _controller3,
                  direction: CollapseDirection.left,
                  child: child,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
