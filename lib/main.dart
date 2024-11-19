import 'package:facebook_clone/app/modules/auth/bindings/auth_binding.dart';
import 'package:facebook_clone/app/modules/auth/views/login_view.dart';
import 'package:facebook_clone/app/modules/auth/views/register_view.dart';
import 'package:facebook_clone/app/modules/main/bindings/main_binding.dart';
import 'package:facebook_clone/app/modules/main/middleware/main_middleware.dart';
import 'package:facebook_clone/app/modules/main/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        initialRoute: '/main', // first page to show when app starts
        getPages: [
          GetPage(
              name: '/login', page: () => LoginView(), binding: AuthBinding()),
          GetPage(
              name: '/register',
              page: () => SingUpView(),
              binding: AuthBinding()),
          GetPage(
            name: '/main',
            page: () => const MainView(),
            middlewares: [MainMiddleware()],
            binding: MainBinding(),
          ),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
