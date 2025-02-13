// ignore_for_file: unused_import

import 'package:ejak_driweather/app/data/model/city_model.dart';
import 'package:ejak_driweather/app/data/model/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:nominatim_flutter/model/request/search_request.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';

import '../../../../config/pages.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/model/weather_model.dart';
import '../../../data/repository/weather.dart';
import '../../../services/locations/location_services.dart';

class HomeController extends GetxController {
  RxList<NotificationData> notification = <NotificationData>[].obs;
  Rx<WeatherData?> weatherData = Rxn<WeatherData>();
  RxBool haveNewNotif = false.obs;
  RxBool isLoading = true.obs;
  Rxn<CityModel> city = Rxn<CityModel>();
  Rxn<LatLng> pos = Rxn<LatLng>();

  final LocationService _locationService = Get.find<LocationService>();
  final WeatherRepository weatherRepository = Get.find<WeatherRepository>();

  List<Map<String, String>> dummyNotification = [
    {
      "weather": "sunny",
      "datetime": "2025-02-12 12:24:31.120",
      "message":
          "A sunny day in your location, consider wearing your UV protection"
    },
    {
      "weather": "wind",
      "datetime": "2025-02-11 9:34:22.021",
      "message":
          "A cloudy day will occur all day long, don't worry about the heat of the sun"
    },
    {
      "weather": "rainy",
      "datetime": "2025-02-10 9:20:11.020",
      "message":
          "Potential for rain today is 84%, don't forget to bring your umbrella."
    },
  ];

  @override
  void onInit() async {
    super.onInit();
    try {
      var getPosition = await _locationService.getCurrentLocation();
      pos.value = LatLng(
        getPosition!.latitude,
        getPosition.longitude,
      );
      var res = await _locationService.getCurrentCity(getPosition);

      city.value = CityModel(
        name: lastWord(res!["state"]),
        position: LatLng(
          getPosition.latitude,
          getPosition.longitude,
        ),
      );
    } catch (_) {}

    notification.value = dummyNotification.map((val) {
      return NotificationData.fromMap(val);
    }).toList();

    notification.first.isNew = true;
    haveNewNotif.value = notification.any((val) => val.isNew);
  }

  @override
  void onReady() async {
    city.listen((val) async {
      try {
        var res2 = await getWeatherData();
        weatherData.value = res2;
      } catch (e) {
        print(e);
      }
    });
  }

  String lastWord(String input) {
    input = input.trim();

    List<String> words = input.split(' ');

    return words.isNotEmpty ? words.last : '';
  }

  Future<WeatherData> getWeatherData() async {
    final data =
        await weatherRepository.getRealtimeData(city.value!.name.toLowerCase());
    return WeatherData.fromJson(data);
  }

  TextEditingController search = TextEditingController();
  RxBool showRecent = true.obs;
  RxList<String> recent = [
    "Jakarta",
    "Surabaya",
    "Samarinda",
  ].obs;

  RxList<CityModel> searchQuery = <CityModel>[].obs;

  @override
  void dispose() {
    super.dispose();
    search.dispose();
  }

  void searching(String query) async {
    if (query.length > 3) {
      final searchRequest = SearchRequest(
          query: query,
          limit: 3,
          addressDetails: true,
          extraTags: true,
          nameDetails: true,
          countryCodes: ["id"]
          //country: "indonesia",
          );
      try {
        final searchResult = await NominatimFlutter.instance.search(
          searchRequest: searchRequest,
          language: 'en-US,en;q=0.5',
        );
        if (searchResult.isNotEmpty) {
          searchQuery.value = CityModel.fromNominatism(searchResult);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void searsching(String query) async {
    final searchRequest = SearchRequest(
        query: query,
        limit: 3,
        addressDetails: true,
        extraTags: true,
        nameDetails: true,
        countryCodes: ["id"]
        //country: "indonesia",
        );
    final searchResult = await NominatimFlutter.instance.search(
      searchRequest: searchRequest,
      language: 'en-US,en;q=0.5',
    );

    print(searchResult.first.address);
  }
}
