import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/pages.dart';
import '../../../core/constants/app_colors.dart';
import '../../../services/locations/location_services.dart';

class OnboardController extends GetxController {
  final LocationService _locationService = Get.find<LocationService>();

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  Future<void> checkPermission() async {
    bool isGranted = await _locationService.requestPermission();
    if (isGranted) {
      Get.offNamed(Routes.HOME);
    }
  }

  Future<void> requestPermission() async {
    bool isGranted = await _locationService.requestPermission();
    if (isGranted) {
      Get.offNamed(Routes.HOME);
    } else {
      Get.snackbar(
        "Permission Denied",
        "Location permission is required.",
        backgroundColor: AppColors.error,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(54.r),
      );
    }
  }
}
