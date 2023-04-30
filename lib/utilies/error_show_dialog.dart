import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Future<void> errorShowDialog(BuildContext context, String text) {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text("Error has occured"),
//         content: Text(text),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text("Ok"),
//           ),
//         ],
//       );
//     },
//   );
// }

Future<void> errorShowDialog(String text) async {
  return Get.defaultDialog(
    title: "Error message",
    content: Text(text),
    textConfirm: "Ok",
    onConfirm: () => Get.back(),
  );
}
