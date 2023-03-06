import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthScreen extends StatefulWidget {
  const LocalAuthScreen({super.key});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  String _authMessage = '';

  Future<bool> _authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
            useErrorDialogs: true,
            sensitiveTransaction: true),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return authenticated;
  }

  void _showAuthMessage(String message) {
    setState(() {
      _authMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                bool authenticated = await _authenticate();

                if (authenticated) {
                  _showAuthMessage('Authenticated successfully!');
                } else {
                  _showAuthMessage('Failed to authenticate.');
                }
              },
              child: const Text('Authenticate'),
            ),
            const SizedBox(height: 16.0),
            Text(_authMessage),
          ],
        ),
      ),
    );
  }
}
