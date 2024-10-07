import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onze_cofe_project/screens/splash_screen/splash_screen.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'setup/setup_init.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "nop",
    anonKey:
        "nuh uh",
  );

  await setup();
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MainApp(), // Wrap your app
  ));
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize(":p");

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
