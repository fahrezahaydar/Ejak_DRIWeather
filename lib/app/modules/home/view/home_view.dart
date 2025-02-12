import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_svg.dart';
import '../../../core/utils/extension.dart';
import '../../../core/widget/primary_button.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.w,
          children: [
            SvgPicture.asset(
              AppSvgs.location,
              width: 40.r,
              fit: BoxFit.fitWidth,
            ),
            Text(
              "Semarang",
              style: ts.headlineSmall?.copyWith(
                color: AppColors.white,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.white,
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppSvgs.notif,
              width: 40,
              fit: BoxFit.fitWidth,
            ),
          )
        ],
      ),
      body: _buildBackground(
        children: [
          Image.asset(
            AppImages.sunCloudy,
            width: 175,
            fit: BoxFit.fitWidth,
          ),
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
            "Weather Details",
            icon: Icon(Icons.chevron_right),
            onPressed: () {},
          ),
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
            top: -54.r,
            left: -25.r,
            child: SvgPicture.asset(
              AppSvgs.homeBg,
              width: 509.r,
              fit: BoxFit.fitWidth,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(32.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 20.h,
                children: children,
              ),
            ),
          ),
        ],
      ),
    ).withGradientBg(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color(0xFF4A9EF7),
        Colors.white,
      ],
    );
  }
}
