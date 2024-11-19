// import 'package:facebook_clone/app/modules/auth/controllers/register_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/utils.dart';

// class SingUpView extends GetView<SignupController> {
//   // SignupController extends GetxController mean we can use controller in this class
//   SingUpView({super.key});

//   final _formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   //register controller
//   @override
//   final controller = Get.put(SignupController());
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//         children: [
//           const Spacer(),
//           const SizedBox(height: 20),
//           Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GetBuilder<SignupController>(builder: (_) {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Stack(
//                           children: [
//                             if (controller.image == null)
//                               const CircleAvatar(
//                                 radius: 50,
//                                 backgroundImage: NetworkImage(
//                                     'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
//                               ),
//                             if (controller.image != null)
//                               CircleAvatar(
//                                 radius: 50,
//                                 backgroundImage: FileImage(controller.image!),
//                               ),
//                             Positioned(
//                               bottom: 0,
//                               right: 0,
//                               child: Container(
//                                 height: 40,
//                                 width: 40,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(50),
//                                 ),
//                                 child: IconButton(
//                                   onPressed: () {
//                                     controller.pickImage();
//                                   },
//                                   icon: const Icon(Icons.add_a_photo),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     );
//                   }),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     controller: nameController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Enter your name',
//                     ),
//                     // validator
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter your name';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     controller: emailController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Enter your email',
//                     ),
//                     // validator
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       if (GetUtils.isEmail(value) == false) {
//                         return 'Please enter a valid email';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Enter your password',
//                     ),
//                     // validator
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter your password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be at least 6 characters';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         final name = nameController.text;
//                         final email = emailController.text;
//                         final password = passwordController.text;
//                         final status = await controller.register(
//                             name: name, email: email, password: password);

//                         // reset form
//                         if (status) {
//                           _formKey.currentState!.reset();
//                         }
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: const Size(double.infinity, 50),
//                       backgroundColor: Colors.blue,
//                     ),
//                     child: Text(
//                       'Register'.toUpperCase(),
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Center(
//                         child: TextButton(
//                           onPressed: () {
//                             Get.back();
//                           },
//                           child: Row(
//                             children: [
//                               const Text(
//                                 'Already have an account? ',
//                               ),
//                               Text(
//                                 'Login'.toUpperCase(),
//                                 style: const TextStyle(fontSize: 20),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const Spacer(),
//         ],
//       )),
//     );
//   }
// }
