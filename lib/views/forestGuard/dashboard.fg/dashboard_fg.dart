import 'package:flutter/material.dart';


class DashboardFG extends StatelessWidget {
  const DashboardFG({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forest Guard Dashboard'),
      ),
      body: const Center(
        child: Text('Welcome to the Forest Guard Dashboard!'),
      ),
    );
  }
}