import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal Info Goes Here',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _placeholder(
              height: 100,
              label:
                  'GPA: 0.0 Balance: -2485.23 Average Score: 0/F Semester: 0',
            ),

            const Text(
              'Calendar Goes Here',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _placeholder(height: 224, label: 'Calendar'),
            const SizedBox(height: 6),
            _placeholder(height: 224, label: 'All Subject Info'),
          ],
        ),
      ),
    );
  }

  Widget _placeholder({required double height, required String label}) {
    return Container(
      height: height,
      decoration: BoxDecoration(color: Colors.grey[300]),
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      ),
    );
  }
}
