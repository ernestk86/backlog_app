import '../packages.dart';

class EditEntry extends StatefulWidget {
  //Routing
  static const routeName = 'editEntry';

  @override
  _EditEntryState createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  final formKey = GlobalKey<FormState>();
  final backDB = Firestore.instance;

  //Input Data
  String media, console;
  bool completed = false;

  //Add data to database
  Future<void> addData(String collectionName, String consoleName) async {
    final editDoc = backDB.collection(collectionName).document(selectedDoc);

    editDoc.setData({
      'imageURL': selectedImage,
      'title': title,
      'date': DateTime.now(),
      'media': media,
      'genre': genre,
      'notes': notes,
      'completed': selectedCompleted,
      'console': consoleName,
      'documentID': editDoc.documentID,
    });
  }

  //Send data to cloud database
  Future editEntry() async {
    if (selectedCompleted) {
      if (media == 'Video Game') {
        addData('completed', console);
      } else {
        addData('completed', 'N/A');
      }
    } else {
      if (media == 'Video Game') {
        addData('backlog', console);
      } else {
        addData('backlog', 'N/A');
      }
    }
  }

  //Image
  Flexible showImage(int flexValue) {
    return Flexible(
      child: Image.network(selectedImage),
      flex: flexValue,
    );
  }

  //Button to post image
  Semantics postButton(BuildContext context) {
    return Semantics(
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
    );
  }

  @override
  Widget build(BuildContext context) {

    AppBar appbar = AppBar(
      title: Text('Edit Entry'),
      centerTitle: true,
    );

    //If image is loading into widget
    if (Image.network(selectedImage) == null) {
      return emptyList('Edit Entry', context);

    //Image is loaded
    } else {
      //Portrait orientation
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
                  showImage(1),

                  //TITLE
                  inputText('Title', 1),
                  
                  //GENRE
                  inputText('Genre', 1),
                  
                  //NOTES
                  inputText('Notes', 1),
                  
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
          floatingActionButton: postButton(context),
        );

      //Landscape Orientation
      } else {
        //Remaining space on screen after accounting for appbar, padding, etc...
        var remainHeight = MediaQuery.of(context).size.height - 120;
        var remainWidth = MediaQuery.of(context).size.width - 24;
        
        return Scaffold(
          appBar: appbar,

          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                children:<Widget> [
                  //In landscape screen is split in half horizontally
                  Row(children: [

                    //Left half of screen
                    SizedBox(
                      height: remainHeight,
                      width: remainWidth / 2,
                      child: Column(children: [
                        //IMAGE
                        showImage(1)
                      ]), 
                    ),

                    Spacer(),

                    //Right half of screen
                    SizedBox(
                      height: remainHeight,
                      width: remainWidth / 2,
                      child: Column(children: [
                        //TITLE
                        inputText('Title', 1),

                        //GENRE
                        inputText('Genre', 1),
                        
                        //NOTES
                        inputText('Notes', 3),

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

          //Button to post entry
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: postButton(context),
        );
      }
    }
  }
}