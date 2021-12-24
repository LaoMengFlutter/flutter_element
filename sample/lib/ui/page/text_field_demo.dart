import 'package:flutter/material.dart';
import 'package:element_ui/widgets.dart';

class TextFieldDemo extends StatefulWidget {
  const TextFieldDemo({Key? key}) : super(key: key);

  @override
  State<TextFieldDemo> createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 12, width: double.infinity),
              ETextField(),
              SizedBox(height: 12),
              ETextField(
                placeholder: 'please input',
              ),
              SizedBox(height: 12),
              ETextField(
                placeholder: 'please input',
                placeholderTextStyle: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 12),
              ETextField(
                value: 'Flutter Element1',
                height: 30,
                textStyle: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 12),
              ETextField(
                value: 'Flutter Element',
                textStyle: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 12),
              ETextField(
                height: 30,
                value: 'Flutter Element',
              ),
              SizedBox(height: 12),
              ETextField(
                height: 140,
                value: 'Flutter Element',
              ),
              SizedBox(height: 12),
              ETextField(
                height: 130,
                placeholder: 'please input',
              ),
              SizedBox(height: 12),
              ETextField(
                value: 'Flutter Element',
                placeholder: 'please input',
                style: ETextFieldStyle(
                  fontColor: Colors.red,
                  backgroundColor: Colors.yellow,
                  placeholderColor: Colors.red.withOpacity(.5),
                  borderColor: Colors.green,
                  focusBorderColor: Colors.blue,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              SizedBox(height: 12),
              ETextField(
                placeholder: 'please input',
                clear: true,
              ),
              SizedBox(height: 12),
              ETextField(
                obscureText: true,
              ),
              SizedBox(height: 12),
              ETextField(
                obscureText: true,
                showPassword: true,
              ),
              SizedBox(height: 12),
              ETextField(
                placeholder: 'please input',
                obscureText: true,
                showPassword: true,
                clear: true,
              ),
              SizedBox(height: 12),
              ETextField(
                placeholder: 'please input',
                obscureText: true,
                showPassword: true,
                clear: true,
                suffix: Icon(Icons.date_range_sharp),
              ),
              SizedBox(height: 12),
              ETextField(
                placeholder: 'please input',
                prefix: Icon(Icons.search),
              ),
              SizedBox(height: 12),
              ETextField(
                height: 200,
                placeholder: 'please input',
                maxLines: 10,
              ),
              SizedBox(height: 12),
              ETextField(
                showWordLimit: true,
                maxLength: 10,
              ),
              SizedBox(height: 12),
              ETextField(
                height: 200,
                maxLines: 10,
                showWordLimit: true,
                maxLength: 100,
              ),
              SizedBox(height: 12),
              ETextField(
                height: 200,
                maxLines: 10,
                showWordLimit: true,
                maxLength: 100,
                limitBuilder: (context, length, maxLength) {
                  return Row(
                    children: [
                      Text(
                        '$length',
                        style: const TextStyle(color: Colors.red),
                      ),
                      Text('/$maxLength'),
                    ],
                  );
                },
              ),

              SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
