// import 'package:digicard/Utils/CustomColors.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class CustomeToast {
//   static showToast(
//     String? title, {
//     String gravity = "bottom",
//   }) {
//     ToastGravity toastGravity;
//     switch (gravity.toLowerCase()) {
//       case "top":
//         toastGravity = ToastGravity.TOP;
//         break;
//       case "center":
//         toastGravity = ToastGravity.CENTER;
//         break;
//       case "bottom":
//       default:
//         toastGravity = ToastGravity.BOTTOM;
//     }
//
//     Fluttertoast.showToast(
//       msg: title.toString(),
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: toastGravity,
//       timeInSecForIosWeb: 1,
//       backgroundColor: gravity.toLowerCase() == "top"
//           ? CustomColor.loginButtonColor
//           : Colors.white,
//       textColor: gravity.toLowerCase() == "top" ? Colors.white : Colors.black,
//       fontSize: 16.0,
//     );
//   }
// }
