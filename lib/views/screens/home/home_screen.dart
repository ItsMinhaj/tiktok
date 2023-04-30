import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant.dart';
import '../../../controllers/bottom_nav_controller.dart';
import '../../widgets/custom_bottom_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BottomNavController());
    final navController = Get.find<BottomNavController>();

    return Scaffold(
      body: Obx(() {
        return pages[navController.index.value];
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
            selectedItemColor: buttonColor,
            unselectedItemColor: Colors.white,
            backgroundColor: backgroundColor,
            currentIndex: navController.index.value,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              navController.index.value = value;
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(icon: CustomBottomIcon(), label: "Add"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), label: "Message"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ]);
      }),
    );
  }
}
