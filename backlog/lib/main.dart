import 'packages.dart';

void main() {
  //Setup for device orentiation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);

  //Error handling
  FlutterError.onError = (FlutterErrorDetails details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  //Run app with crash reporting
  runZoned( () {
    runApp(Backlog());
  }, onError: (error, stackTrace) {
    Backlog.reportError(error, stackTrace);
  });
}