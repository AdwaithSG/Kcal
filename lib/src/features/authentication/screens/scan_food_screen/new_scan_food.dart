import 'dart:typed_data';

import 'package:calory/src/common/channels/dart_to_java_channels/scan_food_channel.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:image_picker/image_picker.dart';

class NewScanFood extends StatefulWidget {
  const NewScanFood({super.key});

  @override
  @override
  State<NewScanFood> createState() => _NewScanFoodState();
}

class _NewScanFoodState extends State<NewScanFood> {
  //TextEditingController foodNameController = TextEditingController();
  TextEditingController weightController =
      TextEditingController(); // Declare weight controller
  late CameraController _cameraController;
  String foodName = '';
  double calorie = 0.0;
  double fat = 0.0;
  double carbs = 0.0;
  double protein = 0.0;
  Uint8List? _imagefile;
  double weight = 0.0;
  bool showDetails = false;
  bool showError = false;
  final _formKey = GlobalKey<FormState>();
  bool showExpandButton = false;
  bool showPieChart = true; // Flag to control the visibility of the pie chart

  // Function to reset the state to initial values and clear entered values
  void resetState() {
    setState(() {
      //foodNameController.clear(); // Clear the food name text field
      weightController.clear(); // Clear the weight text field
      weight = 0.0; // Reset weight
      showDetails = false; // Hide nutritional details
      showExpandButton = false; // Hide expand button
      showPieChart = true; // Show pie chart widget
      showError = false;
    });
  }

  Future<void> fetchData() async {
    String weight = weightController.text;
    final Map<dynamic, dynamic>? calorieData =
        await ScanFoodChannel.submitScanFoodData(weight, _imagefile);
    if (calorieData != null) {
      final String fName = calorieData['foodName'].toString();
      final double fWeight = double.parse(calorieData['weight'].toString());
      final double fCarbs = double.parse(calorieData['carbs'].toString());
      final double fFat = double.parse(calorieData['fat'].toString());
      final double fProtein = double.parse(calorieData['protein'].toString());
      final double fCalorie = double.parse(calorieData['calorie'].toString());

      setState(() {
        foodName = fName;
        carbs = fCarbs;
        fat = fFat;
        protein = fProtein;
        calorie = fCalorie;
      });
    } else {
      print('Failed to retrieve user data.');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Know your food',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Make the text bold
            ),
          ),
          centerTitle: true, // Center the title text
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /*TextField(
                controller: foodNameController, // Assign the food name controller
                onChanged: (value) {
                  setState(() {
                    // No need to update foodName directly anymore
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Food Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),*/
                SizedBox(height: 20.0),
                TextField(
                  controller: weightController, // Assign the weight controller
                  onChanged: (value) {
                    setState(() {
                      weight = double.tryParse(value) ?? 0.0;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Weight (grams)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await _submitForm();
                          if (foodName == "null") {
                            setState(() {
                              showError = true;
                            });
                          } else {
                            setState(() {
                              showDetails = true;
                              showExpandButton = true;
                            });
                          }
                          FocusScope.of(context).unfocus();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'Submit',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 0, 0, 0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Add spacing between buttons
                    Expanded(
                      child: ElevatedButton(
                        onPressed: resetState, // Call resetState function
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'New Bite',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 0, 0, 0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                Container(
                  height: showError
                      ? MediaQuery.of(context).size.height * 0.1
                      : 0, // Adjust the height as needed
                  decoration: BoxDecoration(
                    color: Colors.black, // Set background color to black
                    borderRadius: BorderRadius.circular(
                        30.0), // Set border radius for rounded corners
                  ),
                  child: Container(
                    padding: EdgeInsets.all(8.0), // Add padding to the text
                    child: Center(
                      // Center the text horizontally
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Visibility(
                              visible: showError,
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Text(
                            "Failed to identify food".toUpperCase(),
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Conditionally show the pie chart widget based on the flag
                if (showPieChart)
                  AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Container(
                      height: showDetails ? null : 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.0),
                          HomePage2(
                            protein: protein,
                            fat: fat,
                            carbs: carbs,
                            calorie: calorie,
                            foodName: foodName,
                          ),
                        ],
                      ),
                    ),
                  ),
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
        ));
  }

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
}

class HomePage2 extends StatelessWidget {
  final double calorie;
  final String foodName;
  final double fat;
  final double carbs;
  final double protein;

  HomePage2(
      {required this.calorie,
      required this.foodName,
      required this.fat,
      required this.carbs,
      required this.protein});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> nutritionalValues = {
      'protein': protein,
      'fat': fat,
      'carbohydrate': carbs,
    };

    final double totalPercentage = protein + carbs + fat > 0
        ? 100 / (protein + carbs + fat) // Calculate total percentage
        : 0;

    final Map<String, double> dataMap = {
      "Protein": protein * totalPercentage,
      "Carbohydrate": carbs * totalPercentage,
      "Fat": fat * totalPercentage,
    };

    final Map<String, Color> colorMap = {
      "Protein": Colors.green,
      "Carbohydrate": Colors.blue,
      "Fat": Colors.red,
    };

    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(229, 0, 0, 0),
                borderRadius: BorderRadius.circular(20),
              ),
              width: 500,
              height: 380,
            ),
          ),
          Positioned(
            top: 20.0, // Adjust the top position as needed
            child: Text(
              foodName.toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: PieChart(
                  data: [
                    PieChartData(colorMap['Protein'] ?? Colors.green,
                        dataMap['Protein'] ?? 0),
                    PieChartData(colorMap['Carbohydrate'] ?? Colors.blue,
                        dataMap['Carbohydrate'] ?? 0),
                    PieChartData(
                        colorMap['Fat'] ?? Colors.red, dataMap['Fat'] ?? 0),
                  ],
                  radius: 100,
                  strokeWidth: 16,
                  segmentSpace: 0.09,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (String label in dataMap.keys)
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              color: colorMap[label] ?? Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(label,
                                style: TextStyle(
                                    fontSize: 16, color: colorMap[label])),
                          ],
                        ),
                        Text(
                          '${(nutritionalValues[label.toLowerCase()] ?? 0).toStringAsFixed(2)} grams',
                          style:
                              TextStyle(fontSize: 16, color: colorMap[label]),
                        ),
                        Text(
                          '${((dataMap[label] ?? 0)).toStringAsFixed(2)}%',
                          style:
                              TextStyle(fontSize: 16, color: colorMap[label]),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 140.0,
            left: 200,
            child: Text(
              '${calorie.toStringAsFixed(0)} kcal',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class PieChartData {
  const PieChartData(this.color, this.percent);

  final Color color;
  final double percent;
}

class PieChart extends StatefulWidget {
  PieChart({
    required this.data,
    required this.radius,
    this.strokeWidth = 8,
    this.segmentSpace = 0.02,
    Key? key,
  }) : super(key: key);

  final List<PieChartData> data;
  final double radius;
  final double strokeWidth;
  final double segmentSpace;

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PieChartPainter(
        widget.strokeWidth,
        widget.data,
        widget.segmentSpace,
        _animation,
      ),
      size: Size.square(widget.radius),
    );
  }
}

class _PainterData {
  const _PainterData(this.paint, this.radians);

  final Paint paint;
  final double radians;
}

class _PieChartPainter extends CustomPainter {
  _PieChartPainter(
    this.strokeWidth,
    this.data,
    this.segmentSpace,
    this.animation,
  )   : assert(data.isNotEmpty),
        super(repaint: animation);

  final double strokeWidth;
  final List<PieChartData> data;
  final double segmentSpace;
  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double chartRadius = size.width / 2 - strokeWidth / 2;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startAngle = 0;
    final double total =
        data.fold<double>(0, (sum, data) => sum + data.percent);

    final double animationValue = animation.value;

    for (final dataPoint in data) {
      final sweepAngle = (2 * math.pi * dataPoint.percent / total) -
          (2 * math.pi * segmentSpace / data.length);

      final double currentSweep = sweepAngle * animationValue;

      final Rect rect = Rect.fromCircle(
          center: Offset(centerX, centerY), radius: chartRadius);
      final path = Path()..addArc(rect, startAngle, currentSweep);

      paint.color = dataPoint.color;
      canvas.drawPath(path, paint);

      startAngle += sweepAngle +
          (2 *
              math.pi *
              segmentSpace /
              data.length); // Adjusted start angle with segment space
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
