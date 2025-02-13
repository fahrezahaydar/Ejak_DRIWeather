import 'package:ejak_driweather/app/modules/details/widget/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_svg.dart';
import '../../../core/utils/extension.dart';
import '../controller/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return Obx(() {
      bool isLoading = controller.daily.value == null;
      return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.chevron_left_rounded),
          ),
          leadingWidth: 40,
          title: Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              "Back",
              style: ts.headlineSmall?.copyWith(
                color: AppColors.white,
                fontSize: 24.h,
                height: 0,
              ),
            ),
          ),
        ),
        body: _buildBackground(
          child: !isLoading
              ? Column(
                  spacing: 20.h,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Today",
                          style: ts.headlineSmall?.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          DateFormat("MMM, d").format(controller.now),
                          style: ts.bodyLarge?.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 12.h,
                        children: controller.hourly.value!.map((res) {
                          return WeatherCard(res);
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Row(
                        children: [
                          Text(
                            "Next Forecast",
                            style: ts.headlineSmall?.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        thickness: 6,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(right: 32),
                          child: Column(
                            spacing: 8.h,
                            children: controller.daily.value!.map((data) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat("MMM, d").format(data.datetime),
                                    style: ts.titleLarge?.copyWith(
                                      color: AppColors.white,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(-2.0, 3.0),
                                          blurRadius: 1.0,
                                          color: Color.fromARGB(25, 0, 0, 0),
                                        )
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    data.weatherAsset,
                                    height: 60.h,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  Text(
                                    "${data.temperature} \u00B0",
                                    style: ts.bodyLarge?.copyWith(
                                      color: AppColors.white,
                                      fontSize: 18.h,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(-2.0, 3.0),
                                          blurRadius: 1.0,
                                          color: Color.fromARGB(25, 0, 0, 0),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10.w,
                      children: [
                        Icon(
                          Icons.sunny,
                          color: AppColors.white,
                        ),
                        Text(
                          "DRI Weather",
                          style: ts.bodyLarge!.copyWith(
                            color: AppColors.white,
                            height: 1.1,
                          ),
                        ).down(),
                      ],
                    )
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                ),
        ),
      );
    });
  }

  Widget _buildBackground({required Widget child}) {
    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 569.r,
            left: -25.r,
            child: SvgPicture.asset(
              AppSvgs.homeBg,
              width: 509.w,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            width: Get.context!.width,
            height: Get.context!.height,
            child: Padding(
              padding: EdgeInsets.all(32.r),
              child: child,
            ),
          ),
        ],
      ),
    ).withGradientBg(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        AppColors.homeGradient1,
        AppColors.homeGradient2,
      ],
    );
  }
}
