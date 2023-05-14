import 'package:fatwa/home.dart';
import 'package:fatwa/sign_in.dart';
import 'package:fatwa/sign_up.dart';
import 'package:fatwa/toggle_pages.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[350],
      child: Column(
        children: [
          SizedBox(height: 120),
          Image.asset(
            "assets/images/fatawa.png",
            width: 250,
          ),
          const Text(
            "Welcome To Fatawa",
            style: TextStyle(fontSize: 34),
          ),
          const SizedBox(
            height: 6,
          ),
          const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Fatawa is an app where you can ask questions related to Islam and get answer from an Islamic Scholar according to the teaching of The Qur'an and Hadith.",
                style: TextStyle(fontSize: 17),
              )),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const TogglePages()));
              },
              child: const Text('Signup'),
            ),
          ),
        ],
      ),
    );
  }
}
