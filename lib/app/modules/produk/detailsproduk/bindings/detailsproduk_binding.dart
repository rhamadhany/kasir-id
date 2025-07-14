import 'package:get/get.dart';

import '../controllers/detailsproduk_controller.dart';

class DetailsprodukBinding extends Bindings {
  @override
  void dependencies() {
    final produk = Get.arguments;
    Get.lazyPut<DetailsprodukController>(
      () => DetailsprodukController(produk: produk),
    );
  }
}
