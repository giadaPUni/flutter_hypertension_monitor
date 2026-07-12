import 'package:flutter/material.dart';
import 'package:flutter_hypertension_monitor/core/navigation/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.dashboard,
          );
        },
        child: const Text('Go to Dashboard'),
      ),
    );
  }
}