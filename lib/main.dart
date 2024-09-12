import 'package:flutter/material.dart';
import 'package:weatherforecast/Screens/forecast.dart';
import 'package:weatherforecast/Screens/home.dart';
import 'package:weatherforecast/Screens/splash.dart';
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}