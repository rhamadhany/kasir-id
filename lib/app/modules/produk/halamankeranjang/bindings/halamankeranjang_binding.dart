import 'package:get/get.dart';

import '../controllers/halamankeranjang_controller.dart';

class HalamankeranjangBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HalamankeranjangController(), permanent: true);
  }
}
