import 'package:demo_interview_test/home/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: HomeBinding(),
      home: HomeView(
        title: Image.asset(
          "assets/images/ford_logo.png",
          color: const Color.fromRGBO(38, 109, 246, 1),
          // scale: 8,
          height: 40,
          width: 80,
        ),
      ),
    );
  }
}
