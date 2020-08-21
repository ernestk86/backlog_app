import 'package:flutter/material.dart';
import '../../backlog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkSwitch extends StatefulWidget {
  DarkSwitch({Key key}) : super(key: key);

  @override
  _DarkSwitchState createState() => _DarkSwitchState();
}

class _DarkSwitchState extends State<DarkSwitch> {
  bool _dark;

  void initState() {
    super.initState();
    _dark = false;
    initDark();
  }

  void initDark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dark = prefs.getBool('_dark');
      if (_dark == null) {
        _dark = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    BacklogState appState = context.findAncestorStateOfType();

    return SwitchListTile(
      title: const Text('Dark Mode'),
      value: _dark ,
      onChanged: (bool value) {
        setState(() async {
          _dark = !_dark;
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('_dark', _dark);
          appState.updateTheme();
        });
      }
    );
  }
}