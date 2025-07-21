
import 'package:flutter/material.dart';
import 'package:quicknote/screen/auth/login_screen.dart';
import 'package:quicknote/screen/auth/register_screen.dart';
import 'package:quicknote/utils/custom_elevated_button.dart';

class LandingScreen extends StatefulWidget {
  static const String id = "/landing_page";
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child:
                  // Image.asset('assets/images/image.png')
                  Icon(Icons.note_add, size: 120),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  CustomElevatedButton(
                    text: 'Login',
                    textColor: Colors.white,
                    backgroundColor: Colors.black,
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),
                  CustomElevatedButton(
                    text: 'Register',
                    textColor: Colors.white,
                    backgroundColor: Colors.black,
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.id);
                    },
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
