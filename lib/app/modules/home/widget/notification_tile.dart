import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_colors.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    this.isUnread = false,
    required this.svgAssets,
    required this.title,
    required this.subitle,
  });

  final bool isUnread;
  final String svgAssets;
  final String title;
  final String subitle;

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return Container(
      color: isUnread ? AppColors.activeTile : Colors.transparent,
      height: 96.r,
      padding: EdgeInsets.symmetric(horizontal: 32.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 30.w,
        children: [
          SvgPicture.asset(
            svgAssets,
            height: 40.h,
            fit: BoxFit.fitHeight,
            colorFilter: ColorFilter.mode(
              isUnread ? AppColors.primaryButtonText : AppColors.secondaryText,
              BlendMode.srcIn,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 6.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subitle,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: ts.labelSmall?.copyWith(
                    color: isUnread
                        ? AppColors.primaryButtonText
                        : AppColors.secondaryText,
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: ts.titleSmall?.copyWith(
                      color: isUnread
                          ? AppColors.primaryButtonText
                          : AppColors.secondaryText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 32.h,
            color: isUnread
                ? AppColors.primaryButtonText
                : AppColors.secondaryText,
          ),
        ],
      ),
    );
  }
}
