import 'package:calory/src/common_widgets/round_button.dart';
import 'package:calory/src/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../common_widgets/highlighted_rtextfield.dart';
import '../../../../constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'dart:ui' as ui;

import '../../../../constants/sizes.dart';

class ScanFood extends StatefulWidget {
  @override
  _ScanFoodState createState() => _ScanFoodState();
}

class _ScanFoodState extends State<ScanFood> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _foodWeightController = TextEditingController();
  TextEditingController _foodNameController = TextEditingController();
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

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String weight = _foodWeightController.text;
      String name = _foodNameController.text;
      FormDataChannel.submitFormData(weight, name, _imagefile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        leading: const SizedBox(),
        title: Text(
          "Scan Food",
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HighlightRoundTextField(
                keyboardType: TextInputType.text,
                labelText: fWeight,
                controller: _foodWeightController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some value';
                  }
                  return null;
                },
                prefixIcon: const Icon(
                    Icons.production_quantity_limits_outlined,
                    color: darkColor),
              ),
              const SizedBox(height: defaultSize),
              HighlightRoundTextField(
                keyboardType: TextInputType.text,
                labelText: fName,
                controller: _foodNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some value';
                  }
                  return null;
                },
                prefixIcon:
                    const Icon(Icons.fastfood_outlined, color: darkColor),
              ),
              /*TextFormField(
                controller: _foodWeightController,
                decoration: InputDecoration(labelText: 'Enter Your Food Weight'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _foodNameController,
                decoration: InputDecoration(labelText: 'Enter Your Food'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some value';
                  }
                  return null;
                },
              ),
              SizedBox(height: 300),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),*/
              SizedBox(height: 100),
              RoundButton(title: submit, onPressed: _submitForm),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: _getImage,
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: TColor.secondaryG),
              borderRadius: BorderRadius.circular(27.5),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
              ]),
          alignment: Alignment.center,
          child: Icon(
            Icons.photo_camera,
            size: 20,
            color: TColor.white,
          ),
        ),
      ),
    );
  }

  Future<ui.Image> getImageFromPath(String imagePath) async {
    ByteData data = await rootBundle.load(imagePath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
}

class FormDataChannel {
  // image channel
  static const MethodChannel _channel = MethodChannel('form_data_channel');

  static Future<void> submitFormData(
      String weight, String name, Uint8List? bitmap) async {
    try {
      await _channel.invokeMethod(
          'submitFormData', {"weight": weight, "name": name, "path": bitmap});
    } on PlatformException catch (e) {
      print("Failed to submit form data: '${e.message}'.");
    }
  }
}
