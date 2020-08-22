import '../../packages.dart';

Widget viewSetting(BuildContext context, bool backlogScreen) {
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
              //Logic for which screen to go to
              if (backlogScreen) {
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