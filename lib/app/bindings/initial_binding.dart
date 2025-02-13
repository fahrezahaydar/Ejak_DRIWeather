import 'package:get/get.dart';

import '../data/repository/weather.dart';
import '../services/locations/location_services.dart';
import '../services/networks/api_services.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationService>(
      () => LocationServiceImpl(),
      fenix: true,
    );
    Get.lazyPut<ApiServices>(
      () => ApiServicesImpl(),
      fenix: true,
    );
    Get.lazyPut<WeatherRepository>(
      () => WeatherRepoImpl(Get.find<ApiServices>()),
    );
  }
}
