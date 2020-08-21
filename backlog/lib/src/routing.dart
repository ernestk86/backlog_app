import '../packages.dart';

void goBack(BuildContext context) {
  Navigator.of(context).pop();
}

void pushNewEntry(BuildContext context) {
  Navigator.of(context).pushNamed(NewEntry.routeName);
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