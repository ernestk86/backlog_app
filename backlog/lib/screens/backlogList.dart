import '../packages.dart';

class BacklogList extends StatefulWidget {
  BacklogList({Key key}) : super(key: key);

  //Routing
  static const routeName = '/';

  @override
  _BacklogListState createState() => _BacklogListState();
}

class _BacklogListState extends State<BacklogList> {

  final backDB = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    //Order documents by their date
    backDB.collection("backlog").orderBy("media", descending: true);

    return entryList('Backlog', 'backlog', true);
  }
}