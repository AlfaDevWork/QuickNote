
import 'package:flutter/material.dart';
import 'package:quicknote/database/db_helper.dart';
import 'package:quicknote/model/user_model.dart';
import 'package:quicknote/utils/custom_elevated_button.dart';
import 'package:quicknote/utils/custom_form_text_field.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String id = "/register_screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isVisible = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomFormTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  label: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    } else if (!value.contains('@') ||
                        !value.contains('gmail.com')) {
                      return 'Invalid email format \nEmail format should be "email"@gmail.com';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomFormTextField(
                  controller: usernameController,
                  label: 'Username',
                  validator: (value) => value == null || value.isEmpty
                      ? "This field is required"
                      : null,
                ),
                SizedBox(height: 16),
                CustomFormTextField(
                  controller: passwordController,
                  label: 'Password',
                  validator: (value) => value == null || value.isEmpty
                      ? "This field is required"
                      : null,
                  obscureText: !_isVisible,
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
                ),
                SizedBox(height: 16),
                CustomElevatedButton(
                  text: 'Register',
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      DbHelper.registerUser(
                        data: UserModel(
                          username: usernameController.text,
                          password: passwordController.text,
                          email: emailController.text,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                          content: Text('Registration Succesful!'),
                          backgroundColor: Colors.black,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
