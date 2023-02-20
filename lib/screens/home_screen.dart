import 'package:flutter/material.dart';
import 'package:user_auth/constants.dart';
import 'package:user_auth/controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(email, style: boldStyle),
            ElevatedButton(
                onPressed: () => AuthController.instance.logOut(),
                child: const Text('Log Out')),
          ],
        ),
      ),
    );
  }
}
