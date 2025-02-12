import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../config/pages.dart';
import '../../../core/utils/extension.dart';
import '../../../core/widget/primary_button.dart';
import '../controller/onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildBackground(
        children: [
          Text(
            'Never get caught \nin the rain again',
            style: ts.headlineMedium,
            textAlign: TextAlign.start,
          ),
          Text(
            'Stay ahead of the weather with our accurate forecasts',
            style: ts.bodyMedium,
            textAlign: TextAlign.start,
          ),
          PrimaryButton(
            "Get Started",
            minimumSize: Size.fromHeight(64.h),
            onPressed: () {
              Get.offNamed(Routes.HOME);
            },
          ),
          SizedBox(height: 96.h)
        ],
      ),
    );
  }

  Widget _buildBackground({required List<Widget> children}) {
    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -150.h,
            left: -32.w,
            child: SvgPicture.asset(
              "assets/svg/onboard_deco.svg",
              height: 800.h,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            top: 80.h,
            left: -80.w,
            child: Image.asset(
              "assets/images/onboard_sun.png",
              width: 172.5.h,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            bottom: 202.h,
            left: 61.w,
            child: SvgPicture.asset(
              "assets/svg/onboard_cloud.svg",
              width: 600.h,
              fit: BoxFit.fitHeight,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(54.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 20.h,
                children: children,
              ),
            ),
          ),
        ],
      ),
    ).withGradientBg(
      colors: [
        Color(0xFF4A9EF7),
        Colors.white,
      ],
    );
  }
}
