import 'dart:ui'; // Import for ImageFilter

import 'package:flutter/material.dart';

class SideSheet {
  static Future<dynamic> left({
    required Widget body,
    required BuildContext context,
    double? width,
    String barrierLabel = "Side Sheet",
    bool barrierDismissible = true,
    Color barrierColor = const Color(0xFF66000000),
    double sheetBorderRadius = 0, // Changed default to 0
    Color sheetColor = Colors.white,
    Duration transitionDuration = const Duration(milliseconds: 300),
    double blurSigmaX = 10.0,
    double blurSigmaY = 10.0,
    double opacity = 0.1,
    Color borderColor = Colors.white,
    double borderWidth = 0.2,
  }) async {
    dynamic data = await _showSheetSide(
      body: body,
      width: width,
      rightSide: false, // ✅ open from left
      context: context,
      barrierLabel: barrierLabel,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      sheetBorderRadius: sheetBorderRadius,
      sheetColor: sheetColor,
      transitionDuration: transitionDuration,
      blurSigmaX: blurSigmaX,
      blurSigmaY: blurSigmaY,
      opacity: opacity,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
    if (data == null) return '';
    return data;
  }

  static _showSheetSide({
    required Widget body,
    required bool rightSide,
    double? width,
    required BuildContext context,
    required String barrierLabel,
    required bool barrierDismissible,
    required Color barrierColor,
    required double sheetBorderRadius,
    required Color sheetColor,
    required Duration transitionDuration,
    required double blurSigmaX,
    required double blurSigmaY,
    required double opacity,
    required Color borderColor,
    required double borderWidth,
  }) {
    // borderRadius will now be all zero if sheetBorderRadius is 0
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: rightSide ? Radius.circular(sheetBorderRadius) : Radius.zero,
      bottomLeft: rightSide ? Radius.circular(sheetBorderRadius) : Radius.zero,
      topRight: !rightSide ? Radius.circular(sheetBorderRadius) : Radius.zero,
      bottomRight: !rightSide
          ? Radius.circular(sheetBorderRadius)
          : Radius.zero,
    );

    return showGeneralDialog(
      barrierLabel: barrierLabel,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      transitionDuration: transitionDuration,
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Align(
          alignment: rightSide ? Alignment.centerRight : Alignment.centerLeft,
          child: Material(
            elevation:
                0, // Set elevation to 0 to prevent shadow artifacts at the edges
            color: Colors.transparent,
            borderRadius: borderRadius, // Use the calculated borderRadius
            child: ClipRRect(
              borderRadius: borderRadius, // Use the calculated borderRadius
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blurSigmaX,
                  sigmaY: blurSigmaY,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: sheetColor.withOpacity(opacity),
                    borderRadius:
                        borderRadius, // Use the calculated borderRadius
                    border: Border.all(
                      color: borderColor.withOpacity(borderWidth),
                    ),
                  ),
                  height: double.infinity,
                  width: width ?? MediaQuery.of(context).size.width / 2,
                  child: body,
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position: Tween(
            begin: Offset((rightSide ? 1 : -1), 0),
            end: Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }
}
