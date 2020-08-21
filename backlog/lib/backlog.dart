import 'package:backlog/packages.dart';
import 'package:flutter/material.dart';
import 'screens/backlogList.dart';
import 'screens/detail.dart';
import 'screens/newEntry.dart';
import 'package:sentry/sentry.dart';

const DSN = 'https://f41864e4d60f48969665ab71d3437b88@o433407.ingest.sentry.io/5388418';
final SentryClient sentry = SentryClient(dsn: DSN);

class Backlog extends StatefulWidget {
  static final routes = {
    BacklogList.routeName: (context) => BacklogList(),
    Detail.routeName: (context) => Detail(),
    NewEntry.routeName: (context) => NewEntry(),
    CompletedList.routeName: (context) => CompletedList(),
  };

  static Future<void> reportError(dynamic error, dynamic stackTrace) async {
    final SentryResponse response = await sentry.captureException(
      exception: error,
      stackTrace: stackTrace
    );

    if (response.isSuccessful) {
      print('Sentry ID: ${response.eventId}');
    } else {
      print('Failure to report to Sentry: ${response.error}');
    }
  }

  @override
  BacklogState createState() => BacklogState();
}

class BacklogState extends State<Backlog> {
  bool dark;

  void initState() {
    super.initState();
    dark = false;
    initDark();
  }

  void initDark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dark = prefs.getBool('dark') ?? false;
    });
  }

  void updateTheme() async {
    setState(() {
      dark = !dark;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('dark', dark);
  }  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backlog',
      theme: (dark == true) ? ThemeData.dark() : ThemeData.light(),
      routes: Backlog.routes,
    );
  }
}