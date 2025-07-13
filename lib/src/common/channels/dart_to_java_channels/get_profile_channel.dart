import 'package:flutter/services.dart';

class GetProfileDataChannel {
  static const MethodChannel _channel = MethodChannel('get_profile_data_channel');

  static Future<void> submitGetProfileData(
      String gender, DateTime dob, int number, double weight, double height) async {
    try {
      await _channel.invokeMethod(
          'submitGetProfileData', {"gender": gender, "dob": dob, "number": number, "weight": weight, "height": height});
    } on PlatformException catch (e) {
      print("Failed to submit form data: '${e.message}'.");
    }
  }
}