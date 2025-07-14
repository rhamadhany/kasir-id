import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_flutter/icons_flutter.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(FlutterIcons.shopping_search_mco, size: Get.height * 0.25),
          SizedBox(height: 10),
          Obx(() {
            return AnimatedOpacity(
              opacity: controller.opacity.value,
              duration: controller.animtionDuration,
              child: Text(
                controller.subtitleSplash.value,
                style: GoogleFonts.aladin(fontSize: Get.height * 0.025),
              ),
            );
          }),
        ],
      ),
    );
  }
}
