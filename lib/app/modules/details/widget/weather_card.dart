import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/model/weather_model.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard(this.data, {super.key});
  final WeatherData data;
  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    bool isNow = data.datetime.hour == DateTime.now().hour;
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: isNow
          ? BoxDecoration(
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
              borderRadius: BorderRadius.circular(20.h),
            )
          : BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12.h,
        children: [
          Text(
            "${data.temperature} \u00B0C",
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
          Image.asset(
            data.weatherAsset,
            height: 48.h,
            fit: BoxFit.fitHeight,
          ),
          Text(
            DateFormat("HH:mm").format(data.datetime),
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
      ),
    );
  }
}
