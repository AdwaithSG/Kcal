import 'dart:io';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class MealSelectionRow extends StatefulWidget {
  final Map<String, String> mObj;
  final int index;
  final Function onItemTapped; // Add the callback function

  const MealSelectionRow({
    Key? key,
    required this.mObj,
    required this.index,
    required this.onItemTapped, // Required callback parameter
  }) : super(key: key);

  @override
  State<MealSelectionRow> createState() => _MealSelectionRowState();
}

class _MealSelectionRowState extends State<MealSelectionRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
                    widget.mObj["name"].toString(),
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  widget.onItemTapped(widget.mObj);
                },
                icon: const Icon(Icons.add_circle_outline)),
          ],
        ),
      ),
    );
  }
}
