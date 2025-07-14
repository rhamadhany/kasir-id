import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  final tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2)
      ..addListener(() {
        tabIndex.value = tabController!.index;
      });
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }
}
