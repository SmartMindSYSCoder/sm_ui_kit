import 'package:flutter/material.dart';

class AppSnackBar {
  AppSnackBar._();

  static void showCustomSnackbar({
  required BuildContext context,
  required String title,
  required String message,
  required Color backgroundColor,
  TextStyle? titleStyle,
  TextStyle? messageStyle,
  Widget? icon,
  EdgeInsets? padding,
  EdgeInsets? margin,
  double borderRadius = 12,
  Color? borderColor,
  double borderWidth = 0,
  DismissDirection? dismissDirection,
}) {
  // 1. Get screen dimensions to calculate top position
  final double screenHeight = MediaQuery.of(context).size.height;
  final double statusBarHeight = MediaQuery.of(context).padding.top;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      
      // 2. THIS IS THE KEY: Calculate margin to push it to the top
      margin: margin ?? EdgeInsets.only(
        top: statusBarHeight + 10, 
        left: 16, 
        right: 16, 
        // Push from bottom = Total Height - Status Bar - Approximate Snackbar Height
        bottom: screenHeight - statusBarHeight - 120, 
      ),
      
      dismissDirection: dismissDirection ?? DismissDirection.up,
      padding: EdgeInsets.zero,
      content: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: borderColor != null
              ? Border.all(color: borderColor, width: borderWidth)
              : null,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            if (icon != null) ...[icon, const SizedBox(width: 12)],
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: titleStyle ?? const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    message,
                    style: messageStyle ?? const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  static void showSuccessSnackbar({
    required BuildContext context,
    required String message,
    String? title,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    Color? backgroundColor,
    DismissDirection? dismissDirection,
  }) {
    final theme = Theme.of(context);

    showCustomSnackbar(
      context: context,
      dismissDirection: dismissDirection ?? DismissDirection.up,
      title: title ?? "Success",
      message: message,
      titleStyle: titleStyle,
      messageStyle: messageStyle,

      // Fallback to Primary color if no background provided
      backgroundColor: backgroundColor ?? theme.colorScheme.primary,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      borderRadius: 32,
      borderColor: Colors.white,
      borderWidth: 1,
    );
  }

  static void showErrorSnackbar({
    required BuildContext context,
    required String message,
    String? title,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    Color? backgroundColor,
    DismissDirection? dismissDirection,
  }) {
    final theme = Theme.of(context);

    showCustomSnackbar(
      context: context,
      title: title ?? "Sorry",
      message: message,
      titleStyle: titleStyle,
      messageStyle: messageStyle,
      dismissDirection: dismissDirection ?? DismissDirection.up,
      // Fallback to Error color if no background provided
      backgroundColor: backgroundColor ?? theme.colorScheme.error,
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
      borderRadius: 32,
      borderColor: Colors.white,
      borderWidth: 1,
    );
  }
}
