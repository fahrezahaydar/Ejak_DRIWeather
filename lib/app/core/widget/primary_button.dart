import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import 'inner_shadow.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
    this.value, {
    super.key,
    this.onPressed,
    this.minimumSize,
    this.icon,
  });

  final String value;
  final void Function()? onPressed;
  final Size? minimumSize;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final bool withIcon = icon != null;
    final ts = Theme.of(context).textTheme;
    return InnerShadow(
      shadows: [
        Shadow(
          blurRadius: 6.r,
          color: AppColors.black25,
          offset: Offset(2.w, -3.h),
        ),
        Shadow(
          blurRadius: 4,
          color: AppColors.white25,
          offset: Offset(-6.w, 4.h),
        ),
      ],
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: minimumSize,
          foregroundColor: AppColors.primaryButtonText,
          backgroundColor: AppColors.white,
          padding: EdgeInsets.fromLTRB(32.w, 8, 32.w, 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.h),
          ),
        ),
        child: withIcon
            ? Row(
                spacing: 12.w,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: ts.bodyMedium,
                  ),
                  icon!,
                ],
              )
            : Text(
                value,
                style: ts.bodyMedium,
              ),
      ),
    );
  }
}
