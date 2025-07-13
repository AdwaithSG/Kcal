import 'package:calory/src/common/channels/dart_to_java_channels/get_food_names_channel.dart';
import 'package:calory/src/common_widgets/meal_selection_row.dart';
import 'package:calory/src/common_widgets/round_button.dart';
import 'package:calory/src/features/authentication/screens/main_tab/main_tab_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../../../../constants/colors.dart';
import 'helpers/food_quantity.dart';

class FoodSelectionScreen extends StatefulWidget {
  final String meal;
  final String email;


  const FoodSelectionScreen({super.key, required this.meal, required this.email});

  @override
  State<FoodSelectionScreen> createState() => _FoodSelectionScreenState();
}

class _FoodSelectionScreenState extends State<FoodSelectionScreen> {

  late String foodName;
  late String foodWeight;
  late String currentDate;

  List<Map<String, String>> foodListArr = [];

  late int count;

  List<dynamic>? fetchedFoodNames;
  List<dynamic>? fetchedFoodImages;

  // List to hold selected food items and their quantities
  List<Map<String, dynamic>> selectedFoodList = [];

  TextEditingController searchController = TextEditingController();

  // List to hold filtered food items
  List<Map<String, String>> filteredFoodList = [];

  // Current page index for pagination
  int _currentPage = 0;

  // Page size for pagination
  final int _pageSize = 10;

  // Scroll controller to monitor scroll position
  final ScrollController _scrollController = ScrollController();

  // Flag to indicate whether data is being loaded
  bool _isLoading = false;

  // Method to handle when an item is submitted in onItemTapped
  void _onSubmit(Map<String, dynamic> data) {
    // Store the submitted data in the selectedFoodList
    setState(() {
      selectedFoodList.add(data);
    });
  }

  @override
  void initState() {
    count = 0;
    super.initState();
    // Initialize the filtered list with all items initially
    fetchFoodData();
    //filteredFoodList = List.from(foodListArr);
    currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Future<void> fetchFoodData() async {
    await fetchFood(); // Wait for fetchFood to complete
    setState(() {
      // Initialize the filtered list with all items initially
      filteredFoodList = List.from(foodListArr);
    });
    // Load the first page of data
    //_loadMoreData();
    // Add a listener to the scroll controller to detect when the user has scrolled to the bottom
    _scrollController.addListener(() {
      // Load more data when the user reaches the bottom of the list
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //_loadMoreData();
      }
    });
  }

  void _incrementCountAndDbCall() {
    setState(() {
      count++; // Increment the count value
    });
    print(foodName);
    print(foodWeight);
    print(currentDate);
   // submitToDb();
  }

  /*Future<void> submitToDb() async {
     await FoodSearchDataChannel.submitSelectedFoodData(foodName, foodWeight, widget.email, currentDate, widget.meal);
  }*/


  Future<void> fetchFood() async {
    final List<dynamic>? foodNames = await FoodSearchDataChannel.getFoodNames();
    if (foodNames != null) {
      print(foodNames);
      final List<dynamic>? foodImages =
      await FoodSearchDataChannel.getFoodImages();
      print(foodImages);
      setState(() {
        fetchedFoodNames = foodNames;
        fetchedFoodImages = foodImages;
        if (fetchedFoodNames != null) {
          for (int i = 0; i < fetchedFoodNames!.length; i++) {
            String foodName = fetchedFoodNames![i].toString().toUpperCase();
            String foodImage = fetchedFoodImages![i].toString();
            Map<String, String> foodMap = {
              'name': foodName,
              'image': foodImage,
            };
            foodListArr.add(foodMap);
          }
        }
      });
      print(foodListArr);
    } else {
      print('Failed to retrieve food data.');
    }
  }

  // Method to filter the food list based on the search query
  void _filterFoodList(String query) {
    setState(() {
      filteredFoodList = foodListArr
          .where((foodItem) =>
          foodItem['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      // Reset pagination
      _currentPage = 0;
      // Reset the list
      _isLoading = false;
      //_loadMoreData(); // Load the first page of data
    });
  }

  // Method to update foodName and foodWeight
  Future<void> _updateFoodInfo(String name, String quantity)async {
    setState(() {
      foodName = name.toLowerCase();
      foodWeight = quantity.toLowerCase();
    });
      String? status = await FoodSearchDataChannel.submitSelectedFoodData(foodName, foodWeight, widget.email, currentDate, widget.meal);
      print(status);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
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
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        title: Text(
          "Select Food",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                // Handle "Add your own food" button click
              },
              child: Column(
                children: [
                  Text(
                    "Add your own food",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text('$count foods selected'),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: media.width * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      autocorrect: true,
                      controller: searchController,
                      onChanged: (query) {
                        _filterFoodList(
                            query); // Filter the food list based on the search query
                      },
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          prefixIcon: Image.asset(
                            "assets/images/search.png",
                            width: 25,
                            height: 25,
                          ),
                          hintText: "Search Pancake"),
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 1,
                  height: 25,
                  color: TColor.gray.withOpacity(0.3),
                ),
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    "assets/images/filter.png",
                    width: 25,
                    height: 25,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: media.width * 0.10,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredFoodList.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                var foodItem = filteredFoodList[index];
                return MealSelectionRow(
                  mObj: foodItem,
                  index: index,
                  onItemTapped: (item) {
                    onItemTapped(context, item, _onSubmit,_incrementCountAndDbCall, _updateFoodInfo);
                  },
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: RoundButton(
                onPressed: () {
                  MainTabView(email: widget.email);
                },
                title: 'Add to your ${widget.meal}'),
          ),
        ],
      ),
    );
  }
}
