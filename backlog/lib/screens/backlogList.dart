import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../src/functions/viewSetting.dart';
import '../src/routing.dart';
import '../src/dateStrings.dart';
import 'detail.dart';

class BacklogList extends StatefulWidget {
  BacklogList({Key key}) : super(key: key);

  static const routeName = 'backlogList';

  @override
  _BacklogListState createState() => _BacklogListState();
}

class _BacklogListState extends State<BacklogList> {

  final backDB = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    //Order documents by their date
    backDB.collection("backlog").orderBy("media");

    return StreamBuilder(
      stream: Firestore.instance.collection('backlog').snapshots(),
      builder: (context, snapshot) {
        //If there are posts
        if (snapshot.data.documents.length > 0) {
          return Scaffold(

            appBar: AppBar(
              title: Text('Backlog'),
              centerTitle: true,
            ),

            //This is solely to TEST CRASH FEATURES
            endDrawer: viewSetting(context, 'backlog'),

            body: ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                var entry = snapshot.data.documents[index];
                DateTime dateTime = entry['date'].toDate();
                String abbrevDate = abbrevDays[dateTime.weekday] + ', ' + abbrevMonths[dateTime.month] + ' ' + dateTime.day.toString() + ', ' + dateTime.year.toString();

                return ListTile(
                  title: Text(entry['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Text(entry['media'], style: TextStyle(fontSize: 20)),
                  onTap: () {
                    //Save values for detail screen
                    selectedDate = abbrevDate;
                    selectedImage = entry['imageURL'];
                    selectedTitle = entry['title'];
                    selectedGenre = entry['genre'];
                    selectedMedia = entry['media'];
                    selectedConsole = entry['console'];
                    selectedCompleted = entry['completed'];
                    selectedNotes = entry['notes'];
                    pushDetail(context);
                  },
                );
              },
            ),

            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Semantics(
              child: FloatingActionButton(
                onPressed: () {
                  pushNewEntry(context);
                },
                tooltip: 'Add Entry',
                child: Icon(Icons.camera_alt)
              ),
              button: true,
              enabled: true,
              
            ),
          );
        //If there are no posts
        } else {
          return Scaffold(
    
            appBar: AppBar(
              title: Text('Backlog'),
              centerTitle: true,
            ),

            body: Center(child: CircularProgressIndicator()),

            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Align(
              alignment: Alignment.bottomCenter,
                          child: FloatingActionButton(
                onPressed: () {
                  pushNewEntry(context);
                },
                tooltip: 'Add Entry',
                child: Icon(Icons.camera_alt)
              ),
            ),
          );
        }
      }
    );
  }
}