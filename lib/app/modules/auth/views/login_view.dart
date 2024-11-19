import 'package:facebook_clone/app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFacebookColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 30),
            // Container(
            //   height: 80,
            //   width: 80,
            //   decoration: const BoxDecoration(
            //     color: Colors.blue,
            //     borderRadius: BorderRadius.all(
            //       Radius.circular(8),
            //     ),
            //   ),
            //   child: const Icon(Icons.facebook, color: kFacebookColor, size: 70),
            // ),
            const Text(
              'Facebook',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),

            Container(
              height: 300.h,
              width: 400.w,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )),
                            prefixIcon: Icon(Icons.email, color: Colors.blue),
                            fillColor: KTextField,
                            filled: true,
                            hintText: 'Enter your email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (GetUtils.isEmail(value) == false) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Obx(() => TextFormField(
                              controller: passwordController,
                              obscureText: !controller.isPasswordVisible
                                  .value, // Show/hide password
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                fillColor: KTextField,
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible.value
                                        ? Icons
                                            .visibility // Icon when password is visible
                                        : Icons
                                            .visibility_off, // Icon when password is hidden
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    controller.togglePasswordVisibility();
                                  },
                                ),
                                hintText: 'Enter your password',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            )),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final email = emailController.text;
                              final password = passwordController.text;
                              controller.login(
                                  email: email, password: password);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity,
                                50), // Set the minimum size (full-width button)
                            backgroundColor: Colors
                                .blue, // Set the background color using your predefined color
                            padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20), // Add padding if needed
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Set the button's border radius
                            ),
                            elevation: 5, // Add elevation for a shadow effect
                            textStyle: const TextStyle(
                              fontSize:
                                  18, // Set the font size of the button's text
                              fontWeight: FontWeight
                                  .bold, // Set the font weight of the button's text
                            ),
                          ),
                          child: Text(
                            'Login'.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Forgot password?'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                width: 150,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              ' or '.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                width: 150,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Row(
                                children: [
                                  const Text(
                                    'Don\'t have an account? ',
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/register');
                                    },
                                    child: Text(
                                      'Register'.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
