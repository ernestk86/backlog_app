import 'package:backlog/src/models/darkSwitch.dart';
import 'package:backlog/src/routing.dart';
import 'package:flutter/material.dart';

Widget viewSetting(BuildContext context, String currentScreen) {

  return Drawer(
    child: ListView(
      children: <Widget>[
        ListTile(title: Text('Settings')),
        Divider(
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
        ListTile(
          title: const Text('Switch to other list?'),
          trailing:  RaisedButton(
            child: Text('Switch'),
            onPressed: () {
              if (currentScreen == 'backlog') {
                pushCompletedList(context);
              } else {
                pushBacklogList(context);
              }
            },
          ),
        ),
        DarkSwitch(),
      ],
    )
  );
}