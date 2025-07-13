import 'package:flutter/services.dart';

class ScanFoodChannel {
  // image channel
  static const MethodChannel _channel = MethodChannel('scan_food_channel');

  static Future<Map<dynamic, dynamic>?> submitScanFoodData(
      String weight, Uint8List? bitmap) async {
    try {
      final Map<dynamic, dynamic>? calorieData =await _channel.invokeMethod(
          'submitScanFoodData', {"weight": weight,"path": bitmap});
      return calorieData;
    } on PlatformException catch (e) {
      print("Failed to submit form data: '${e.message}'.");
      return null;
    }
  }
}