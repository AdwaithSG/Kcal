import 'dart:async';
import 'dart:ffi';

import 'package:bounce/bounce.dart';
import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:calory/src/common/channels/dart_to_java_channels/meal_schedule_channel.dart';
import 'package:calory/src/common_widgets/round_button.dart';
import 'package:calory/src/constants/image_strings.dart';
import 'package:calory/src/constants/text_string.dart';
import 'package:calory/src/features/authentication/screens/add_nutrients_screen/add_nutrients.dart';
import 'package:calory/src/features/authentication/screens/meal_planner/food_selection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../../common/models/calories_daily.dart';
import '../../../../common_widgets/calorie_diet_view.dart';
import '../../../../common_widgets/meal_food_schedule_row.dart';
import '../../../../common_widgets/nutritions_row.dart';
import '../../../../constants/colors.dart';

class MealScheduleScreen extends StatefulWidget {
  final String email;

  const MealScheduleScreen({super.key, required this.email});

  @override
  State<MealScheduleScreen> createState() => _MealScheduleScreenState();
}

class _MealScheduleScreenState extends State<MealScheduleScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final CalendarAgendaController _calendarAgendaControllerAppBar =
      CalendarAgendaController();

  late DateTime _selectedDateAppBBar;

  late String currentDate;

  List<String> selectedFoodItems = []; //marked food items list

  //Map<dynamic, dynamic>? fetchedFoodInfo;

  late List<dynamic> fetchedFoodInfo;

  List<dynamic> fetchedBreakfast = [];
  List<dynamic> fetchedLunch = [];
  List<dynamic> fetchedSnacks = [];
  List<dynamic> fetchedDinner = [];

  List breakfastArr = [];
  List lunchArr = [];
  List snacksArr = [];
  List dinnerArr = [];

  List nutritionArr = [
    {
      "title": "Calories",
      "image": splashImage,
      "unit_name": "kCal",
      "value": "350",
      "max_value": "500",
    },
    {
      "title": "Proteins",
      "image": splashImage,
      "unit_name": "g",
      "value": "300",
      "max_value": "1000",
    },
    {
      "title": "Fats",
      "image": splashImage,
      "unit_name": "g",
      "value": "140",
      "max_value": "1000",
    },
    {
      "title": "Carbo",
      "image": splashImage,
      "unit_name": "g",
      "value": "140",
      "max_value": "1000",
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedDateAppBBar = DateTime.now();
    currentDate = DateFormat('yyyy-MM-dd').format(_selectedDateAppBBar);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    _controller.forward();
    fetchFoodData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> updateFoodConsumed(String date, String email, bool consumed,
      double weight, String image, String meal, String foodName) async {
    await updateConsumed(date, email, consumed, weight, image, meal, foodName);
  }

  Future<void> updateConsumed(String date, String email, bool consumed,
      double weight, String image, String meal, String foodName) async {
    try {
      await MealScheduleDataChannel.updateConsumed(
          date, email, consumed, weight, image, meal, foodName);
    } catch (e) {
      print('Failed to update consumed: $e');
    }
  }

  Future<void> fetchFoodData() async {
    await fetchFood(); // Wait for fetchUser to complete
    showUserFood(); // Now call fetchUserInfo
  }

  void showUserFood() {
    //print(fetchedFoodInfo);
    fetchedBreakfast = [];
    fetchedLunch = [];
    fetchedSnacks = [];
    fetchedDinner = [];
    for (var item in fetchedFoodInfo) {
      if (item['meal'] == 'BreakFast') {
        fetchedBreakfast.add(item);
      } else if (item['meal'] == 'Lunch') {
        fetchedLunch.add(item);
      } else if (item['meal'] == 'Snacks') {
        fetchedSnacks.add(item);
      } else {
        fetchedDinner.add(item);
      }
    }
  }

  Future<void> fetchFood() async {
    try {
      List<dynamic> caloriesList =
          await MealScheduleDataChannel.getScheduleFoodInfo(
              currentDate, widget.email);
      setState(() {
        fetchedFoodInfo = caloriesList;
      });
      // print(caloriesList);
    } catch (e) {
      print('Failed to fetch calories list: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchFoodData();
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Meal  Schedule",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          Text("Add Nutrients->",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddNutrients()),
              );
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarAgenda(
            controller: _calendarAgendaControllerAppBar,
            appbar: false,
            selectedDayPosition: SelectedDayPosition.center,
            leading: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/arrow-left.png",
                  width: 15,
                  height: 15,
                )),
            training: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/arrow-right.png",
                  width: 15,
                  height: 15,
                )),
            weekDay: WeekDay.short,
            dayNameFontSize: 12,
            dayNumberFontSize: 16,
            dayBGColor: Colors.grey.withOpacity(0.15),
            titleSpaceBetween: 15,
            backgroundColor: Colors.transparent,
            // fullCalendar: false,
            fullCalendarScroll: FullCalendarScroll.horizontal,
            fullCalendarDay: WeekDay.short,
            selectedDateColor: Colors.white,
            dateColor: Colors.black,
            locale: 'en',
            initialDate: DateTime.now(),
            calendarEventColor: TColor.primaryColor2,
            firstDate: DateTime.now().subtract(const Duration(days: 140)),
            lastDate: DateTime.now().add(const Duration(days: 60)),

            onDateSelected: (date) {
              _selectedDateAppBBar = date;
              setState(() {
                currentDate =
                    DateFormat('yyyy-MM-dd').format(_selectedDateAppBBar);
                fetchFoodData();
                Bounce(
                  child: CalorieDietView(
                    animationController: _controller,
                    animation: _animation,
                    email: widget.email,
                    date: currentDate,
                  ),
                );
              });
            },
            selectedDayLogo: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: TColor.primaryG,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Bounce(
            child: CalorieDietView(
              animationController: _controller,
              animation: _animation,
              email: widget.email,
              date: currentDate,
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: TColor.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 2)
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              child: Text(
                                "BreakFast",
                                style: TextStyle(
                                    color: TColor.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.02,
                            ),
                            Text(
                              "(${fetchedBreakfast.length} Items )",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 12),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FoodSelectionScreen(
                                                meal: 'BreakFast',
                                                email: widget.email)),
                                  );
                                },
                                icon: const Icon(
                                    Icons.add_circle_outline_outlined)),
                          ],
                        ),
                      ),
                      ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: fetchedBreakfast.length,
                          itemBuilder: (context, index) {
                            var mObj = fetchedBreakfast[index] as Map? ?? {};
                            return MealFoodScheduleRow(
                              mObj: mObj,
                              index: index,
                              onCheckboxChanged: (food, isChecked) {
                                // for handling checkbox changes
                                setState(() {
                                  if (isChecked) {
                                    //selectedFoodItems.add(foodName);
                                    updateFoodConsumed(
                                        food["date"].toString(),
                                        food["emailId"].toString(),
                                        isChecked,
                                        double.parse(food["weight"].toString()),
                                        food["image"].toString(),
                                        food["meal"].toString(),
                                        food["foodName"]
                                            .toString()
                                            .toLowerCase());
                                  } else {
                                    //selectedFoodItems.remove(foodName);
                                    updateFoodConsumed(
                                        food["date"].toString(),
                                        food["emailId"].toString(),
                                        isChecked,
                                        double.parse(food["weight"].toString()),
                                        food["image"].toString(),
                                        food["meal"].toString(),
                                        food["foodName"]
                                            .toString()
                                            .toLowerCase());
                                  }
                                });
                              },
                            );
                          }),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: TColor.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 2)
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              child: Text(
                                "Lunch",
                                style: TextStyle(
                                    color: TColor.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.02,
                            ),
                            Text(
                              "(${fetchedLunch.length} Items)",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 12),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FoodSelectionScreen(
                                                meal: 'Lunch',
                                                email: widget.email)),
                                  );
                                },
                                icon: const Icon(
                                    Icons.add_circle_outline_outlined)),
                          ],
                        ),
                      ),
                      ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: fetchedLunch.length,
                          itemBuilder: (context, index) {
                            var mObj = fetchedLunch[index] as Map? ?? {};
                            return MealFoodScheduleRow(
                              mObj: mObj,
                              index: index,
                              onCheckboxChanged: (food, isChecked) {
                                setState(() {
                                  if (isChecked) {
                                    updateFoodConsumed(
                                        food["date"].toString(),
                                        food["emailId"].toString(),
                                        isChecked,
                                        double.parse(food["weight"].toString()),
                                        food["image"].toString(),
                                        food["meal"].toString(),
                                        food["foodName"]
                                            .toString()
                                            .toLowerCase());
                                    //selectedFoodItems.add(foodName);
                                  } else {
                                    updateFoodConsumed(
                                        food["date"].toString(),
                                        food["emailId"].toString(),
                                        isChecked,
                                        double.parse(food["weight"].toString()),
                                        food["image"].toString(),
                                        food["meal"].toString(),
                                        food["foodName"]
                                            .toString()
                                            .toLowerCase());
                                    //selectedFoodItems.remove(foodName);
                                  }
                                });
                              },
                            );
                          }),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: TColor.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 2)
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              child: Text(
                                "Snacks",
                                style: TextStyle(
                                    color: TColor.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.02,
                            ),
                            Text(
                              "(${fetchedSnacks.length} Items)",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 12),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FoodSelectionScreen(
                                                meal: 'Snacks',
                                                email: widget.email)),
                                  );
                                },
                                icon: const Icon(
                                    Icons.add_circle_outline_outlined)),
                          ],
                        ),
                      ),
                      ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: fetchedSnacks.length,
                          itemBuilder: (context, index) {
                            var mObj = fetchedSnacks[index] as Map? ?? {};
                            return MealFoodScheduleRow(
                              mObj: mObj,
                              index: index,
                              onCheckboxChanged: (food, isChecked) {
                                setState(() {
                                  if (isChecked) {
                                    updateFoodConsumed(
                                        food["date"].toString(),
                                        food["emailId"].toString(),
                                        isChecked,
                                        double.parse(food["weight"].toString()),
                                        food["image"].toString(),
                                        food["meal"].toString(),
                                        food["foodName"]
                                            .toString()
                                            .toLowerCase());
                                    // selectedFoodItems.add(foodName);
                                  } else {
                                    updateFoodConsumed(
                                        food["date"].toString(),
                                        food["emailId"].toString(),
                                        isChecked,
                                        double.parse(food["weight"].toString()),
                                        food["image"].toString(),
                                        food["meal"].toString(),
                                        food["foodName"]
                                            .toString()
                                            .toLowerCase());
                                    // selectedFoodItems.remove(foodName);
                                  }
                                });
                              },
                            );
                          }),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: TColor.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 2)
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              child: Text(
                                "Dinner",
                                style: TextStyle(
                                    color: TColor.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.02,
                            ),
                            Text(
                              "(${fetchedDinner.length} Items)",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 12),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FoodSelectionScreen(
                                                meal: 'Dinner',
                                                email: widget.email)),
                                  );
                                },
                                icon: const Icon(
                                    Icons.add_circle_outline_outlined)),
                          ],
                        ),
                      ),
                      ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: fetchedDinner.length,
                          itemBuilder: (context, index) {
                            var mObj = fetchedDinner[index] as Map? ?? {};
                            return MealFoodScheduleRow(
                              mObj: mObj,
                              index: index,
                              onCheckboxChanged: (food, isChecked) {
                                setState(() {
                                  if (isChecked) {
                                    updateFoodConsumed(
                                        food["date"].toString(),
                                        food["emailId"].toString(),
                                        isChecked,
                                        double.parse(food["weight"].toString()),
                                        food["image"].toString(),
                                        food["meal"].toString(),
                                        food["foodName"]
                                            .toString()
                                            .toLowerCase());
                                    //selectedFoodItems.add(foodName);
                                  } else {
                                    updateFoodConsumed(
                                        food["date"].toString(),
                                        food["emailId"].toString(),
                                        isChecked,
                                        double.parse(food["weight"].toString()),
                                        food["image"].toString(),
                                        food["meal"].toString(),
                                        food["foodName"]
                                            .toString()
                                            .toLowerCase());
                                    // selectedFoodItems.remove(foodName);
                                  }
                                });
                              },
                            );
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                /*Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today Meal Nutritions",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),*/
                /*ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: nutritionArr.length,
                    itemBuilder: (context, index) {
                      var nObj = nutritionArr[index] as Map? ?? {};

                      return NutritionRow(
                        nObj: nObj,
                      );
                    }),*/
                /*RoundButton(
                  onPressed: () {
                    //print(selectedFoodItems);
                    print(fetchedFoodInfo);
                    print(fetchedBreakfast);
                    print(fetchedLunch);
                    print(fetchedSnacks);
                    print(fetchedDinner);
                  },
                  title: 'Click',
                ),*/
                SizedBox(
                  height: media.width * 0.05,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
