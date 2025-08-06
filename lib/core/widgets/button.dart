import 'dart:ui';

import 'package:flutter/material.dart';

Widget buttons({
  required IconData icon,
  required VoidCallback onTap,
  required String hoverText,
}) {
  return Tooltip(
    message: hoverText,
    decoration: BoxDecoration(
      color: Colors.black87,
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(color: Colors.white),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white),
                Text(hoverText, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
