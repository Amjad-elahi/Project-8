import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onze_cofe_project/screens/welcome_screen/employee/orders_screen.dart';
import 'package:onze_cofe_project/screens/welcome_screen/welcome_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'setup/setup_init.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://atlxmjlltfikucaizoeg.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0bHhtamxsdGZpa3VjYWl6b2VnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjczNzkyNDMsImV4cCI6MjA0Mjk1NTI0M30.tdRENvJ39QV3yoTiEDTagQr7xQ3k-sHENQxwGGEuvF8",
  );
  setup();

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const OrdersScreen(),
    );
  }
}
