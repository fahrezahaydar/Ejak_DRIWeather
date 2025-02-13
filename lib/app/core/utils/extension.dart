import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../widget/inner_shadow.dart';

extension GradientBackground on Widget {
  Widget withGradientBg({
    required List<Color> colors,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors,
        ),
      ),
      child: this,
    );
  }
}

extension DoubleShadow on Text {
  Widget withInnerShadow({
    Color color = AppColors.white25,
    Offset offset = const Offset(-1.0, 1.0),
    double blurRadius = 2,
  }) {
    return InnerShadow(
      shadows: [
        Shadow(
          offset: offset,
          blurRadius: blurRadius,
          color: color,
        )
      ],
      child: this,
    );
  }

  Widget down() {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: this,
    );
  }
}
