import 'package:flutter/material.dart';
import 'package:food_chef/core/utils/app_string.dart';
import 'package:google_fonts/google_fonts.dart';
 
// class CustomSnackBar {
//   static void showTopSnackbar(
//       BuildContext context,
//       String? message,
//       Color color, [
//         int duration = 5,
//       ]) {
//     final overlay = Overlay.of(context);
//     if (overlay == null) return;
//
//     late OverlayEntry overlayEntry;
//
//     overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         left: 0,
//         right: 0,
//         bottom: MediaQuery.of(context).padding.bottom + 16,
//         child: Material(
//           color: Colors.transparent,
//           elevation: 10,
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             padding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 14,
//             ),
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               message ?? AppString.noDataAvailable,
//               textAlign: TextAlign.center,
//               style: GoogleFonts.montserrat(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//
//     overlay.insert(overlayEntry);
//
//     Future.delayed(Duration(seconds: duration), () {
//       overlayEntry.remove();
//     });
// }
