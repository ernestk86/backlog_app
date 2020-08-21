import 'package:backlog/packages.dart';
import 'package:backlog/src/routing.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../packages.dart';

Widget editDrawer(BuildContext context, bool completed, String doc) {
  DocumentReference entry;
  final backDB = Firestore.instance;

  return Drawer(
    child: ListView(
      children: <Widget>[
        ListTile(title: Text('Edit or Delete')),

        Divider(
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
        ListTile(
          title: const Text('Delete?'),
          trailing:  RaisedButton(
            child: Text('DELETE'),
            onPressed: () {
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
        ListTile(
          title: const Text('Completed?'),
          trailing:  RaisedButton(
            child: Text('COMPLETE'),
            onPressed: () async {
              if (!completed) {
                entry = backDB.collection('backlog').document(doc);
                entry.delete();
                if (selectedMedia == 'Video Game') {
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
                    'console': selectedConsole,
                    'documentID': newDoc.documentID,
                  });

                } else {
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
                    'console': 'N/A',
                    'documentID': newDoc.documentID,
                  });
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