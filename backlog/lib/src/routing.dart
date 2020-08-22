import '../packages.dart';

//Routes
final routes = {
  BacklogList.routeName: (context) => BacklogList(),
  Detail.routeName: (context) => Detail(),
  NewEntry.routeName: (context) => NewEntry(),
  EditEntry.routeName: (context) => EditEntry(),
  CompletedList.routeName: (context) => CompletedList(),
};

//Route functions
void goBack(BuildContext context) {
  Navigator.of(context).pop();
}

void pushNewEntry(BuildContext context) {
  Navigator.of(context).pushNamed(NewEntry.routeName);
}

void pushEditEntry(BuildContext context) {
  Navigator.of(context).pushNamed(EditEntry.routeName);
}

void pushDetail(BuildContext context) {
  Navigator.of(context).pushNamed(Detail.routeName);
}

void pushBacklogList(BuildContext context) {
  Navigator.of(context).pushNamed(BacklogList.routeName);
}

void pushCompletedList(BuildContext context) {
  Navigator.of(context).pushNamed(CompletedList.routeName);
}