import 'package:get/get.dart';

import '../../modules/onboard/controller/onboard_controller.dart';

class OnboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardController>(
      () => OnboardController(),
    );
  }
}
