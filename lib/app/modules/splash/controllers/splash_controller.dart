import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_id/app/routes/app_pages.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _subtitleSplash = 'Easy sell your product with us!';
  final subtitleSplash = ''.obs;

  final opacity = 0.0.obs;

  AnimationController? animationController;
  Animation<double>? _textAnimation;
  Animation<double>? _opacityAnimation;
  final animtionDuration = Duration(seconds: 3);

  Future<void> initAnimation() async {
    animationController = AnimationController(
      vsync: this,
      duration: animtionDuration,
    );
    _textAnimation =
        Tween<double>(begin: 0, end: _subtitleSplash.length.toDouble()).animate(
          CurvedAnimation(
            parent: animationController!,
            curve: Curves.easeInOut,
          ),
        );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController!, curve: Curves.linear),
    );
    animationController?.addListener(() {
      final chars = _subtitleSplash.length;
      final progress = _textAnimation!.value.round().clamp(0, chars);
      subtitleSplash.value = _subtitleSplash.substring(0, progress);
      opacity.value = _opacityAnimation!.value.clamp(0.9, 1.0);
    });
    await Future.delayed(Duration(milliseconds: 500));
    await animationController?.forward();
    await Future.delayed(Duration(milliseconds: 500));
    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onInit() {
    super.onInit();
    initAnimation();
  }
}
