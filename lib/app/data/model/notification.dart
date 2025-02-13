import 'package:ejak_driweather/app/core/constants/app_svg.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:intl/intl.dart';

class NotificationData {
  final String weather;
  final String message;
  final DateTime datetime;
  bool isNew;

  NotificationData({
    required this.weather,
    required this.message,
    required this.datetime,
    this.isNew = false,
  });

  String get timeAgo => GetTimeAgo.parse(datetime);

  static NotificationData fromMap(Map<String, String> data) {
    String weather = "";
    switch (data["weather"]) {
      case "wind":
        weather = AppSvgs.wind;
        break;
      case "rainy":
        weather = AppSvgs.rainy;
        break;
      default:
        weather = AppSvgs.sun;
    }
    return NotificationData(
      weather: weather,
      message: data["message"]!,
      datetime: DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(data["datetime"]!),
    );
  }
}
