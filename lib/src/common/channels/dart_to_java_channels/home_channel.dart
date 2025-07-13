import 'package:flutter/services.dart';

class HomeDataChannel {
  static const MethodChannel _channel = MethodChannel('home_data_channel');

  static Future<Map<dynamic, dynamic>?> getCurrentUser() async {
    try {
      final Map<dynamic, dynamic>? userData =
          await _channel.invokeMethod('getCurrentUser');
      return userData;
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
      return null;
    }
  }

  static Future<void> disableUser(String email) async {
    try {
      await _channel.invokeMethod('disableCurrentUser', {"email": email});
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
    }
  }
}
