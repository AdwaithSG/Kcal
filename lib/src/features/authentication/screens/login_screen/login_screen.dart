import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:calory/src/common/channels/dart_to_java_channels/login_channel.dart';
import 'package:flutter/material.dart';
import '../../../../common_widgets/highlighted_rtextfield.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/text_string.dart';
import '../main_tab/main_tab_view.dart';
import '../signup_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;
  final formField = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Viga',
                          fontSize: screenHeight * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.04),
                      child: Transform.scale(
                        scale: 1.4,
                        child: Image.asset(
                          'assets/images/Group71.png', // Path to your image asset
                          // Maintain aspect ratio and fit within the container
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Viga',
                      fontSize: screenHeight * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please fill to continue',
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      fontFamily: 'Viga',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: formField,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HighlightRoundTextField(
                              keyboardType: TextInputType.emailAddress,
                              labelText: 'Email',
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Email";
                                }
                                return null;
                              },
                              prefixIcon: const Icon(Icons.email,
                                  color:  Color.fromARGB(255, 0, 0, 0)),
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            TextFormField(
                              style: const TextStyle(
                                  color:  Color.fromARGB(255, 0, 0, 0)),
                              keyboardType: TextInputType.emailAddress,
                              controller: passController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Password";
                                }
                                return null;
                              },
                              obscureText: passToggle,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color:  Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.03,
                                    horizontal: screenHeight * 0.08),
                                labelText: uPassword,
                                prefixIcon: const Icon(Icons.lock,
                                    color:  Color.fromARGB(255, 0, 0, 0)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      screenHeight * 0.03),
                                ),
                                filled: true,
                                fillColor: const Color.fromARGB(0, 0, 0, 0),
                                suffixIcon: IconButton(
                                  icon: Icon(passToggle
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      passToggle = !passToggle;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: TColor.black,
                                    foregroundColor: darkColor),
                                onPressed: () async {
                                  String email = emailController.text.trim();
                                  String password =
                                  passController.text.trim();

                                  bool isTrue =
                                  await LoginDataChannel.submitLoginData(
                                      email, password);

                                  if (formField.currentState!.validate() &&
                                      isTrue) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MainTabView(email: email)),
                                    );
                                  } else {
                                    ArtSweetAlert.show(
                                        context: context,
                                        artDialogArgs: ArtDialogArgs(
                                            type: ArtSweetAlertType.danger,
                                            title: "Oops...",
                                            text:
                                            "Incorrect Username or Password"));
                                  }
                                },
                                child: Text(
                                  login.toUpperCase(),
                                  style: const TextStyle(color: whiteColor),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen()),
                                  );
                                },
                                child: const Text(
                                  "Don't have an account? Sign up",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.05),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

