import 'package:calory/src/features/authentication/screens/add_nutrients_screen/add_nutrients.dart';
import 'package:calory/src/features/authentication/screens/add_nutrients_screen/new_nutrients.dart';
import 'package:calory/src/features/authentication/screens/home_screen/home_view.dart';
import 'package:calory/src/features/authentication/screens/main_tab/main_tab_view.dart';
import 'package:calory/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: AddNutrients()//(username: 'Gokul', password: 'Gokul@123', email: 'gokul123@gmail.com'),
    );
  }
}



