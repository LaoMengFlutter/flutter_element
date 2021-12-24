import 'package:element_ui/widgets.dart';
import 'package:flutter/material.dart';

class DropdownDemo extends StatelessWidget {
  const DropdownDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = List.generate(
        100,
        (index) => EDropdownMenuItem(
              child: Text('上海:$index'),
              value: '$index',
              enabled: index != 5,
            )).toList();
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              SizedBox(height: 12, width: double.infinity),
              EDropdown<String>(
                hint: Text('请选择'),
                items: items,
              ),
              SizedBox(height: 12),
              EDropdown<String>(
                value: '1',
                items: items,
              ),
              SizedBox(height: 12),
              EDropdown<String>(
                value: '1',
                onChanged: (value) {
                  print('$value');
                },
                items: items,
              ),
              SizedBox(height: 12),
              EDropdown<String>(
                value: '1',
                isExpanded: false,
                items: items,
              ),
              SizedBox(height: 12),
              EDropdown<String>(
                value: '1',
                items: items,
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
