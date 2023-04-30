import 'package:flutter/material.dart';

import '../../constant.dart';

class CustomBottomIcon extends StatelessWidget {
  const CustomBottomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Container(
        height: 36,
        width: 48,
        color: Colors.white,
        child: Icon(Icons.add, size: 24, color: buttonColor),
      ),
    );
  }
}
