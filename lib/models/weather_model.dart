class Weather{
  final double temperatureCelsius;
  final String icon;
  final String description;
  final double humidity;
  final double rainfor1h;
  final String name;
  Weather({
    required this.temperatureCelsius,
    required this.icon,
    required this.description,
    required this.humidity,
    required this.rainfor1h,
    required this.name,
  });
  factory Weather.fromJson(Map<String, dynamic> json){
    try {
      final temperature = json['main']['temp'];
      final icon = json['weather'][0]['icon'];
      final description = json['weather'][0]['description'];
      final humidity = json['main']['humidity'];
      final name = json['name'];
      if(icon == '09d' || icon == '09n' || icon == '10d' || icon == '10n' || icon == '11d' || icon == '11n'){
        final rainfor1h = json['rain']['1h'];
        return Weather(
          temperatureCelsius: temperature - 273.15,
          icon: icon,
          description: description,
          humidity: humidity.toDouble(),
          rainfor1h: rainfor1h.toDouble(),
          name: json['name'],
        );
      }
      return Weather(
        temperatureCelsius: temperature - 273.15,
        icon: icon,
        description: description,
        humidity: humidity.toDouble(),rainfor1h: 0.0,
        name: name,
      );
    } catch (e) {
      print(e);
      throw Exception('Error parsing weather data');
    }

  }

}