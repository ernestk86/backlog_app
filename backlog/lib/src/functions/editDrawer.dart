import '../../packages.dart';

Widget editDrawer(BuildContext context, bool completed, String doc) {
  DocumentReference entry;
  final backDB = Firestore.instance;

  Future<void> addData(String console) async {
    final newDoc = await backDB.collection('completed').add({
      'title': selectedTitle,
    });

    newDoc.setData({
      'imageURL': selectedImage,
      'title': selectedTitle,
      'date': DateTime.now(),
      'media': selectedMedia,
      'genre': selectedGenre,
      'notes': selectedNotes,
      'completed': true,
      'console': console,
      'documentID': newDoc.documentID,
    });
  }

  return Drawer(
    child: ListView(
      children: <Widget>[
        ListTile(title: Text('Edit or Delete')),

        Divider(
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),

        //Delete Button
        ListTile(
          title: const Text('Delete?'),
          trailing:  RaisedButton(
            child: Text('DELETE'),
            onPressed: () {
              //Check which collection to delete
              if (completed) {
                entry = backDB.collection('completed').document(doc);
                entry.delete();
                pushCompletedList(context);
              } else {
                entry = backDB.collection('backlog').document(doc);
                entry.delete();
                pushBacklogList(context);
              }
            },
          ),
        ),

        //Edit button
        ListTile(
          title: const Text('Edit?'),
          trailing:  RaisedButton(
            child: Text('EDIT'),
            onPressed: () {
              pushEditEntry(context);
            },
          ),
        ),

        Divider(
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),

        //Complete button
        ListTile(
          title: const Text('Completed?'),
          trailing:  RaisedButton(
            child: Text('COMPLETE'),
            onPressed: () async {
              if (!completed) {
                entry = backDB.collection('backlog').document(doc);
                entry.delete();
                if (selectedMedia == 'Video Game') {
                  addData(selectedConsole);
                } else {
                  addData('N/A');
                }
                pushCompletedList(context);
              }
            },
          ),
        ),
      ],
    )
  );
}