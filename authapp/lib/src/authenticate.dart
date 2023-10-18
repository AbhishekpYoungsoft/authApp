import 'package:authapp/src/auth_success_screen.dart';
import 'package:authapp/src/services/authentication_service.dart';
import 'package:flutter/material.dart';

class AuthnticateScreen extends StatelessWidget {
  const AuthnticateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationService authService = AuthenticationService();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Biometric Authentication'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final isBiometricAvailable =
                  await authService.isBiometricAvailable();
              if (isBiometricAvailable) {
                final isAuthenticated = await authService.authenticate();
                if (isAuthenticated) {
                  print('Authentication successful');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AuthRsultScreen(result: 'success'),
                    ),
                  );
                } else {
                  print('Authentication Failed');
                  // Handle authentication failure
                  Navigator.pop(context);
                }
              } else {
                print('Biometric authentication not available');
              }
            },
            child: const Text('Authenticate with Biometrics'),
          ),
        ));
  }
}
