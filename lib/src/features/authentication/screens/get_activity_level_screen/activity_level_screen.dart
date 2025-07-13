import 'package:calory/src/features/authentication/screens/get_activity_level_screen/helpers/calculate_bmr.dart';
import 'package:calory/src/features/authentication/screens/login_screen/login_screen.dart';
import 'package:calory/src/features/authentication/screens/main_tab/main_tab_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../common/channels/dart_to_java_channels/signUp_channel.dart';
import '../../../../common_widgets/round_button.dart';
import '../../../../constants/colors.dart';
import 'package:calory/src/constants/image_strings.dart';
import 'package:calory/src/constants/text_string.dart';

class ActivityLevelScreen extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  final String selectedGender;
  final int selectedAge;
  final double selectedHeight;
  final double selectedWeight;

  const ActivityLevelScreen(
      {super.key,
      required this.selectedGender,
      required this.selectedAge,
      required this.selectedWeight,
      required this.selectedHeight,
      required this.username,
      required this.password,
      required this.email});

  @override
  State<ActivityLevelScreen> createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends State<ActivityLevelScreen> {
  CarouselController buttonCarouselController = CarouselController();
  late String selectedTitle = activeArr[0]["title"];
  double dailyCalorieIntake = 0.0;

  List<Map<String, dynamic>> activeArr = [
    {
      "image": splashImage,
      "title": sedentaryTitle,
      "subtitle": sedentarySubTitle
    },
    {"image": splashImage, "title": lightlyTitle, "subtitle": lightlySubTitle},
    {
      "image": splashImage,
      "title": moderatelyTitle,
      "subtitle": moderatelySubTitle
    },
    {"image": splashImage, "title": veryTitle, "subtitle": verySubTitle},
    {"image": splashImage, "title": extraTitle, "subtitle": extraSubTitle},
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: CarouselSlider(
                items: activeArr
                    .map(
                      (gObj) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: TColor.primaryG,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: media.width * 0.1, horizontal: 25),
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: Column(
                            children: [
                              Image.asset(
                                gObj["image"].toString(),
                                width: media.width * 0.5,
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                height: media.width * 0.1,
                              ),
                              Text(
                                gObj["title"].toString(),
                                style: TextStyle(
                                    color: TColor.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              Container(
                                width: media.width * 0.1,
                                height: 1,
                                color: TColor.white,
                              ),
                              SizedBox(
                                height: media.width * 0.02,
                              ),
                              Text(
                                gObj["subtitle"].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: TColor.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.7,
                  aspectRatio: 0.74,
                  initialPage: 0,
                  onPageChanged: (index, _) {
                    setState(() {
                      selectedTitle = activeArr[index]["title"];
                    });
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: media.width,
              child: Column(
                children: [
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  Text(
                    activityLevel,
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    helpFiCalorie,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.gray, fontSize: 12),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  RoundButton(
                    title: "Confirm",
                    onPressed: () async {
                      double bmr = CalculateBMR.calculateBMR(
                          widget.selectedWeight,
                          widget.selectedHeight,
                          widget.selectedAge,
                          widget.selectedGender);
                      dailyCalorieIntake = CalculateBMR()
                          .calculateDailyCalorieIntake(bmr, selectedTitle);
                      print(selectedTitle);
                      print(widget.selectedGender);
                      print(widget.selectedAge);
                      print(widget.selectedHeight);
                      print(widget.selectedWeight);
                      print(dailyCalorieIntake);
                      await SignUpDataChannel.submitSignUpData(
                          widget.username,
                          widget.email,
                          widget.password,
                          widget.selectedGender,
                          widget.selectedAge,
                          widget.selectedWeight,
                          widget.selectedHeight,
                          selectedTitle,
                          dailyCalorieIntake);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
