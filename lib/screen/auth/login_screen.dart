
import 'package:flutter/material.dart';
import 'package:quicknote/database/db_helper.dart';
import 'package:quicknote/helper/preference.dart';
import 'package:quicknote/screen/home.dart';
import 'package:quicknote/utils/custom_elevated_button.dart';
import 'package:quicknote/utils/custom_text_field.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = "/login_page";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isVisible = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: usernameController,
                    label: 'Username',
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: Icon(
                        _isVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    obscureText: !_isVisible,
                    controller: passwordController,
                    label: 'Password',
                  ),
                  SizedBox(height: 16),
                  CustomElevatedButton(
                    text: 'Login',
                    textColor: Colors.white,
                    backgroundColor: Colors.black,
                    onPressed: () async {
                      final userData = await DbHelper.login(
                        usernameController.text,
                        passwordController.text,
                      );
                      if (userData != null) {
                        PreferenceHandler.saveLogin(true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 2),
                            content: Text('Login Succesful'),
                          ),
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomeScreen()),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 1),
                            content: Text('Invalid username or password'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
