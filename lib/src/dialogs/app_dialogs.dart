import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppDialogs {
  AppDialogs._();

  static Future<T?> showCustomDialog<T>({
    required Widget content,
    bool barrierDismissible = true,
    double borderRadius = 20,
    Widget? closeButton,
    double? closeTop,
    double? closeRight,
    double? elevation,
    EdgeInsets? insetPadding,
  }) {
    return Get.dialog<T>(
      Dialog(
        insetPadding: insetPadding,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: elevation ?? 4,
        child: Stack(
          children: [
            content,
            if (closeButton != null)
              Positioned(
                top: closeTop ?? 25.h,
                right: closeRight ?? 25.w,
                child: closeButton,
              ),
          ],
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}
