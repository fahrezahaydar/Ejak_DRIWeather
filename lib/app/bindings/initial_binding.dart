import 'package:get/get.dart';

import '../services/locations/location_services.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationService>(
      () => LocationServiceImpl(),
      fenix: true,
    );
  }
}
