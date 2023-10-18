import 'package:flutter/material.dart';

class AuthRsultScreen extends StatelessWidget {
  final String result;
  const AuthRsultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(result),
      ),
    );
  }
}
