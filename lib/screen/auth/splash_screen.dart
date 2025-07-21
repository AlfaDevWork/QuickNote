
import 'package:flutter/material.dart';
import 'package:quicknote/helper/preference.dart';
import 'package:quicknote/screen/auth/landing_screen.dart';
import 'package:quicknote/screen/home.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changePage() {
    Future.delayed(Duration(seconds: 1), () async {
      bool isLogin = await PreferenceHandler.getLogin();

      if (isLogin) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.id,
          (Route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LandingScreen.id,
          (route) => false,
        );
      }
    });
  }

  @override
  void initState() {
    changePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Spacer(),
            // Image.asset('assets/images/Logo.png'),
            Image(image: AssetImage('assets/images/Logo.png')),
            Spacer(),
            SafeArea(child: Text('V 1.0.0', style: TextStyle(fontSize: 10))),
          ],
        ),
      ),
    );
  }
}
