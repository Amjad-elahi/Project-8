import 'package:flutter/material.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:onze_cofe_project/screens/Home_screen/home_screen.dart';
import 'package:onze_cofe_project/screens/auth/login_screen.dart';
import 'package:onze_cofe_project/screens/employee_screens/orders_screen.dart';
import 'package:onze_cofe_project/screens/welcome_screen/welcome_screen.dart';
import 'dart:async';

import 'package:onze_cofe_project/setup/setup_init.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // Navigate to the home screen after the splash screen
      if (getIt.get<DataLayer>().firstTimeJoin == "true") {
        if (getIt.get<DataLayer>().currentUserInfo != null) {
          if (getIt.get<DataLayer>().currentUserInfo!['role'] == 'user') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => OrdersScreen()),
            );
          }
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      }
      if (getIt.get<DataLayer>().firstTimeJoin == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: CustomBackgroundContainer(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 40),
                    Image.asset(
                      'assets/images/onze.png',
                      width: 188.53,
                      height: 47.73,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/line.png',
                            width: 41.53,
                            height: 0.7,
                            fit: BoxFit.contain,
                          ),
                          Image.asset(
                            'assets/images/cafe.png',
                            width: 82.53,
                            height: 17.73,
                            fit: BoxFit.contain,
                          ),
                          Image.asset(
                            'assets/images/line.png',
                            width: 41.53,
                            height: 0.7,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/background_coffee.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
