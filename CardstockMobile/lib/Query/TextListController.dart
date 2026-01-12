import 'package:flutter/material.dart';
import 'package:get/get.dart';
//this is to manipulate list of text to know each one this is reusable one
class TextListController extends GetxController {
  // A Map to store controllers using the Unique ID (uidOwner) as the key
  final Map<String, TextEditingController> _controllers = {};

  // This helper gets (or creates) a controller for a specific UID
  TextEditingController getController(String uid) {
    if (!_controllers.containsKey(uid)) {
      _controllers[uid] = TextEditingController();
    }
    return _controllers[uid]!;
  }

  @override
  void onClose() {
    // Clean up all controllers when this screen is destroyed
    for (var c in _controllers.values) {
      c.dispose();
    }
    _controllers.clear();
    super.onClose();
  }
}