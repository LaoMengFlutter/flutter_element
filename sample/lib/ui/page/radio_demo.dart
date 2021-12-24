import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:element_ui/widgets.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ERadioGroup(
              radios: [
                ERadioItem(
                  value: '1',
                  label: '备选项1',
                ),
                ERadioItem(
                  value: '2',
                  label: '备选项2',
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            ERadioGroup(
              radios: [
                ERadioItem(
                  value: '1',
                  label: '禁用',
                  enable: false,
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
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              child: ERadioButtonGroup(
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
            SizedBox(
              height: 12,
            ),
            ERadioGroup(
              style: ERadioStyle(
                  fontColor: Colors.black, checkedFontColor: Colors.red),
              radios: [
                ERadioItem(
                  value: '1',
                  label: '备选项1',
                ),
                ERadioItem(
                  value: '2',
                  label: '备选项2',
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            ERadioGroup(
              style: ERadioStyle(
                  backgroundColor: Colors.grey.withOpacity(.5),
                  checkedBackgroundColor: Colors.red,
                  checkedFontColor: Colors.blue),
              radios: [
                ERadioItem(
                  value: '1',
                  label: '备选项1',
                ),
                ERadioItem(
                  value: '2',
                  label: '备选项2',
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            ERadioGroup(
              style: ERadioStyle(
                  borderColor: Colors.grey.withOpacity(.3),
                  checkedBorderColor: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              border: true,
              radios: [
                ERadioItem(
                  value: '1',
                  label: '备选项1',
                ),
                ERadioItem(
                  value: '2',
                  label: '备选项2',
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
