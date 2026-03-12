import 'package:emis_wrapper/pages/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EmisWrapper());
}

class EmisWrapper extends StatelessWidget {
  const EmisWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Dashboard());
  }
}
