import 'package:health_tracker/services/fall_service.dart';
import 'package:health_tracker/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/user_model.dart';
import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  List<User> postData = <User>[];
  //api key
  final _weatherService =
      WeatherService(apiKey: 'f8c36f04c06fc095be171a8e52c616e1');
  Weather? _weather;
  String _cityName = "unknown";

  //get current city
  _fetchCity() async {
    try {
      final cityName = await _weatherService.getCurrentCity();
      setState(() {
        _cityName = cityName;
      });
    } catch (e) {
      print("object1");
      print(e);
    }
  }
 // fetch weather
  _fetchWeather() async {
    try {
      final weather = await _weatherService.getWeather();
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("object2");
      print(e);
    }
  }

//init state
  @override
  void initState() {
    super.initState();
    FallService.fetchPosts().then((datafromServer) {
      setState(() {
        postData = datafromServer;
      });
    });
    //fetch weather on starting
    _fetchWeather();
    _fetchCity();
  }
//weather animation
  String getWeatherAnimation(String? icon) {
    switch (icon) {
      case '01d':
        return 'assets/sunny.json';
      case '01n':
        return 'assets/clear_night.json';
      case '02d':
        return 'assets/day_cloudy.json';
      case '02n':
        return 'assets/night_cloudy.json';
      case '03d':
      case '03n':
        return 'assets/cloudy.json';
      case '04d':
      case '04n':
        return 'assets/broken_cloud.json';
      case '09d':
      case '09n':
        return 'assets/rainy.json';
      case '10d':
        return 'assets/day_rainy.json';
      case '10n':
        return 'assets/night_rainy.json';
      case '11d':
      case '11n':
        return 'assets/thunder.json';
      case '13d':
      case '13n':
        return 'assets/snow.json';
      case '50d':
      case '50n':
        return 'assets/mist.json';
      default:
        return 'assets/sunny.json';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _cityName,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white
            ),
          ),
          //animation
          Lottie.asset(getWeatherAnimation(_weather?.icon)),
          //description
          Text(
            _weather?.description ?? "-",
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          ),
          //rain for 1h
          Text(
            'Rain for 1h: ${_weather?.rainfor1h.toStringAsFixed(2) ?? "-"} mm',
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          ),

          //temperature
          Text(
            '${_weather?.temperatureCelsius.toStringAsFixed(2) ?? "-"} °C',
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          ),
          //humidity
          Text(
            'Humidity: ${_weather?.humidity.toStringAsFixed(2) ?? "-"} %',
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          ),
          //name
          Text(
            _weather?.name ?? "-",
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          ),
          postData.isNotEmpty && postData[0].fall == '0' ?
          const Text('Status: not flooded',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          )
              : const Text('Status: not flooded',
            style: TextStyle(
                fontSize: 14,
                color: Colors.white
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.local_hospital), color: Colors.white, iconSize: 50
              ),
              IconButton(
                onPressed: () {
                  _refreshData();
                },
                icon: const Icon(Icons.refresh), color: Colors.white, iconSize: 50
              ),
            ],
          ),
        ],
      ),
    ));
  }
  void _refreshData() {
    _fetchCity();
    _fetchWeather();
  }
}
