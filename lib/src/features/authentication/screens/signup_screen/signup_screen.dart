import 'package:calory/src/features/authentication/screens/get_profile_screen/get_gender_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../common/validation/validation.dart';
import '../../../../common_widgets/highlighted_rtextfield.dart';
import '../../../../constants/text_string.dart';
import '../login_screen/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final confPassController = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: screenHeight * 0.06),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontFamily: 'Viga',
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Please fill to create an account',
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                            fontFamily: 'Viga',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Form(
                        key: formField,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HighlightRoundTextField(
                                  keyboardType: TextInputType.text,
                                  controller: nameController,
                                  labelText: uName,
                                  prefixIcon: const Icon(
                                    Icons.person_outline_outlined,
                                    color: Colors.black,
                                  ),
                                  validator: Validation.validateUsername),
                              SizedBox(height: screenHeight * 0.04),
                              HighlightRoundTextField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  labelText: email,
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: Colors.black,
                                  ),
                                  validator: Validation.validateEmail),
                              SizedBox(height: screenHeight * 0.04),
                              TextFormField(
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                keyboardType: TextInputType.emailAddress,
                                controller: passController,
                                validator: Validation.validatePassword,
                                obscureText: passToggle,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.03,
                                      horizontal: screenHeight * 0.08),
                                  labelText: uPassword,
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Color.fromARGB(255, 0, 0, 0)),
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
                              SizedBox(height: screenHeight * 0.04),
                              TextFormField(
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                keyboardType: TextInputType.emailAddress,
                                controller: confPassController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Password";
                                  } else if (value != passController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                obscureText: passToggle,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.03,
                                      horizontal: screenHeight * 0.08),
                                  labelText: confPass,
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Color.fromARGB(255, 0, 0, 0)),
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
                              SizedBox(height: screenHeight * 0.04),
                              Container(
                                width: double.infinity,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formField.currentState!.validate()) {
                                      String username = nameController.text;
                                      String emailTxt = emailController.text;
                                      String password = passController.text;

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GetGenderScreen(
                                                    username: username,
                                                    password: password,
                                                    email: emailTxt)),
                                      );
                                    }
                                  },
                                  color: Colors.black,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.030,
                                    horizontal: screenWidth * 0.04,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.08),
                                  ),
                                  child: Text(
                                    signUp.toUpperCase(),
                                    style:
                                        TextStyle(fontSize: screenWidth * 0.04),
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
                                              const LoginScreen()),
                                    );
                                  },
                                  child: const Text(
                                    "Already have an account? Login",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
