import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class ButtonPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  List<String> _checked = ["A", "B"];
  String _picked = "Two";

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(" Buttons "),
      ),
      body: _body(),
    );
    //
  }

  Widget _body(){
    return ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 14.0, top: 14.0),
            child: Text("CheckboxGroup",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
            ),
          ),
          CheckboxGroup(
            labels: <String>[
              "Sunday",
              "Monday",
              "Tuesday",
              "Wednesday",
              "Thursday",
              "Friday",
              "Saturday",
            ],
            disabled: [
              "Wednesday",
              "Friday"
            ],
            onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
            onSelected: (List<String> checked) =>  Fluttertoast.showToast(msg:"Selected: $checked"),
          ),
          Container(
            padding: const EdgeInsets.only(left: 14.0, top: 14.0),
            child: Text(" RadioButtonGroup",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
            ),
          ),
          RadioButtonGroup(
            labels: [
              "Option 1",
              "Option 2",
            ],
            disabled: [
              "Option 1"
            ],
            onChange: (String label, int index) =>Fluttertoast.showToast(msg:"Selected"+ label ),
            onSelected: (String label) => print(label),
          ),
          ///CUSTOM CHECKBOX GROUP
          Container(
            padding: const EdgeInsets.only(left: 14.0, top: 14.0, bottom: 14.0),
            child: Text("Custom CheckboxGroup",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
            ),
          ),

          CheckboxGroup(
            orientation: GroupedButtonsOrientation.HORIZONTAL,
            margin: const EdgeInsets.only(left: 12.0),
            onSelected: (List selected) => setState((){
              _checked = selected;
            }),
            labels: <String>[
              "A",
              "B",
            ],
            checked: _checked,
            itemBuilder: (Checkbox cb, Text txt, int i){
              return Column(
                children: <Widget>[
                  Icon(Icons.polymer),
                  cb,
                  txt,
                ],
              );
            },
          ),
          ///CUSTOM RADIOBUTTON GROUP
          Container(
            padding: const EdgeInsets.only(left: 14.0, top: 14.0, bottom: 14.0),
            child: Text("Custom RadioButtonGroup",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
            ),
          ),

          RadioButtonGroup(
            orientation: GroupedButtonsOrientation.HORIZONTAL,
            margin: const EdgeInsets.only(left: 12.0),
            onSelected: (String selected) => setState((){
              _picked = selected;
            }),
            labels: <String>[
              "One",
              "Two",
            ],
            picked: _picked,
            itemBuilder: (Radio rb, Text txt, int i){
              return Column(
                children: <Widget>[
                  Icon(Icons.public),
                  rb,
                  txt,
                ],
              );
            },
          ),

        ]
    );
  }
}