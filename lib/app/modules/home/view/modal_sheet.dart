import 'dart:ui';

import 'package:ejak_driweather/app/core/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../controller/home_controller.dart';
import '../widget/notification_tile.dart';

class HomeModalSheet extends StatelessWidget {
  HomeModalSheet({super.key});
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
      child: Container(
        height: context.height,
        width: context.width,
        alignment: Alignment.bottomCenter,
        child: Container(
          width: context.width,
          height: 500.h,
          padding: EdgeInsets.only(top: 8.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.r),
            ),
          ),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.45 * context.width),
                child: Divider(
                  color: AppColors.secondaryText,
                  thickness: 2,
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.fromLTRB(32.w, 16.h, 32.w, 16.h),
                child: Text(
                  "Your Notifications",
                  style: ts.headlineSmall?.copyWith(
                    color: AppColors.secondaryText,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 8.h),
                child: Text(
                  "New",
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: ts.labelSmall?.copyWith(
                    color: AppColors.primaryButtonText,
                  ),
                ),
              ),
              ...controller.notification.where((val) => val.isNew).map((val) {
                return NotificationTile(
                  isUnread: true,
                  svgAssets: val.weather,
                  title: val.message,
                  subitle: val.timeAgo,
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 8.h),
                child: Text(
                  "Earlier",
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: ts.labelSmall?.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
              ...controller.notification.where((val) => !val.isNew).map((val) {
                return NotificationTile(
                  svgAssets: val.weather,
                  title: val.message,
                  subitle: val.timeAgo,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
