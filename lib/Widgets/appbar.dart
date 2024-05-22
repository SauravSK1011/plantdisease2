import 'package:flutter/material.dart';
import 'package:plantdisease/Services/Auth.dart';
import 'package:plantdisease/constants/constants.dart';

void showInputDialog(BuildContext context) {
  String userInput = '';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Url:'),
        content: TextField(
          onChanged: (value) {
            userInput = value;
          },
          decoration: InputDecoration(hintText: 'Enter text'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Constants.url = userInput;
              print('User input: $userInput');
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}

AppBar MyAppbar(BuildContext context) {
  return AppBar(
    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween  ,
      children: [
        Text("Plant Disease"),
        IconButton(
            onPressed: () {
              showInputDialog(context);
            },
            icon: Icon(Icons.edit_note_rounded)),
            IconButton(
            onPressed: () {
              Auth().logout(context);
            },
            icon: Icon(Icons.logout))
      ],
    ),
  );
}
