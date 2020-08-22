import '../packages.dart';

class NewEntry extends StatefulWidget {
  //Routing
  static const routeName = 'newEntry';

  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  //Form and database setup
  final formKey = GlobalKey<FormState>();
  File image;
  final picker = ImagePicker();
  final backDB = Firestore.instance;

  //Input data variables
  String url, media, console;
  bool completed = false;

  //Load selected image into widget
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile.path);
    });
  }

  //Add data to database
  Future<void> addData(String collectionName, String consoleName) async {
    //Create new document reference to grab document ID
    final newDoc = await backDB.collection(collectionName).add({
      'title': title,
    });

    //Set data in place in new document
    newDoc.setData({
      'imageURL': url,
      'title': title,
      'date': DateTime.now(),
      'media': media,
      'genre': genre,
      'notes': notes,
      'completed': completed,
      'console': consoleName,
      'documentID': newDoc.documentID,
    });
  }

  //Send data to firebase storage and cloud database
  Future postImage() async {
    //Uploading image onto storage
    String base = basename(image.path);
    StorageReference storageReference = 
      FirebaseStorage.instance.ref().child(base);
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    url = await storageReference.getDownloadURL();

    //Logic to add entry to database
    if (completed) {
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

  //Button to post image
  Semantics postButton(BuildContext context) {
    return Semantics(
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
    );
  }

  //Completed check box
  CheckboxListTile completedBox() {
    return CheckboxListTile(
      title: const Text('Completed'),
      value: completed,
      onChanged: (value) {
        setState(() {
          completed = value;
        });
      },
    );
  }

  //Image
  Flexible showImage(int flexValue) {
    return Flexible(
      child: Image.file(image),
      flex: flexValue,
    );
  }

  //Grab image as soon as screen opens
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
      return emptyList('New Entry', context);

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
                  showImage(3),

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

                  //COMPLETED CHECKBOX
                  completedBox(),

                ]
              )
            ),
          ),

          //Button to post entry
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
                        showImage(1),

                        //COMPLETED BOX
                        completedBox(),
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