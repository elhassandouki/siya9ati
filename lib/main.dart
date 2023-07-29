import 'package:flutter/material.dart';
import 'package:syi9a/screens/quiz/category.dart';
import 'package:syi9a/screens/mohim/mohim.dart';
import 'package:syi9a/screens/moukhalfat/moukhalafat.dart';
import 'package:syi9a/screens/signals/category_signals.dart';
import 'package:syi9a/screens/cours/cours.dart';
import 'package:syi9a/screens/soal/soal.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';
import 'screens/mawa9if/mawa9if.dart';
import 'screens/modawana/modawana.dart';
import 'theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // screen portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  //one signal
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("f39ecf8c-a354-44a4-91e2-cebb407226f1");

  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme(),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        initialRoute: "/",
        routes: <String, WidgetBuilder>{
          "/quiz": (BuildContext context) => CategoryPage(),
          "/course": (BuildContext context) => const CoursesPage(),
          "/categorysignals": (BuildContext context) => CategorySignalsPage(),
          "/mawa9if": (BuildContext context) => Mawa9ifPage(),
          "/modawana": (BuildContext context) => ModawanaPage(),
          "/moukhalafat": (BuildContext context) => MoukhalafatPage(),
          "/soal": (BuildContext context) => QAPage(),
          "/mohim": (BuildContext context) => MohimPage(),
        });
  }
}
