import 'package:flutter/material.dart';
import 'authentication_service.dart';

class FingerprintBottomSheet extends StatelessWidget {
  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.fingerprint, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            'Place your finger on the sensor',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              bool authenticated = await _authService.authenticateWithBiometrics();
              Navigator.pop(context, authenticated);
            },
            child: Text('Authenticate'),
          ),
        ],
      ),
    );
  }
}
