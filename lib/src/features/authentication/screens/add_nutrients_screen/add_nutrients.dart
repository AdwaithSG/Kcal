import 'dart:math';

import 'package:calory/src/common_widgets/nutrients_cell.dart';
import 'package:calory/src/common_widgets/round_button.dart';
import 'package:calory/src/constants/image_strings.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../constants/colors.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class AddNutrients extends StatefulWidget {
  const AddNutrients({super.key});

  @override
  State<AddNutrients> createState() => _AddNutrientsState();
}

class _AddNutrientsState extends State<AddNutrients> {
  late double proteinS;
  late double carbsS;
  late double fatS;

  late double weightS;
  late String nameS = '';

  late CameraController _cameraController;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _foodWeightController = TextEditingController();
  TextEditingController _foodNameController = TextEditingController();
  TextEditingController _foodProteinController = TextEditingController();
  TextEditingController _foodCarbsController = TextEditingController();
  TextEditingController _foodFatController = TextEditingController();

  Uint8List? _imagefile;
  String _imageFilePath = '';

  /*Future<void> _getImage() async {
    List<CameraDescription> cameras;
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
    if (mounted) {
      setState(() {});
    }
    //final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() async {
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        _imagefile = bytes;
      } else {
        print('No image selected.');
      }
    });
  }*/

  String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  Future<void> _getImage() async {
    try {
      // Capture image
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        // Read the bytes of the image file
        final bytes = await pickedFile.readAsBytes();
        _imagefile = bytes;
        // Save the image file to a directory in your Flutter project
        final Directory directory = await getApplicationDocumentsDirectory();
        final String randomFileName = generateRandomString(10);
        final String imagePath = '${directory.path}/$randomFileName.jpg';
        final File imageFile = File(imagePath);
        await imageFile.writeAsBytes(bytes);

        setState(() {
          _imageFilePath = imagePath;
        });

        print(_imageFilePath);
        // Update the state with the image file path
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      weightS = double.parse(_foodWeightController.text);
      nameS = _foodNameController.text;
      proteinS = double.parse(_foodProteinController.text);
      carbsS = double.parse(_foodCarbsController.text);
      fatS = double.parse(_foodFatController.text);
      print(weightS);
      print(nameS);
      print(proteinS);
      print(carbsS);
      print(fatS);
      print(_imagefile);
      NutrientsDataChannel.submitNutrientsData(proteinS, fatS, carbsS, weightS, nameS, _imageFilePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/images/black_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Add Nutrients",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: NutrientsCell(
                        textController: _foodProteinController,
                        icon: proteinIcon,
                        title: "Protein",
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: NutrientsCell(
                        textController: _foodCarbsController,
                        icon: carbsIcon,
                        title: "Carbs",
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: NutrientsCell(
                        textController: _foodFatController,
                        icon: fatIcon,
                        title: "Fat",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      child: NutrientsCell(
                        textController: _foodWeightController,
                        icon: weightNIcon,
                        title: "Weight",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: _foodNameController, // Assign the weight controller
                  decoration: InputDecoration(
                    labelText: 'Food Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 45,
                ),
                Center(
                  child: RoundButton(
                      onPressed: () {
                        _submitForm();
                      },
                      title: 'ADD'),
                ),
              ],
            ),
          ),
        ),
      ),
        floatingActionButton: InkWell(
          onTap: _getImage,
          child: Container(
            width: 110,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(27.5),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.white, blurRadius: 5, offset: Offset(0, 2))
                ]),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Image(
                  image: AssetImage('assets/icons/camera-float.png'),
                  width: 25,
                  height: 30,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 10),
                Text(
                  'Snap',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class NutrientsDataChannel {
  // nutrients channel
  static const MethodChannel _channel = MethodChannel('nutrients_data_channel');

  static Future<void> submitNutrientsData(
      double protein, double fat, double carbs, double weight, String name, String img) async {
    try {
      await _channel.invokeMethod(
          'submitNutrientsData', {"protein": protein, "fat": fat, "carbs": carbs, "weight": weight, "name": name, "image": img});
    } on PlatformException catch (e) {
      print("Failed to submit form data: '${e.message}'.");
    }
  }
}

