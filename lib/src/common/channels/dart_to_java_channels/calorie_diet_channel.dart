import 'package:flutter/services.dart';

class CalorieDietDataChannel {
  static const MethodChannel _channel =
  MethodChannel('calorie_diet_data_channel');

  static Future<Map<dynamic, dynamic>?> getConsumedCalories(
      String date,
      String email,
      ) async {
    try {
      final Map<dynamic, dynamic>? userInfo = await _channel.invokeMethod('getConsumedCalorie', {
        "date": date,
        "email": email,
      });
      return userInfo; // Return the calorie value
    } on PlatformException catch (e) {
      print("Failed to submit form data: '${e.message}'.");
      return null;
    }
  }
  static Future<double> getTargetCalories(
      String email,
      ) async {
    try {
      double targetCalorie = await _channel.invokeMethod('getTargetCalorie', {
        "email": email,
      });
      return targetCalorie; // Return the calorie value
    } on PlatformException catch (e) {
      print("Failed to submit form data: '${e.message}'.");
      return 0.0; // Return a default value in case of failure
    }
  }
}
