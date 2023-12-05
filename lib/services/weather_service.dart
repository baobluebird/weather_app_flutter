import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService{
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather() async{
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      double longitude = position.longitude;
      double latitude = position.latitude;
      final response = await http.get(Uri.parse(
          '$BASE_URL?lat=$latitude&lon=$longitude&appid=$apiKey'));
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      }else{
        throw Exception('Error fetching weather');
      }
  }


  Future<String> getCurrentCity() async{

    LocationPermission permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await GeocodingPlatform.instance.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
        localeIdentifier: "vn"
    );
    String? city = placemarks[0].administrativeArea;
    String? street = placemarks[0].street;
    String? district = placemarks[0].subAdministrativeArea;
    String? fullNameCity = '$street, $district, $city';
    return fullNameCity;

  }
}