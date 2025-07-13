import 'package:calory/src/constants/image_strings.dart';
import 'package:calory/src/features/authentication/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isButtonPressed = false;

  void handleGetStarted() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
          const LoginScreen()),
    );
    // Add your functionality here
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double titleFontSize = screenWidth * 0.07; // Adjust as needed
    double descriptionFontSize = screenWidth * 0.04; // Adjust as needed

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(welcomeImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Explore, Scan And ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Viga",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Eat',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Viga",
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Healthy!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Viga",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'welcome to calorie counter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: descriptionFontSize,
                      fontFamily: "Viga",
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        isButtonPressed = true;
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        isButtonPressed = false;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        isButtonPressed = false;
                      });
                    },
                    onTap: handleGetStarted, // Call handleGetStarted function
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: isButtonPressed
                            ? Colors.yellow.withOpacity(0.8)
                            : Colors.black,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'GET STARTED',
                          style: TextStyle(
                            color:
                            isButtonPressed ? Colors.black : Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            fontFamily: "Viga",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
