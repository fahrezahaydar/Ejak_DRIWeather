import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../../../../config/pages.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_svg.dart';
import '../../../core/utils/extension.dart';
import '../../../core/widget/primary_button.dart';
import '../controller/home_controller.dart';
import 'modal_sheet.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return Obx(() {
      bool isLoading = controller.weatherData.value == null;
      final data = controller.weatherData.value;
      return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TextButton(
            onPressed: () => Get.toNamed(Routes.SEARCH),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 6.w,
              children: [
                SvgPicture.asset(
                  AppSvgs.location,
                  width: 40.w,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 6.h, 0, 0),
                  child: Text(
                    controller.city.value!.name,
                    style: ts.headlineSmall?.copyWith(
                      color: AppColors.white,
                      fontSize: 24.h,
                      shadows: [
                        Shadow(
                          offset: Offset(-2.0, 3.0),
                          blurRadius: 1.0,
                          color: Color.fromARGB(25, 0, 0, 0),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 6.h, 0, 0),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.white,
                  ),
                )
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.bottomSheet(
                  HomeModalSheet(),
                  backgroundColor: Color.fromRGBO(140, 140, 140, 0.2),
                );
              },
              icon: SvgPicture.asset(
                controller.haveNewNotif.value
                    ? AppSvgs.notifAalert
                    : AppSvgs.notif,
                width: 40.w,
                fit: BoxFit.fitWidth,
              ),
            )
          ],
        ),
        body: _buildBackground(
            child: !isLoading
                ? Column(
                    spacing: 20.h,
                    children: [
                      Image.asset(
                        data!.weatherAsset,
                        height: 175.h,
                        fit: BoxFit.fitHeight,
                      ),
                      Container(
                        constraints: BoxConstraints(minWidth: double.maxFinite),
                        padding: EdgeInsets.all(24.r),
                        decoration: BoxDecoration(
                          color: AppColors.white30,
                          border: GradientBoxBorder(
                            gradient: RadialGradient(
                              colors: [
                                AppColors.white.withAlpha(178),
                                AppColors.gray.withAlpha(178),
                              ],
                            ),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              data.dateNow,
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
                            ).withInnerShadow(),
                            SizedBox(height: 16.h),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  data.temperature.toString(),
                                  style: ts.bodyLarge?.copyWith(
                                    color: AppColors.white,
                                    fontSize: 100.sp,
                                    height: 0,
                                  ),
                                ).withInnerShadow(),
                                Text(
                                  "\u00B0",
                                  style: ts.bodyLarge?.copyWith(
                                    color: AppColors.white,
                                    fontSize: 72.h,
                                  ),
                                ).withInnerShadow()
                              ],
                            ),
                            Text(
                              data.weatherDescription,
                              style: ts.headlineSmall?.copyWith(
                                color: AppColors.white,
                                fontSize: 24.h,
                                shadows: [
                                  Shadow(
                                    offset: Offset(-2.0, 3.0),
                                    blurRadius: 1.0,
                                    color: Color.fromARGB(25, 0, 0, 0),
                                  )
                                ],
                              ),
                            ).withInnerShadow(),
                            SizedBox(height: 32.h),
                            Column(
                              spacing: 10.h,
                              children: [
                                _weatherDetail(
                                  svgAsset: AppSvgs.wind,
                                  title: "Wind",
                                  ts: ts,
                                  value: "${data.windSpeed} Km/h",
                                ),
                                _weatherDetail(
                                  svgAsset: AppSvgs.hum,
                                  title: "Hum",
                                  ts: ts,
                                  value: "${data.humidity}%",
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      PrimaryButton(
                        "Weather Details",
                        icon: Icon(Icons.chevron_right),
                        onPressed: () => Get.toNamed(
                          Routes.DETAILS,
                          arguments: {"loc": controller.city.string},
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  )),
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

  Widget _weatherDetail(
      {required String svgAsset,
      required TextTheme ts,
      required String title,
      required String value}) {
    return Row(
      spacing: 18.w,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Row(
            spacing: 18.w,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                svgAsset,
                height: 40.h,
                fit: BoxFit.fitHeight,
              ),
              Text(
                title,
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
              ).withInnerShadow(),
            ],
          ),
        ),
        Container(
          width: 1,
          height: 20,
          color: Colors.white,
        ),
        Expanded(
          child: Text(
            value,
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
          ).withInnerShadow(),
        ),
      ],
    );
  }
}
