import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:paycron/bindings/initial_binding.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/theme.dart';
import 'package:paycron/views/splash/splash_screen.dart';

Future<void> main() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {
        debugPrint("Notification tapped with payload: ${response.payload}");
      }
    },
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.appWhiteColor,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyAppWithLifecycle());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pay Cron',
      theme: AppTheme.theme,
      initialBinding: InitialBinding(),
      home: const SplashScreen(),
    );
  }
}

class AppLifecycleManager extends StatefulWidget {
  final Widget child;

  const AppLifecycleManager({super.key, required this.child});

  @override
  AppLifecycleManagerState createState() => AppLifecycleManagerState();
}

class AppLifecycleManagerState extends State<AppLifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add lifecycle observer
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("App resumed");
        setState(() {});
        break;
      case AppLifecycleState.inactive:
        debugPrint("App inactive");
        break;
      case AppLifecycleState.paused:
        debugPrint("App paused");
        break;
      case AppLifecycleState.detached:
        debugPrint("App detached");
        break;
      case AppLifecycleState.hidden:
        debugPrint("App hidden");
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class MyAppWithLifecycle extends StatelessWidget {
  const MyAppWithLifecycle({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLifecycleManager(
      child: MyApp(),
    );
  }
}
