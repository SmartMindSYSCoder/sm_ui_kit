import 'package:flutter/material.dart';

class AppDialogs {
  AppDialogs._();

  /// Generic Custom Dialog
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
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: insetPadding ?? const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
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

  /// Success Dialog
  static Future<void> showSuccessDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? assetPath,
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
  }) async {
    await showCustomDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      borderRadius: 20,
      closeTop: 10,
      closeRight: 10,
      closeButton: IconButton(
        icon: const Icon(Icons.close, color: Colors.grey),
        onPressed: () => Navigator.of(context).pop(),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (assetPath != null) ...[
              Image.asset(assetPath, fit: BoxFit.contain, height: 80),
              const SizedBox(height: 20),
            ],
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blue, // Replace with your primary color
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Replace with your primary color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  if (onConfirm != null) onConfirm();
                },
                child: Text(
                  confirmText ?? "OK",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}