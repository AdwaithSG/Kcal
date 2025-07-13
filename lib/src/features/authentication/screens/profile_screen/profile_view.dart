import 'package:bounce/bounce.dart';
import 'package:calory/src/common/channels/dart_to_java_channels/show_profile_channel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../common_widgets/calorie_diet_view.dart';
import '../../../../common_widgets/round_button.dart';
import '../../../../common_widgets/setting_row.dart';
import '../../../../common_widgets/title_subtitle_cell.dart';
import '../../../../constants/colors.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class ProfileView extends StatefulWidget {
  final String email;
  const ProfileView({super.key,required this.email});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with TickerProviderStateMixin{

  late int height = 0;
  late int age = 0;
  late int weight = 0;
  late String name = "";
  late String activityLevel = "";
  late String gender = "";
  late String currentDate;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    _controller.forward();
    fetchUser();
    currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Future<void> fetchUser()async{
    final Map<dynamic, dynamic>? userInfo =
    await ShowProfileDataChannel.getUserProfile(widget.email);
    if(userInfo != null){
      final double height = userInfo['height'];
      final int age = userInfo['age'];
      final double weight = userInfo['weight'];
      final String name = userInfo['name'];
      final String activityLevel = userInfo['activityLevel'];
      final String gender = userInfo['gender'];

      setState(() {
       this.height = height.truncate();
       this.age = age;
       this.weight = weight.truncate();
       this.name = name;
       this.activityLevel = activityLevel;
       this.gender = gender;
      });
    }else{
      print('Failed to retrieve user data.');
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
        title: Text(
          "Profile",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(gender.toLowerCase() == 'female'?
                      "assets/images/u2.png":"assets/images/male.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
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
                          name,
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          activityLevel,
                          style: TextStyle(
                            color: TColor.gray,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 25,
                    child: RoundButton(
                      title: "Edit",
                      type: RoundButtonType.bgGradient,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
               Row(
                children: [
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "$height cm",
                      subtitle: "Height",
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "$weight kg",
                      subtitle: "Weight",
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "$age yo",
                      subtitle: "Age",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Bounce(
                child: CalorieDietView(
                    animationController: _controller,
                    animation: _animation,
                    email: widget.email,
                    date: currentDate
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
