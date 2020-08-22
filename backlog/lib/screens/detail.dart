import '../packages.dart';

//Globals to access data from list screens
String selectedImage, selectedTitle, 
  selectedGenre, selectedNotes, 
  selectedMedia, selectedConsole, 
  selectedDate, selectedDoc;
bool selectedCompleted;

class Detail extends StatefulWidget {
  Detail({Key key}) : super(key: key);

  //Routing
  static const routeName = 'detail';

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  @override
  Widget build(BuildContext context) {

    //Appbar
    AppBar appbar = AppBar(
      title: Text('Entry Information'),
      centerTitle: true,
    );

    //Portrait orientation
    if (MediaQuery.of(context).orientation == Orientation.portrait) {

      return Scaffold(
        appBar: appbar,

        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: <Widget> [
                //Title
                FractionallySizedBox(child: Text(selectedTitle, style: TextStyle(fontSize: 30), textAlign: TextAlign.center,), widthFactor: 0.9),
                Flexible(child: FractionallySizedBox(heightFactor: 0.2,)),
                //Image
                FractionallySizedBox(child: Image.network(selectedImage), widthFactor: 0.9),
                //Media Type
                FractionallySizedBox(child: Text('Media Type: ' + selectedMedia, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
                //Console
                FractionallySizedBox(child: Text('Console: ' + selectedConsole, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
                //Genre
                FractionallySizedBox(child: Text('Genre: ' + selectedGenre, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
                //Date
                FractionallySizedBox(child: Text('Date added: ' + selectedDate, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
                //Notes
                FractionallySizedBox(child: Text('Notes: ' + selectedNotes, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
                //Completed
                FractionallySizedBox(child: Text('Completed: ' + selectedCompleted.toString(), style: TextStyle(fontSize: 20),), widthFactor: 0.9),
              ],
            ),
          ),
        ),

        endDrawer: editDrawer(context, selectedCompleted, selectedDoc),
      );

    //Landscape Orientation
    } else {
      //Height of remaining space (Screen - appbar - title - padding)
      var remainHeight = MediaQuery.of(context).size.height - 150;
      //Width of remaining space (Screen - padding)
      var remainWidth = MediaQuery.of(context).size.width - 24;
      
      return Scaffold(
        appBar: appbar,

        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children:<Widget> [
              //Title
              Center(child: Text(selectedTitle, style: TextStyle(fontSize: 30))),
              SizedBox(height: 8),

              //Row with two columns
              Row(children: [
                //Column 1
                SizedBox(
                  height: remainHeight,
                  width: remainWidth / 2,
                  child: Column(children: [
                    //Image
                    FractionallySizedBox(child: Image.network(selectedImage), widthFactor: 0.8,),
                    Flexible(child: FractionallySizedBox(heightFactor: 0.4,)),
                    //Completed
                    FractionallySizedBox(child: Text('Completed: ' + selectedCompleted.toString(), style: TextStyle(fontSize: 30),), widthFactor: 0.9),
                  ]), 
                ),

                //Column 2
                SizedBox(
                  height: remainHeight,
                  width: remainWidth / 2,
                  child: Column(children: [
                    //Media Type
                    FractionallySizedBox(child: Text('Media Type: ' + selectedMedia, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                    Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
                    //Console
                    FractionallySizedBox(child: Text('Console: ' + selectedConsole, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                    Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
                    //Genre
                    FractionallySizedBox(child: Text('Genre: ' + selectedGenre, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                    Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
                    //Date
                    FractionallySizedBox(child: Text('Date added: ' + selectedDate, style: TextStyle(fontSize: 20),), widthFactor: 0.9),
                    Flexible(child: FractionallySizedBox(heightFactor: 0.1,)),
                    //Notes
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