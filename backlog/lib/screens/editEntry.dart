import 'dart:io';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../packages.dart';
import '../src/consoles.dart';
import '../src/mediaTypes.dart';
import '../src/routing.dart';

class EditEntry extends StatefulWidget {
  static const routeName = 'editEntry';

  @override
  _EditEntryState createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  final formKey = GlobalKey<FormState>();
  File image = File(selectedImage);
  final backDB = Firestore.instance;

  //Input Data
  String title, genre, notes, media, console;
  bool completed = false;

  //Send data to firebase storage and cloud database
  Future editEntry() async {
    if (selectedCompleted) {
      if (media == 'Video Game') {
        final editDoc = backDB.collection('completed').document(selectedDoc);

        editDoc.setData({
          'imageURL': selectedImage,
          'title': title,
          'date': DateTime.now(),
          'media': media,
          'genre': genre,
          'notes': notes,
          'completed': selectedCompleted,
          'console': console,
          'documentID': editDoc.documentID,
        });

      } else {
        final editDoc = backDB.collection('completed').document(selectedDoc);

        editDoc.setData({
          'imageURL': selectedImage,
          'title': title,
          'date': DateTime.now(),
          'media': media,
          'genre': genre,
          'notes': notes,
          'completed': selectedCompleted,
          'console': 'N/A',
          'documentID': editDoc.documentID,
        });
      }

    } else {
      if (media == 'Video Game') {
        final editDoc = backDB.collection('backlog').document(selectedDoc);

        editDoc.setData({
          'imageURL': selectedImage,
          'title': title,
          'date': DateTime.now(),
          'media': media,
          'genre': genre,
          'notes': notes,
          'completed': selectedCompleted,
          'console': console,
          'documentID': editDoc.documentID,
        });

      } else {
        final editDoc = backDB.collection('backlog').document(selectedDoc);

        editDoc.setData({
          'imageURL': selectedImage,
          'title': title,
          'date': DateTime.now(),
          'media': media,
          'genre': genre,
          'notes': notes,
          'completed': selectedCompleted,
          'console': 'N/A',
          'documentID': editDoc.documentID,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    //If image is loading into widget
    if (image == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Edit Entry'),
          centerTitle: true,
        ),

        body: Center(child: CircularProgressIndicator()),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            
          },
          tooltip: 'Post',
          child: Icon(Icons.add),
        ),
      );

    //Image is loaded
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Edit Entry'),
          centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [

                //IMAGE
                Flexible(
                  child: Image(image: NetworkImage(selectedImage)),
                  flex: 3,
                ),

                //TITLE
                Flexible(
                  flex: 1,
                  child: TextFormField(                   
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: TextEditingController(text: selectedTitle),
                    onSaved: (value) {
                      if (value.isNotEmpty) {
                        title = value;
                      }
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Title';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                //GENRE
                Flexible(
                  flex: 1,
                  child: TextFormField(                   
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Genre'),
                    controller: TextEditingController(text: selectedGenre),
                    onSaved: (value) {
                      if (value.isNotEmpty) {
                        genre = value;
                      }
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Genre';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                
                //NOTES
                Flexible(
                  flex: 1,
                  child: TextFormField(                   
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Notes'),
                    controller: TextEditingController(text: selectedNotes),
                    onSaved: (value) {
                      if (value.isNotEmpty) {
                        notes = value;
                      }
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Notes';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                //MEDIA TYPE
                DropDownFormField(
                  titleText: 'Media Type',
                  hintText: 'Please choose one',
                  value: media,
                  onSaved: (value) {
                    setState(() {
                      media = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      media = value;
                    });
                  },
                  dataSource: mediaTypes,
                  textField: 'display',
                  valueField: 'value',
                ),

                //CONSOLE
                DropDownFormField(
                  titleText: 'Console',
                  hintText: 'Please choose one',
                  value: console,
                  onSaved: (value) {
                    setState(() {
                      console = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      console = value;
                    });
                  },
                  dataSource: consoles,
                  textField: 'display',
                  valueField: 'value',
                ),

              ]
            )
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Semantics(
          child: FloatingActionButton(
            onPressed: () {
              formKey.currentState.save();
              if (title != null && genre != null && notes != null) {
                editEntry();
                pushBacklogList(context);
              } else {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('You didn\'t enter an entry!'),
                    content: Text('Fill out the Title, Genre, and Notes please'),
                    actions: <Widget>[
                      FlatButton(child: Text('Ok fine!'), onPressed: () {Navigator.of(context).pop();},),
                      FlatButton(child: Text('I guess...'), onPressed: () {Navigator.of(context).pop();},),
                    ],
                  ),
                  barrierDismissible: true,
                );
              }
            },
            tooltip: 'Post',
            child: Icon(Icons.add),
          ),
          button: true,
          enabled: true,
        ),
      );
    }
  }
}