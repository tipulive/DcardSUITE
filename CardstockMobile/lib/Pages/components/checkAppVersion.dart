import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


Future<void> checkAppVersion({
  required String title,
  required String message,
  String? primaryButtonText,
  String? primaryButtonUrl,
  VoidCallback? primaryAction,
  String secondaryButtonText = 'Close',
  VoidCallback? secondaryAction,
  Color primaryColor = const Color(0xff9a1c55),
}) async {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        if (primaryButtonText != null)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            onPressed: () async {
              if (primaryButtonUrl != null) {
                final Uri urlData = Uri.parse(primaryButtonUrl);
                if (!await launchUrl(urlData)) {
                  throw Exception('Could not launch $urlData');
                }
              }
              if (primaryAction != null) primaryAction();
            },
            child: Text(primaryButtonText),
          ),
        ElevatedButton(
          onPressed: secondaryAction ?? () => Get.back(),
          child: Text(secondaryButtonText),
        ),
      ],
    ),
  );
}
