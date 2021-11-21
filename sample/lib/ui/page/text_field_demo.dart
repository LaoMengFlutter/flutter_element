import 'package:flutter/material.dart';
import 'package:flutter_element/widgets.dart';

class TextFieldDemo extends StatelessWidget {
  const TextFieldDemo({Key? key}) : super(key: key);

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
                value: 'element',
                placeholder: 'please input',
              ),
              SizedBox(height: 12),
              ETextField(
                value: 'element',
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
                placeholder: 'please input',
                obscureText: true,
              ),
              SizedBox(height: 12),
              ETextField(
                placeholder: 'please input',
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
              Container(
                height: 200,
                child: ETextField(
                  placeholder: 'please input',
                  maxLines: 10,
                ),
              ),
              SizedBox(height: 12),
              ETextField(
                showWordLimit: true,
                maxLength: 10,
              ),
              SizedBox(height: 12),
              Container(
                height: 200,
                child: ETextField(
                  placeholder: 'please input',
                  maxLines: 10,
                  showWordLimit: true,
                  maxLength: 100,
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
