import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element/widgets.dart';

class RadioDemo extends StatelessWidget {
  const RadioDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ERadioGroup(
              radios: [
                ERadioItem(
                  value: '1',
                  label: '备选项',
                ),
                ERadioItem(
                  value: '2',
                  label: '备选项',
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            ERadioGroup(
              selectValue: '1',
              onChanged: (value) {
                print('ERadioGroup onChanged value:$value');
              },
              radios: [
                ERadioItem(
                  value: '1',
                  label: '备选项1',
                ),
                ERadioItem(
                  value: '2',
                  label: '备选项2',
                ),
                ERadioItem(
                  value: '3',
                  label: '备选项3',
                ),
                ERadioItem(
                  value: '4',
                  label: '备选项4',
                ),
                ERadioItem(
                  value: '5',
                  label: '备选项5',
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              child: ERadioButtonGroup(
                selectValue: '2',
                style: ERadioStyle(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                radios: [
                  ERadioItem(
                    value: '1',
                    label: '北京',
                  ),
                  ERadioItem(
                    value: '2',
                    label: '上海',
                  ),
                  ERadioItem(
                    value: '3',
                    label: '广州',
                  ),
                  ERadioItem(
                    value: '4',
                    label: '深圳',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
