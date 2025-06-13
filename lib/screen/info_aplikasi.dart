import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String id = "/info_aplikasi";
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.sticky_note_2_outlined, size: 48, color: Colors.black),
            SizedBox(height: 24),
            Text(
              "Notes App",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Aplikasi catatan simpel yang dibuat dari Flutter.",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            // SizedBox(height: 32),
            Spacer(),
            Text(
              "Version",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text("1.0.0", style: TextStyle(color: Colors.black)),
            SizedBox(height: 20),
            Text(
              "Developer",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              "Alfarezhi Mohamad Rasidan",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
