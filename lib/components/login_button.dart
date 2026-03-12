import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  LoginButton({super.key}) {}

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.send),
      label: const Text("Login"),
    );
  }
}
