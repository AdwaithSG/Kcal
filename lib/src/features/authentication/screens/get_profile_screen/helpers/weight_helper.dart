import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:flutter/material.dart';

class BuildScreen2 extends StatefulWidget {
  final Function(double) onWeightSelected;
  const BuildScreen2({super.key, required this.onWeightSelected});

  @override
  State<BuildScreen2> createState() => _BuildScreen2State();
}

class _BuildScreen2State extends State<BuildScreen2> {
  double selectedWeight = 30.0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select your weight',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 250),
          AnimatedWeightPicker(
            min: 30,
            max: 200,
            onChange: (value) {
              setState(() {
                selectedWeight = double.parse(value);
                widget.onWeightSelected(selectedWeight);
              });
            },
          ),
        ],
      ),
    );
  }
}
