import 'dart:convert';

import 'package:flutter/services.dart';


class MealScheduleDataChannel {

  static const MethodChannel _channel = MethodChannel('meal_schedule_data_channel');

  static Future<List<dynamic>> getScheduleFoodInfo(String date, String email) async {
    try {
      final String jsonString =
      await _channel.invokeMethod('getScheduleFoodInfo', {"date": date, "email": email});
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList;
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
      return [];
    }
  }
  static Future<void> updateConsumed(
      String date,
      String email,
      bool consumed,
      double weight,
      String image,
      String meal,
      String foodName
      ) async {
    try {
      await _channel.invokeMethod('updateConsumedFood', {
        "date": date,
        "email": email,
        "consumed": consumed,
        "weight": weight,
        "image": image,
        "meal": meal,
        "foodName": foodName
      });
    } on PlatformException catch (e) {
      print("Failed to submit form data: '${e.message}'.");
    }
  }
}