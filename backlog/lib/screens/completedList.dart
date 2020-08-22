import '../packages.dart';

class CompletedList extends StatefulWidget {
  CompletedList({Key key}) : super(key: key);

  //Routing
  static const routeName = 'completedList';

  @override
  _CompletedListState createState() => _CompletedListState();
}

class _CompletedListState extends State<CompletedList> {

  final completedDB = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    //Order documents by their date
    completedDB.collection("completed").orderBy("media");

    return entryList('Completed', 'completed', false);
  }
}