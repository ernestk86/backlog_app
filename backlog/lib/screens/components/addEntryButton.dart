import 'package:backlog/packages.dart';

Semantics addEntryButton(BuildContext context) {
  return Semantics(
    child: FloatingActionButton(
      onPressed: () {
        pushNewEntry(context);
      },
      tooltip: 'Add Entry',
      child: Icon(Icons.camera_alt)
    ),
    button: true,
    enabled: true,   
  );
}