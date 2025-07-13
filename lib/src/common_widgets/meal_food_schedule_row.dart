import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import '../common/channels/dart_to_java_channels/meal_schedule_channel.dart';
import '../constants/colors.dart';

class MealFoodScheduleRow extends StatefulWidget {
  final Map mObj;
  final int index;
  final Function(Map food, bool isChecked) onCheckboxChanged;

  const MealFoodScheduleRow(
      {super.key,
      required this.mObj,
      required this.index,
      required this.onCheckboxChanged});

  @override
  State<MealFoodScheduleRow> createState() => _MealFoodScheduleRowState();
}

class _MealFoodScheduleRowState extends State<MealFoodScheduleRow> {
  late bool isChecked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isChecked = widget.mObj["consumed"];
  }


  @override
  Widget build(BuildContext context) {
    isChecked = widget.mObj["consumed"];
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    color: widget.index % 2 == 0
                        ? TColor.primaryColor2.withOpacity(0.4)
                        : TColor.secondaryColor2.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Image.file(
                  File(widget.mObj["image"].toString()), // Load image from file
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.mObj["foodName"].toString().toUpperCase(),
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '${double.parse(widget.mObj["calories"].toString()).ceil()} kcal for ${widget.mObj["weight"].toString().toUpperCase()} gm',
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    '${double.parse(widget.mObj["protein"].toString())} protein ${double.parse(widget.mObj["carbohydrate"].toString()).ceil()} carbs ${double.parse(widget.mObj["fat"].toString()).ceil()} fat',
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                  widget.onCheckboxChanged(widget.mObj,
                      isChecked); // Call the callback function when the checkbox state changes
                }),
          ],
        ));
  }
}
