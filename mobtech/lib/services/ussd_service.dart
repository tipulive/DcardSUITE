import 'package:flutter/services.dart';

class USSDService {
  static const MethodChannel _channel = MethodChannel('ussd_service');

  static Future<void> sendUSSDCode(String code) async {
    try {
      await _channel.invokeMethod('sendUSSDCode', {'code': code});
    } catch (e) {
      print('Failed to send USSD code: $e');
    }
  }
}
