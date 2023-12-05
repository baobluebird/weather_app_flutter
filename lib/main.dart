import 'package:health_tracker/page/home_page.dart';
import 'package:health_tracker/page/weather_page.dart';
import 'package:health_tracker/utils/color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: WeatherPage(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: homeColor,
      )

    );
  }
}


