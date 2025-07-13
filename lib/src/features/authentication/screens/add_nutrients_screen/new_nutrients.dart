import 'dart:typed_data';

import 'package:calory/src/common_widgets/highlighted_rtextfield.dart';
import 'package:calory/src/constants/image_strings.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants/colors.dart';

class NutrientPage extends StatefulWidget {
  @override
  _NutrientPageState createState() => _NutrientPageState();
}

class _NutrientPageState extends State<NutrientPage> {
  int proteinCount = 50;
  int carbsCount = 50;
  int fatCount = 50;
  int weightCount = 50;

  TextEditingController nameController = TextEditingController();

  late CameraController _cameraController;

  Uint8List? _imagefile;

  Future<void> _getImage() async {
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
  }

  void incrementProtein() {
    setState(() {
      proteinCount++;
    });
  }

  void decrementProtein() {
    if (proteinCount > 0) {
      setState(() {
        proteinCount--;
      });
    }
  }

  void incrementWeight() {
    setState(() {
      weightCount++;
    });
  }

  void decrementWeight() {
    if (weightCount > 0) {
      setState(() {
        weightCount--;
      });
    }
  }

  void incrementCarbs() {
    setState(() {
      carbsCount++;
    });
  }

  void decrementCarbs() {
    if (carbsCount > 0) {
      setState(() {
        carbsCount--;
      });
    }
  }

  void incrementFat() {
    setState(() {
      fatCount++;
    });
  }

  void decrementFat() {
    if (fatCount > 0) {
      setState(() {
        fatCount--;
      });
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
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/images/more_btn.png",
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          // Adjusted padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image(
                        image: AssetImage(foodNameIcon),
                        width: 25,
                        height: 30,
                        fit: BoxFit.contain,
                        color: TColor.gray,
                      ),
                      SizedBox(width: 27),
                      Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(width: 100),
                  Material(
                    elevation: 4,
                    // Adjust elevation value as needed
                    shadowColor: Colors.grey,
                    // Optional: Adjust shadow color
                    borderRadius: BorderRadius.circular(10),
                    // Optional: Adjust border radius
                    child: Container(
                      width: 150,
                      height: 50,
                      padding: EdgeInsets.all(8),
                      // Optional: Adjust padding as needed
                      child: Center(
                          child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                        image: AssetImage(proteinIcon),
                        width: 25,
                        height: 30,
                        fit: BoxFit.contain,
                        color: TColor.gray,
                      ),
                      SizedBox(width: 15),
                      Column(
                        children: [
                          Text(
                            'Proteins',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text('$proteinCount'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: decrementProtein,
                      ),
                      Material(
                        elevation: 4,
                        // Adjust elevation value as needed
                        shadowColor: Colors.grey,
                        // Optional: Adjust shadow color
                        borderRadius: BorderRadius.circular(10),
                        // Optional: Adjust border radius
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(8),
                          // Optional: Adjust padding as needed
                          child: Center(child: Text('$proteinCount')),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: incrementProtein,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                        image: AssetImage(carbsIcon),
                        width: 25,
                        height: 30,
                        fit: BoxFit.contain,
                        color: TColor.gray,
                      ),
                      SizedBox(width: 27),
                      Column(
                        children: [
                          Text(
                            'Carbs',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$carbsCount',
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: decrementCarbs,
                      ),
                      Material(
                        elevation: 4,
                        // Adjust elevation value as needed
                        shadowColor: Colors.grey,
                        // Optional: Adjust shadow color
                        borderRadius: BorderRadius.circular(10),
                        // Optional: Adjust border radius
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(8),
                          // Optional: Adjust padding as needed
                          child: Center(child: Text('$carbsCount')),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: incrementCarbs,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                        image: AssetImage(fatIcon),
                        width: 25,
                        height: 30,
                        fit: BoxFit.contain,
                        color: TColor.gray,
                      ),
                      SizedBox(width: 39),
                      Column(
                        children: [
                          Text(
                            'Fat',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text('$fatCount'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: decrementFat,
                      ),
                      Material(
                        elevation: 4,
                        // Adjust elevation value as needed
                        shadowColor: Colors.grey,
                        // Optional: Adjust shadow color
                        borderRadius: BorderRadius.circular(10),
                        // Optional: Adjust border radius
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(8),
                          // Optional: Adjust padding as needed
                          child: Center(child: Text('$fatCount')),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: incrementFat,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                        image: AssetImage(weightNIcon),
                        width: 25,
                        height: 30,
                        fit: BoxFit.contain,
                        color: TColor.gray,
                      ),
                      SizedBox(width: 21),
                      Column(
                        children: [
                          Text(
                            'Weight',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text('$weightCount'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: decrementWeight,
                      ),
                      Material(
                        elevation: 4,
                        // Adjust elevation value as needed
                        shadowColor: Colors.grey,
                        // Optional: Adjust shadow color
                        borderRadius: BorderRadius.circular(10),
                        // Optional: Adjust border radius
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(8),
                          // Optional: Adjust padding as needed
                          child: Center(child: Text('$weightCount')),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: incrementWeight,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50.0),
            ],
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
