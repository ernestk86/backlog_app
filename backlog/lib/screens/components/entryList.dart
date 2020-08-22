import 'package:backlog/packages.dart';

StreamBuilder entryList(String screenTitle, String collectionName, bool backlogScreen) {
  return StreamBuilder(
    stream: Firestore.instance.collection(collectionName).snapshots(),
    builder: (context, snapshot) {
      //If there are posts
      if (snapshot.data.documents.length > 0) {
        return Scaffold(

          appBar: AppBar(
            title: Text(screenTitle),
            centerTitle: true,
          ),

          endDrawer: viewSetting(context, backlogScreen),

          body: ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              //Grab entry
              var entry = snapshot.data.documents[index];
              //Extract date
              DateTime dateTime = entry['date'].toDate();
              //Convert date to string
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
                  selectedDoc = entry['documentID'];
                  pushDetail(context);
                },
              );
            },
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: addEntryButton(context)
        );
      //If there are no posts
      } else {
        return emptyList(screenTitle, context);
      }
    }
  );
}