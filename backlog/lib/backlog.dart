import 'packages.dart';
import 'package:sentry/sentry.dart';

//Setup for crash reporting
const DSN = 'https://bd24e6c7ee0048aa8c693503caea1e29@o433407.ingest.sentry.io/5400173';
final SentryClient sentry = SentryClient(dsn: DSN);

class Backlog extends StatefulWidget {

  //Error reporting to Sentry
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

  //Initialize theme settings
  void initDark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dark = prefs.getBool('dark') ?? false;
    });
  }

  //Update theme settings when switched
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
      routes: routes,
    );
  }
}