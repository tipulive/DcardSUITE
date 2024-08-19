import 'package:flutter/material.dart';
import 'fingerprint_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            bool? authenticated = await showModalBottomSheet<bool>(
              context: context,
              builder: (context) => FingerprintBottomSheet(),
              isScrollControlled: true,
            );

            if (authenticated ?? false) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Authenticated successfully!')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Authentication failed!')),
              );
            }
          },
          child: Text('Authenticate with Fingerprint'),
        ),
      ),
    );
  }
}
