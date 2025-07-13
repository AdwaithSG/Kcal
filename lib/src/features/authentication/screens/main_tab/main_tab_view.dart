
import 'package:calory/src/features/authentication/screens/meal_planner/meal_schedule_screen.dart';
import 'package:calory/src/features/authentication/screens/scan_food_screen/new_scan_food.dart';
import 'package:flutter/material.dart';
import '../../../../common_widgets/tab_button.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../home_screen/home_view.dart';
import '../profile_screen/profile_view.dart';


class MainTabView extends StatefulWidget {
  final String email;
  const MainTabView({super.key, required this.email});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  final PageStorageBucket pageBucket = PageStorageBucket(); 
  late Widget currentTab;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      currentTab =  HomeView(email: widget.email,);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: PageStorage(bucket: pageBucket, child: currentTab),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        decoration: BoxDecoration(color: TColor.white, boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, -2))
        ]),
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabButton(
                icon: homeTab,
                selectIcon: homeTabSelect,
                isActive: selectTab == 0,
                onTap: () {
                  selectTab = 0;
                  currentTab =  HomeView(email: widget.email);
                  if (mounted) {
                    setState(() {});
                  }
                }),
            TabButton(
                icon: activityTab,
                selectIcon: activitySelect,
                isActive: selectTab == 1,
                onTap: () {
                  selectTab = 1;
                  currentTab =  MealScheduleScreen(email: widget.email);
                  if (mounted) {
                    setState(() {});
                  }
                }),

              const  SizedBox(width: 40,),
            TabButton(
                icon: cameraTab,
                selectIcon: cameraSelect,
                isActive: selectTab == 2,
                onTap: () {
                  selectTab = 2;
                   currentTab = const NewScanFood();
                  if (mounted) {
                    setState(() {});
                  }
                }),
            TabButton(
                icon: profileTab,
                selectIcon: profileSelect,
                isActive: selectTab == 3,
                onTap: () {
                  selectTab = 3;
                   currentTab =  ProfileView(email: widget.email,);
                  if (mounted) {
                    setState(() {});
                  }
                })
          ],
        ),
      )),
    );
  }
}
