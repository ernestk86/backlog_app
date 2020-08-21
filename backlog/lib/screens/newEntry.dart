import 'dart:io';
import 'package:path/path.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../packages.dart';
import '../src/consoles.dart';
import '../src/mediaTypes.dart';
import 'package:image_picker/image_picker.dart';
import '../src/routing.dart';

class NewEntry extends StatefulWidget {
  static const routeName = 'newEntry';

  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  final formKey = GlobalKey<FormState>();
  File image;
  final picker = ImagePicker();
  final backDB = Firestore.instance;

  //Input Data
  String url, title, genre, notes, media, console;
  bool completed = false;


  //Load selected image into widget
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile.path);
    });
  }

  //Send data to firebase storage and cloud database
  Future postImage() async {
    String base = basename(image.path);
    StorageReference storageReference = 
      FirebaseStorage.instance.ref().child(base);
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    url = await storageReference.getDownloadURL();

    if (completed) {
      if (media == 'Video Game') {
        final newDoc = await backDB.collection('completed').add({
          'title': title,
        });

        newDoc.setData({
          'imageURL': url,
          'title': title,
          'date': DateTime.now(),
          'media': media,
          'genre': genre,
          'notes': notes,
          'completed': completed,
          'console': console,
          'documentID': newDoc.documentID,
        });

      } else {
        final newDoc = await backDB.collection('completed').add({
          'title': title,
        });

        newDoc.setData({
          'imageURL': url,
          'title': title,
          'date': DateTime.now(),
          'media': media,
          'genre': genre,
          'notes': notes,
          'completed': completed,
          'console': 'N/A',
          'documentID': newDoc.documentID,
        });
      }

    } else {
      if (media == 'Video Game') {
        final newDoc = await backDB.collection('backlog').add({
          'title': title,
        });

        newDoc.setData({
          'imageURL': url,
          'title': title,
          'date': DateTime.now(),
          'media': media,
          'genre': genre,
          'notes': notes,
          'completed': completed,
          'console': console,
          'documentID': newDoc.documentID,
        });

      } else {
        final newDoc = await backDB.collection('backlog').add({
          'title': title,
        });

        newDoc.setData({
          'imageURL': url,
          'title': title,
          'date': DateTime.now(),
          'media': media,
          'genre': genre,
          'notes': notes,
          'completed': completed,
          'console': 'N/A',
          'documentID': newDoc.documentID,
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: Text('New Entry'),
      centerTitle: true,
    );

    //If image is loading into widget
    if (image == null) {
      return Scaffold(
        appBar: appbar,

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
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        return Scaffold(
          appBar: appbar,

          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget> [

                  //IMAGE
                  Flexible(
                    child: Image.file(image),
                    flex: 3,
                  ),

                  //TITLE
                  Flexible(
                    flex: 1,
                    child: TextFormField(                   
                      autofocus: true,
                      decoration: const InputDecoration(labelText: 'Title'),
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

                  CheckboxListTile(
                    title: const Text('Completed'),
                    value: completed,
                    onChanged: (value) {
                      setState(() {
                        completed = value;
                      });
                    },
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
                  postImage();
                  pushBacklogList(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('You didn\'t enter an entry!'),
                      content: Text('Fill out the Title, Genre, and Notes please'),
                      actions: <Widget>[
                        FlatButton(child: Text('Alright ok!'), onPressed: () {Navigator.of(context).pop();},),
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
      } else {
        var remainHeight = MediaQuery.of(context).size.height - 150;
        var remainWidth = MediaQuery.of(context).size.width - 24;
        
        return Scaffold(
          appBar: appbar,

          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                children:<Widget> [
                  Row(children: [
                    SizedBox(
                      height: remainHeight,
                      width: remainWidth / 2,
                      child: Column(children: [
                        //IMAGE
                        Flexible(
                          child: Image.file(image),
                          flex: 1,
                        ),

                        CheckboxListTile(
                          title: const Text('Completed'),
                          value: completed,
                          onChanged: (value) {
                            setState(() {
                              completed = value;
                            });
                          },
                        ),
                      ]), 
                    ),

                    SizedBox(
                      height: remainHeight,
                      width: remainWidth / 2,
                      child: Column(children: [
                        //TITLE
                        Flexible(
                          flex: 1,
                          child: TextFormField(                   
                            autofocus: true,
                            decoration: const InputDecoration(labelText: 'Title'),
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
                          flex: 3,
                          child: TextFormField(                   
                            autofocus: true,
                            decoration: const InputDecoration(labelText: 'Notes'),
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
                      ]), 
                    ),
                  ])
                ]
              ),
            ),               
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Semantics(
            child: FloatingActionButton(
              onPressed: () {
                formKey.currentState.save();
                if (title != null && genre != null && notes != null) {
                  postImage();
                  pushBacklogList(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('You didn\'t enter an entry!'),
                      content: Text('Fill out the Title, Genre, and Notes please'),
                      actions: <Widget>[
                        FlatButton(child: Text('Alright ok!'), onPressed: () {Navigator.of(context).pop();},),
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
}