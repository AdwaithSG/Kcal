import 'package:flutter/services.dart';

class FoodSearchDataChannel {

  static const MethodChannel _channel = MethodChannel('food_search_data_channel');

  static Future<List<dynamic>?> getFoodNames() async {
    try {
      final List<dynamic>? foodNames = await _channel.invokeMethod(
          'searchFoodsName');
      return foodNames;
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
      return null;
    }
  }

  static Future<List<dynamic>?> getFoodImages() async {
    try {
      final List<dynamic>? foodImages = await _channel.invokeMethod(
          'searchFoodsImages');
      return foodImages;
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
      return null;
    }
  }

  static Future<String?> submitSelectedFoodData(
      String foodName,
      String foodWeight,
      String email,
      String date,
      String meal) async {
    try {
      String? status =
      await _channel.invokeMethod('submitSelectedFoodData', {
        "foodName": foodName,
        "foodWeight": foodWeight,
        "email": email,
        "date": date,
        "meal": meal
      });
      print(status);
      return status;
    } on PlatformException catch (e) {
      print("Failed to submit data: '${e.message}'.");
      return "";
    }
  }
}