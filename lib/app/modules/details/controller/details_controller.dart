// ignore_for_file: unused_import, unused_local_variable

import 'package:ejak_driweather/app/data/model/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../config/debug.dart';
import '../../../../config/pages.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/model/weather_model.dart';
import '../../../data/repository/weather.dart';
import '../../../services/locations/location_services.dart';

class DetailsController extends GetxController {
  final WeatherRepository weatherRepository = Get.find<WeatherRepository>();
  RxString test = "Tst".obs;
  Rxn<List<WeatherData>> daily = Rxn<List<WeatherData>>();
  Rxn<List<WeatherData>> hourly = Rxn<List<WeatherData>>();
  DateTime get now => DateTime.now();
  DateTime get twoHoursAgo => DateTime.now().subtract(Duration(hours: 2));

  DateTime lastHourofDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    23,
    59,
    59,
  );

  @override
  void onInit() async {
    super.onInit();
    final arg = Get.arguments;
    final String loc = arg["loc"];
    try {
      var res = await getForecastHourly(loc);
      hourly.value = List.from(res);
      var res2 = await getForecastDaily(loc);
      daily.value = List.from(res2);
    } catch (_) {}
  }

  String lastWord(String input) {
    input = input.trim();

    List<String> words = input.split(' ');

    return words.isNotEmpty ? words.last : '';
  }

  Future<List<WeatherData>> getForecastDaily(String loc) async {
    final data =
        await weatherRepository.getForeCastData(loc, ForecastTimesteps.daily);
    return WeatherData.fromForecastDaily(data);
  }

  Future<List<WeatherData>> getForecastHourly(String loc) async {
    final res =
        await weatherRepository.getForeCastData(loc, ForecastTimesteps.hourly);
    final data = WeatherData.fromForecastHourly(res);
    final filteredData = data.where((val) {
      return val.datetime.hour > twoHoursAgo.hour &&
          val.datetime.isBefore(lastHourofDay);
    }).toList();
    return filteredData;
  }
}
