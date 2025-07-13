import 'package:flutter/services.dart';

class LoginDataChannel {

  static const MethodChannel _channel = MethodChannel('login_data_channel');

  static Future<bool> submitLoginData(
      String email, String password) async {
    try {
     bool isTrue = await _channel.invokeMethod(
          'submitLoginData', {"email": email, "password": password});
     return isTrue;
    } on PlatformException catch (e) {
      print("Failed to submit form data: '${e.message}'.");
      return false;
    }
  }


  /*static Future<void> submitLoginActiveData(
      bool active, String username) async {
    try {
      await _channel.invokeMethod(
          'submitLoginActiveData', {"active": active, "username":username});
    } on PlatformException catch (e) {
      print("Failed to submit form data: '${e.message}'.");
    }
  }*/
}