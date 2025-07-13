import 'package:flutter/material.dart';
import 'package:ruler_picker_bn/ruler_picker_bn.dart';

class BuildScreen3 extends StatefulWidget {
  final Function(int) onHeightSelected;
  const BuildScreen3({super.key, required this.onHeightSelected});

  @override
  State<BuildScreen3> createState() => _BuildScreen3State();
}

class _BuildScreen3State extends State<BuildScreen3> {
  int selectedHeight = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select your height',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  '$selectedHeight cm',
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the radius as needed
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the radius as needed
                      child: SizedBox(
                        width: 150,
                        height: 470,
                        child: RulerPicker(
                          onChange: (val) {
                            setState(() {
                              selectedHeight = val;
                              widget.onHeightSelected(selectedHeight);
                            });
                          },
                          background: const Color.fromARGB(255, 253, 253, 253),
                          minValue: 0,
                          maxValue: 300,
                          lineColor: Colors.black,
                          direction: Axis.vertical,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    right: -26,
                    top: 208.5,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                      size: 55,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
