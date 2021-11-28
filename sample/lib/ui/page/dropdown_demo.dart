import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropdownDemo extends StatelessWidget {
  const DropdownDemo({Key? key}) : super(key: key);

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
              SizedBox(height: 600, width: double.infinity),
              DropdownSearch<String>(
                  mode: Mode.MENU,
                  items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                  label: "Menu mode",
                  hint: "country in menu mode",
                  popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: print,
                  selectedItem: "Brazil"),
            ],
          ),
        ),
      ),
    );
  }
}
