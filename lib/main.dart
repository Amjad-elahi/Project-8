import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onze_cofe_project/screens/Home_screen/home_screen.dart';
import 'package:onze_cofe_project/screens/auth/login_screen.dart';
import 'package:onze_cofe_project/screens/employee_screens/orders_screen.dart';
import 'package:onze_cofe_project/screens/splash_screen/splash_screen.dart';
import 'package:onze_cofe_project/screens/track_order_screen/track_order_screen.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'setup/setup_init.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://atlxmjlltfikucaizoeg.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0bHhtamxsdGZpa3VjYWl6b2VnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjczNzkyNDMsImV4cCI6MjA0Mjk1NTI0M30.tdRENvJ39QV3yoTiEDTagQr7xQ3k-sHENQxwGGEuvF8",
  );

  await setup();
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MainApp(), // Wrap your app
  ));
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("ebdec5c2-30a4-447d-9577-a1c13b6d553e");

  OneSignal.Notifications.requestPermission(true);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const SplashScreen(),
    );
  }
}
