import 'package:flutter/services.dart';

class SignUpDataChannel {
  static const MethodChannel _channel = MethodChannel('signup_data_channel');

  static Future<void> submitSignUpData(
      String username,
      String email,
      String password,
      String gender,
      int age,
      double weight,
      double height,
      String activityLevel,
      double calorie) async {
    try {
      await _channel.invokeMethod('submitSignupData', {
        "username": username,
        "email": email,
        "password": password,
        "gender": gender,
        "age": age,
        "weight": weight,
        "height": height,
        "activityLevel": activityLevel,
        "goalCalorie": calorie
      });
    } on PlatformException catch (e) {
      print("Failed to submit form data: '${e.message}'.");
    }
  }
}
