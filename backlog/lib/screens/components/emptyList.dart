import 'package:backlog/packages.dart';

Scaffold emptyList(String appBarTitle, BuildContext context) {
  return Scaffold(
      
    appBar: AppBar(
      title: Text(appBarTitle),
      centerTitle: true,
    ),

    body: Center(child: CircularProgressIndicator()),

    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: addEntryButton(context),

    endDrawer: viewSetting(context, true),
  );
}