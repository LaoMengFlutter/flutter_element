import 'package:flutter_element/widgets.dart';

import 'package:flutter/material.dart';

class ProgressDemo extends StatefulWidget {
  const ProgressDemo({Key? key}) : super(key: key);

  @override
  State<ProgressDemo> createState() => _ProgressDemoState();
}

class _ProgressDemoState extends State<ProgressDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    _animation = IntTween(begin: 0, end: 100).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              EButton(
                onPressed: () {
                  _controller.reset();
                  _controller.forward();
                },
                child: Text('开始'),
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Column(
                    children: [
                      SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 30,
                        // color: Colors.red,
                        child: EProgress(
                          progress: _animation.value,
                          strokeWidth: 20,
                          status: EleThemeStatus.success,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: EProgress(
                              progress: _animation.value,
                              type: ProgressType.circle,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            height: 100,
                            width: 100,
                            child: EProgress(
                              progress: _animation.value,
                              type: ProgressType.dashboard,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            height: 30,
                            width: 150,
                            child: EProgress(
                              progress: _animation.value,
                              type: ProgressType.liquid,
                              borderColor: Colors.red,
                              borderWidth: 5,
                              radius: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 30,
                        // color: Colors.red,
                        child: EProgress(
                          progress: _animation.value,
                          strokeWidth: 20,
                          textInside: true,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 30,
                        // color: Colors.red,
                        child: EProgress(
                          progress: _animation.value,
                          strokeWidth: 20,
                          strokeCap: StrokeCap.round,
                          format: (progress) {
                            return '自定义：$progress%';
                          },
                          status: EleThemeStatus.success,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 30,
                        // color: Colors.red,
                        child: EProgress(
                          progress: _animation.value,
                          strokeWidth: 20,
                          strokeCap: StrokeCap.round,
                          textInside: true,
                          colors: [
                            Colors.blue,
                            Colors.red,
                            Colors.green,
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 150,
                            child: EProgress(
                              progress: _animation.value,
                              strokeWidth: 50,
                              direction: Axis.vertical,
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            width: 50,
                            height: 150,
                            // color: Colors.red,
                            child: EProgress(
                              progress: _animation.value,
                              strokeWidth: 50,
                              textInside: true,
                              direction: Axis.vertical,
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            height: 100,
                            width: 100,
                            child: EProgress(
                              progress: _animation.value,
                              type: ProgressType.circle,
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            height: 100,
                            width: 100,
                            child: EProgress(
                              progress: _animation.value,
                              type: ProgressType.circle,
                              format: (progress) {
                                if (progress == 100) {
                                  return '完成';
                                }
                                return '$progress%';
                              },
                              colors: [
                                Colors.blue,
                                Colors.red,
                                Colors.green,
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [],
                      ),
                      SizedBox(height: 12),

                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: EProgress(
                              progress: _animation.value,
                              type: ProgressType.dashboard,
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            height: 100,
                            width: 100,
                            child: EProgress(
                              progress: _animation.value,
                              type: ProgressType.dashboard,
                              strokeWidth: 10,
                              strokeCap: StrokeCap.round,
                              showText: false,
                              colors: [
                                Colors.blue,
                                Colors.red,
                                Colors.yellow,
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            height: 100,
                            width: 100,
                            child: EProgress(
                              progress: _animation.value,
                              type: ProgressType.dashboard,
                              format: (progress) {
                                if (progress == 100) {
                                  return '完成';
                                }
                                return '$progress%';
                              },
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 12),
                      // Row(
                      //   children: [
                      //     Container(
                      //       height: 100,
                      //       width: 100,
                      //       child: EProgress(
                      //         progress: _animation.value,
                      //         type: ProgressType.dashboard,
                      //       ),
                      //     ),
                      //     SizedBox(width: 12),
                      //     Container(
                      //       height: 100,
                      //       width: 100,
                      //       child: EProgress(
                      //         progress: _animation.value,
                      //         type: ProgressType.dashboard,
                      //         colors: [Colors.blue],
                      //         strokeCap: StrokeCap.square,
                      //       ),
                      //     ),
                      //     SizedBox(width: 12),
                      //     Container(
                      //       height: 100,
                      //       width: 100,
                      //       child: EProgress(
                      //         progress: _animation.value,
                      //         type: ProgressType.dashboard,
                      //         colors: [Colors.blue],
                      //         backgroundColor: Colors.black,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 50,
                        // color: Colors.red,
                        child: EProgress(
                          progress: _animation.value,
                          type: ProgressType.liquid,
                          showText: true,
                          textInside: true,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            height: 150,
                            width: 50,
                            child: EProgress(
                              progress: _animation.value,
                              type: ProgressType.liquid,
                              direction: Axis.vertical,
                              showText: true,
                              textInside: true,
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            height: 150,
                            width: 150,
                            child: EProgress(
                              progress: _animation.value,
                              type: ProgressType.liquid,
                              borderColor: Colors.red,
                              borderWidth: 5,
                              radius: 30,
                              showText: true,
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            height: 150,
                            width: 150,
                            child: EProgress(
                              progress: _animation.value,
                              direction: Axis.vertical,
                              type: ProgressType.liquid,
                              borderColor: Colors.blue,
                              borderWidth: 5,
                              showText: true,
                              textInside: true,
                              radius: 300,
                              colors: [
                                Colors.blue,
                                Colors.red,
                                Colors.yellow,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
