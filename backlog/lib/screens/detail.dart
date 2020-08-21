import 'package:flutter/material.dart';
import '../packages.dart';

String selectedImage, selectedTitle, selectedGenre, selectedNotes, selectedMedia, selectedConsole, selectedDate;
bool selectedCompleted;

class Detail extends StatefulWidget {
  Detail({Key key}) : super(key: key);

  static const routeName = 'detail';

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entry Information'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: <Widget> [
              FractionallySizedBox(child: Text(selectedTitle, style: TextStyle(fontSize: 30), textAlign: TextAlign.center,), widthFactor: 0.9),
              Flexible(child: FractionallySizedBox(heightFactor: 0.2,)),
              FractionallySizedBox(child: Image.network(selectedImage), widthFactor: 0.9),
              FractionallySizedBox(child: Text('Media Type: ' + selectedMedia, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
              Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
              FractionallySizedBox(child: Text('Console: ' + selectedConsole, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
              Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
              FractionallySizedBox(child: Text('Genre: ' + selectedGenre, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
              Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
              FractionallySizedBox(child: Text('Date added: ' + selectedDate, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
              Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
              FractionallySizedBox(child: Text('Notes: ' + selectedNotes, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
              Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
             FractionallySizedBox(child: Text('Completed: ' + selectedCompleted.toString(), style: TextStyle(fontSize: 20),), widthFactor: 0.9),
            ],
          ),
        ),
      ),
    );
  }
}