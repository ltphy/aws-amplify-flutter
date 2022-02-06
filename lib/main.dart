import 'package:aws_amplify_flutter/screens/entry/entry.dart';
import 'package:aws_amplify_flutter/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'amplifyconfiguration.dart';
import 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
  }

  Future<void> _configureAmplify() async {
    final auth = AmplifyAuthCognito();
    final analytics = AmplifyAnalyticsPinpoint();
    await Amplify.addPlugins([auth, analytics]);
    // Once Plugins are added, configure Amplify
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Amplify was already configured. Looks like app restarted on android.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _configureAmplify(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.hasError) {
          return Container(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Time Tracker',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: EntryScreen.route,
            onGenerateRoute: RouteConfiguration.onGenerateRoute,
          );
        }
        return CustomProgressIndicator();
      },
    );
  }
}
