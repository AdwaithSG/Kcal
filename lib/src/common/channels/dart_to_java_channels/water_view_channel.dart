import 'package:flutter/services.dart';

class WaterViewDataChannel {
  static const MethodChannel _channel =
      MethodChannel('water_view_data_channel');

  static Future<void> setWaterInfo(String email, String date, double waterLevel,
      double waterPr, String waterTm) async {
    try {
      _channel.invokeMethod('getWaterData', {
        "email": email,
        "date": date,
        "waterLevel": waterLevel,
        "waterPr": waterPr,
        "waterTm": waterTm
      });
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
    }
  }
  static Future<Map<dynamic, dynamic>?> getWaterUserInfo(String email, String date) async {
    try {
      final Map<dynamic, dynamic>? userInfo = await _channel.invokeMethod(
          'getCurrentUserWaterInfo', {"email": email, "date":date});
      return userInfo;
    } on PlatformException catch (e) {
      print("Failed to submit form data: '${e.message}'.");
      return null;
    }
  }
}
