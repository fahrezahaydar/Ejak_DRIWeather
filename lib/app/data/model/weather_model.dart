import 'package:ejak_driweather/app/core/constants/app_images.dart';
import 'package:intl/intl.dart';

class WeatherData {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final int weatherCode;
  final DateTime datetime;

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.datetime,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['data']['values']['temperature'].toDouble(),
      humidity: json['data']['values']['humidity'].toInt(),
      windSpeed: json['data']['values']['windSpeed'].toDouble(),
      weatherCode: json['data']['values']['weatherCode'].toInt(),
      datetime: DateTime.parse(json['data']['time']),
    );
  }

  static List<WeatherData> fromForecastDaily(Map<String, dynamic> json) {
    List<dynamic> timeline = json["timelines"]["daily"];
    return timeline.map((val) {
      return WeatherData(
        temperature: val['values']['temperatureAvg'].toDouble(),
        humidity: val['values']['humidityAvg'].toInt(),
        windSpeed: val['values']['windSpeedAvg'].toDouble(),
        weatherCode: val['values']['weatherCodeMax'].toInt(),
        datetime: DateTime.parse(val['time']),
      );
    }).toList();
  }

  static List<WeatherData> fromForecastHourly(Map<String, dynamic> json) {
    List<dynamic> timeline = json["timelines"]["hourly"];
    return timeline.map((val) {
      return WeatherData(
        temperature: val['values']['temperature'].toDouble(),
        humidity: val['values']['humidity'].toInt(),
        windSpeed: val['values']['windSpeed'].toDouble(),
        weatherCode: val['values']['weatherCode'].toInt(),
        datetime: DateTime.parse(val["time"]),
      );
    }).toList();
  }

  String get weatherDescription =>
      _weatherCodeDescriptions[weatherCode] ?? 'Unknown';
  String get weatherAsset => _weatherAsset[weatherCode] ?? AppImages.rainy;

  String get dateNow => DateFormat('EEEE, d MMMM y').format(datetime);

  static const Map<int, String> _weatherCodeDescriptions = {
    0: 'Unknown',
    1000: 'Clear, Sunny',
    1100: 'Mostly Clear',
    1101: 'Partly Cloudy',
    1102: 'Mostly Cloudy',
    1001: 'Cloudy',
    2000: 'Fog',
    2100: 'Light Fog',
    4000: 'Drizzle',
    4001: 'Rain',
    4200: 'Light Rain',
    4201: 'Heavy Rain',
    5000: 'Snow',
    5001: 'Flurries',
    5100: 'Light Snow',
    5101: 'Heavy Snow',
    6000: 'Freezing Drizzle',
    6001: 'Freezing Rain',
    6200: 'Light Freezing Rain',
    6201: 'Heavy Freezing Rain',
    7000: 'Ice Pellets',
    7101: 'Heavy Ice Pellets',
    7102: 'Light Ice Pellets',
    8000: 'Thunderstorm',
  };

  static const Map<int, String> _weatherAsset = {
    0: AppImages.sunny,
    1000: AppImages.sunny,
    1100: AppImages.sunny,
    1101: AppImages.sunCloudy,
    1102: AppImages.sunCloudy,
    1001: AppImages.cloudy,
    2000: AppImages.cloudy,
    2100: AppImages.cloudy,
    4000: AppImages.rainy,
    4001: AppImages.rainy,
    4200: AppImages.rainy,
    4201: AppImages.rainy,
    8000: AppImages.thunder,
  };
}
