import 'package:flutter/material.dart';

void onItemTapped(BuildContext context, Map<String, String> foodItem, Function(Map<String, dynamic>) onSubmit, Function() incrementCount, Function(String, String) updateFoodInfo) {
  // Create a TextEditingController to manage the input text field
  TextEditingController inputController = TextEditingController();

  // Create a state variable for the toggle switch
  int selectedUnitIndex = 0; // 0 for 'gm', 1 for 'lt'

  // Show an alert dialog with the name of the tapped food item and an input text field
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('${foodItem["name"]}'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10), // Add space between text and input field
                    Row(
                      children: [
                        // Input text field
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: inputController,
                            decoration: InputDecoration(
                              hintText: 'Enter food quantity',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8), // Add some space between text field and toggle switch

                        // Rectangle toggle switch with values 'gm' and 'lt'
                        ToggleButtons(
                          borderRadius: BorderRadius.circular(5),
                          isSelected: [selectedUnitIndex == 0, selectedUnitIndex == 1],
                          onPressed: (int index) {
                            setState(() {
                              // Update the selected index
                              selectedUnitIndex = index;
                            });
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text('GM'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text('LT'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Handle the input text field data and toggle switch value
                      String foodQuantity = inputController.text;
                      String selectedUnit = selectedUnitIndex == 0 ? 'gm' : 'lt';

                      // Check if the quantity is valid
                      if (foodQuantity.isNotEmpty) {
                        // Call the onSubmit callback function and pass the data
                        onSubmit({
                          'name': foodItem['name'],
                          'quantity': foodQuantity,
                          'unit': selectedUnit,
                        });

                        // Update the food name and weight in FoodSelectionScreen
                        updateFoodInfo(foodItem['name']!, foodQuantity);
                      }
                      incrementCount();
                      // Dismiss the alert dialog
                      Navigator.of(context).pop();

                      // You can handle the input data (userNotes and selectedUnit) as needed here
                      print('User notes: $foodQuantity');
                      print('Selected unit: $selectedUnit');
                    },
                    child: Text('Submit'),
                  ),
                ],
              );
            }
        );
      }
  );
}
