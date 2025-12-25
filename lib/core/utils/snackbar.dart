import 'package:flutter/material.dart';
import 'package:food_chef/core/utils/app_string.dart';
import 'package:google_fonts/google_fonts.dart';
 
class CustomSnackBar {
  static void showTopSnackbar(
      BuildContext context, String? message, Color color,
      [int duration = 5]) {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width,
        // height: 100,
        child: Material(
          elevation: 30,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            color: color,
            child: Text(
              textAlign: TextAlign.center,
              message ?? AppString.noDataAvailable,
              style:  GoogleFonts.montserrat(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  fontStyle: FontStyle.normal,
  color: Colors.white),
            ),
          ),
        ),
      ),
    );
 
    Overlay.of(context).insert(overlayEntry);
 
    // Remove the snackbar after some duration
    Future.delayed(Duration(seconds: duration), () {
      overlayEntry.remove();
    });
  }
}
