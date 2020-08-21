import 'package:backlog/src/functions/editDrawer.dart';
import 'package:flutter/material.dart';
import '../packages.dart';

String selectedImage, selectedTitle, selectedGenre, selectedNotes, selectedMedia, selectedConsole, selectedDate, selectedDoc;
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

    AppBar appbar = AppBar(
      title: Text('Entry Information'),
      centerTitle: true,
    );

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      // print(MediaQuery.of(context).size.height.toString());
      // print(MediaQuery.of(context).size.width.toString());
      // print(appbar.preferredSize.height.toString());

      return Scaffold(
        appBar: appbar,

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

        endDrawer: editDrawer(context, selectedCompleted, selectedDoc),
      );
    } else {
      // print(MediaQuery.of(context).size.height.toString());
      // print(MediaQuery.of(context).size.width.toString());
      // print(appbar.preferredSize.height.toString());

      var remainHeight = MediaQuery.of(context).size.height - 150;
      var remainWidth = MediaQuery.of(context).size.width - 24;
      
      return Scaffold(
        appBar: appbar,

        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children:<Widget> [
              Center(child: Text(selectedTitle, style: TextStyle(fontSize: 30))),
              SizedBox(height: 8),

              Row(children: [
                SizedBox(
                  height: remainHeight,
                  width: remainWidth / 2,
                  child: Column(children: [
                    FractionallySizedBox(child: Image.network(selectedImage), widthFactor: 0.8,),
                    Flexible(child: FractionallySizedBox(heightFactor: 0.4,)),
                    FractionallySizedBox(child: Text('Completed: ' + selectedCompleted.toString(), style: TextStyle(fontSize: 30),), widthFactor: 0.9),
                  ]), 
                ),

                SizedBox(
                  height: remainHeight,
                  width: remainWidth / 2,
                  child: Column(children: [
                    FractionallySizedBox(child: Text('Media Type: ' + selectedMedia, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                    Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
                    FractionallySizedBox(child: Text('Console: ' + selectedConsole, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                    Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
                    FractionallySizedBox(child: Text('Genre: ' + selectedGenre, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                    Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
                    FractionallySizedBox(child: Text('Date added: ' + selectedDate, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                    Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
                    FractionallySizedBox(child: Text('Notes: ' + selectedNotes, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                  ]), 
                ),
              ])
            ]
          ),               
        ),

        endDrawer: editDrawer(context, selectedCompleted, selectedDoc),
      );       
    }
  }
}