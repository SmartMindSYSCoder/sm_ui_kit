import 'package:flutter/material.dart';

class AppDialogs {
  AppDialogs._();

  /// 1. Updated Helper Method to accept backgroundColor
  static Future<T?> showCustomDialog<T>({
    required BuildContext context,
    required Widget content,
    bool barrierDismissible = true,
    double borderRadius = 20,
    Widget? closeButton,
    double? closeTop,
    double? closeRight,
    double? elevation,
    EdgeInsets? insetPadding,
    Color? backgroundColor, // <--- ADD THIS LINE
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        return Dialog(
          insetPadding: insetPadding ?? const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
          // Use the passed backgroundColor, or fallback to the Theme
          backgroundColor: backgroundColor ?? theme.dialogBackgroundColor, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: elevation ?? 4,
          child: Stack(
            children: [
              content,
              if (closeButton != null)
                Positioned(
                  top: closeTop ?? 20,
                  right: closeRight ?? 20,
                  child: closeButton,
                ),
            ],
          ),
        );
      },
    );
  }

  /// 2. Success Dialog with dynamic variables
  static Future<void> showSuccessDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? assetPath,
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
    
    // Dynamic variables
    Color? backgroundColor,
    Color? buttonColor,
    Color? buttonTextColor,
    Color? titleColor,
    Color? messageColor,
    double? borderRadius,
  }) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    await showCustomDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      backgroundColor: backgroundColor, // This now works!
      borderRadius: borderRadius ?? 20.0,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (assetPath != null) ...[
              Image.asset(assetPath, fit: BoxFit.contain, height: 80),
              const SizedBox(height: 20),
            ],
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: titleColor ?? colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: messageColor ?? theme.textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor ?? colorScheme.primary, 
                  foregroundColor: buttonTextColor ?? colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm();
                },
                child: Text(confirmText ?? "OK"),
              ),
            ),
          ],
        ),
      ),
      closeButton: IconButton(
        icon: Icon(Icons.close, color: theme.hintColor),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  // 3. Error Dialog with dynamic variables
  static Future<void> showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? assetPath,
    VoidCallback? onConfirm,
    VoidCallback? onCancel, // Added for flexibility
    bool barrierDismissible = true,
    
    // Dynamic variables
    Color? backgroundColor,
    Color? buttonColor,
    Color? buttonTextColor,
    Color? titleColor,
    Color? messageColor,
    double? borderRadius,
  }) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    await showCustomDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius ?? 20.0,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error Icon/Asset (Defaulting to error icon if no asset provided)
            if (assetPath != null)
              Image.asset(assetPath, fit: BoxFit.contain, height: 80)
            else
              Icon(Icons.error_outline, size: 80, color: colorScheme.error),
              
            const SizedBox(height: 20),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                // Defaults to the Theme's error color
                color: titleColor ?? colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: messageColor ?? theme.textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // Button defaults to error color for high visibility
                  backgroundColor: buttonColor ?? colorScheme.error, 
                  foregroundColor: buttonTextColor ?? colorScheme.onError,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm();
                },
                child: Text(confirmText ?? "Try Again"),
              ),
            ),
          ],
        ),
      ),
      closeButton: IconButton(
        icon: Icon(Icons.close, color: theme.hintColor),
        onPressed: () {
          Navigator.of(context).pop();
          if (onCancel != null) onCancel();
        },
      ),
    );
  }
}