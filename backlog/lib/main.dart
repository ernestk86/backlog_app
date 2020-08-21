import 'packages.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);

  FlutterError.onError = (FlutterErrorDetails details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };
  runZoned( () {
    runApp(Backlog());
  }, onError: (error, stackTrace) {
    Backlog.reportError(error, stackTrace);
  });
  
}