import 'package:bounce/bounce.dart';
import 'package:calory/src/common_widgets/calorie_diet_view.dart';
import 'package:calory/src/features/authentication/screens/login_screen/login_screen.dart';
import 'package:calory/src/features/authentication/screens/meal_planner/meal_schedule_screen.dart';
import 'package:calory/src/features/authentication/screens/meals_list_view/meals_list_view.dart';
import 'package:flutter/material.dart';
import 'package:calory/src/common/channels/dart_to_java_channels/home_channel.dart';
import 'package:intl/intl.dart';
import '../../../../constants/colors.dart';
import '../water_screen/water_view.dart';

class HomeView extends StatefulWidget {
  final String email;
  const HomeView({super.key , required this.email});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {

  late String username = '';
  late String email = widget.email;
  late double targetCal = 0.0;
  late double waterLv = 0.0;
  late int waterPr = 0;
  late String waterTm = '--';
  late String currentDate;


  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    _controller.forward();
    fetchUserData();
    currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchUserData() async {
    await fetchUser(); // Wait for fetchUser to complete
  }

  Future<void> fetchUser() async {
    final Map<dynamic, dynamic>? userData =
    await HomeDataChannel.getCurrentUser();
    if(userData != null){
      final String uName = userData['name'].toString();
      final String uEmail = userData['email'].toString();

      setState(() {
        username = uName;
        email = uEmail;
      });
    }else{
      print('Failed to retrieve user data.');
    }
  }

  @override
  Widget build(BuildContext context) {

    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back,",
                          style: TextStyle(color: TColor.gray, fontSize: 12),
                        ),
                        Text(
                          username ?? "",
                          style: TextStyle(
                              color: TColor.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                         HomeDataChannel.disableUser(email);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const LoginScreen()),
                        );
                      },
                      icon: Icon(Icons.logout),
                    ),
                    /*IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/images/notification_active.png",
                        width: 25,
                        height: 25,
                        fit: BoxFit.fitHeight,
                      ),
                    ),*/
                  ],
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return FadeTransition(
                      opacity: _animation,
                      child: Transform(
                        transform: new Matrix4.translationValues(
                            0.0, 30 * (1.0 - _animation!.value), 0.0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text('Daily Kcal Analyser',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          letterSpacing: 0.5,
                                          color: Color(0xFF17262A))),
                                ),
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                           MealScheduleScreen(email: email,)),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Customize',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                            letterSpacing: 0.5,
                                            color: Color(0xFF2633C5),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 38,
                                          width: 26,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Color(0xFF253840),
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Bounce(
                  child: CalorieDietView(
                    animationController: _controller,
                    animation: _animation,
                    email: email,
                    date: currentDate
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return FadeTransition(
                      opacity: _animation,
                      child: Transform(
                        transform: new Matrix4.translationValues(
                            0.0, 30 * (1.0 - _animation!.value), 0.0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text('Water',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          letterSpacing: 0.5,
                                          color: Color(0xFF17262A))),
                                ),
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Aqua SmartBottle',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                            letterSpacing: 0.5,
                                            color: Color(0xFF2633C5),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 38,
                                          width: 26,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Color(0xFF253840),
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Bounce(
                    child: WaterView(
                  mainScreenAnimationController: _controller,
                  mainScreenAnimation: _animation,
                      email: email,
                )),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return FadeTransition(
                      opacity: _animation,
                      child: Transform(
                        transform: new Matrix4.translationValues(
                            0.0, 30 * (1.0 - _animation!.value), 0.0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text('Meals Today',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          letterSpacing: 0.5,
                                          color: Color(0xFF17262A))),
                                ),
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                           MealScheduleScreen(email: email)),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Customize',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                            letterSpacing: 0.5,
                                            color: Color(0xFF2633C5),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 38,
                                          width: 26,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Color(0xFF253840),
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                MealsListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
