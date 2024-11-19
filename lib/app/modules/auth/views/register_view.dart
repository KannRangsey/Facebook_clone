import 'package:facebook_clone/app/modules/auth/controllers/login_controller.dart';
import 'package:facebook_clone/app/modules/auth/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingUpView extends GetView<SignupController> {
  // SignupController extends GetxController mean we can use controller in this class
  SingUpView({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //register controller
  @override
  final controller = Get.put(SignupController());
  final loginController = Get.put(LoginController());
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<SignupController>(builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              if (controller.image == null)
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                                ),
                              if (controller.image != null)
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(controller.image!),
                                ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      controller.pickImage();
                                    },
                                    icon: const Icon(Icons.add_a_photo),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                        border: OutlineInputBorder(),
                        hintText: 'Enter your name',
                      ),
                      // validator
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.blue),
                        border: OutlineInputBorder(),
                        hintText: 'Enter your email',
                      ),
                      // validator
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
                    Obx(
                      () => TextFormField(
                        controller: passwordController,
                        obscureText: !loginController
                            .isPasswordVisible.value, // Show/hide password
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              loginController.isPasswordVisible.value
                                  ? Icons
                                      .visibility // Icon when password is visible
                                  : Icons
                                      .visibility_off, // Icon when password is hidden
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              loginController.togglePasswordVisibility();
                            },
                          ),
                          border: const OutlineInputBorder(),
                          hintText: 'Enter your password',
                        ),
                        // validator
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final name = nameController.text;
                          final email = emailController.text;
                          final password = passwordController.text;
                          final status = await controller.register(
                              name: name, email: email, password: password);
            
                          // reset form
                          if (status) {
                            _formKey.currentState!.reset();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50), // Set the minimum size (full-width button)
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
                          fontSize: 18, // Set the font size of the button's text
                          fontWeight: FontWeight
                              .bold, // Set the font weight of the button's text
                        ),
                      ),
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Row(
                            children: [
                              const Text(
                                'Already have an account? ',
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  'Login'.toUpperCase(),
                                  style:  const TextStyle(fontSize: 20, color: Colors.blue),
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
            const Spacer(),
          ],
        )),
      ),
    );
  }
}
