import 'package:canada/Constants/bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Constants/app_strings.dart';
import 'Routes/app_pages.dart';
import 'Routes/app_routes.dart';



void main() {
  runApp(const DITApp());
}

class DITApp extends StatelessWidget {
  const DITApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Helvetica',
      ),
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      initialBinding: AppBindings(),
    );
  }
}
