import 'package:flutter/services.dart';

class ShowProfileDataChannel {
  static const MethodChannel _channel =
  MethodChannel('show_profile_data_channel');
  static Future<Map<dynamic, dynamic>?> getUserProfile(String email) async {
    try {
      final Map<dynamic, dynamic>? userInfo = await _channel.invokeMethod(
          'getProfileInfo', {"email": email});
      return userInfo;
    } on PlatformException catch (e) {
      print("Failed to submit form data: '${e.message}'.");
      return null;
    }
  }
}
