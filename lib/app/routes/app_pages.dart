import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/produk/bindings/produk_binding.dart';
import '../modules/produk/detailsproduk/bindings/detailsproduk_binding.dart';
import '../modules/produk/detailsproduk/views/detailsproduk_view.dart';
import '../modules/produk/editproduk/bindings/editproduk_binding.dart';
import '../modules/produk/editproduk/views/editproduk_view.dart';
import '../modules/produk/halamankeranjang/bindings/halamankeranjang_binding.dart';
import '../modules/produk/halamankeranjang/views/halamankeranjang_view.dart';
import '../modules/produk/views/halaman_produk_view.dart';
import '../modules/produk/views/produkbaru_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      bindings: [HomeBinding(), ProdukBinding()],
    ),
    GetPage(
      name: _Paths.DETAILSPRODUK,
      page: () => const DetailsprodukView(),
      bindings: [DetailsprodukBinding(), HalamankeranjangBinding()],
    ),
    GetPage(
      name: _Paths.PRODUK,
      page: () => const HalamanProdukView(),
      binding: ProdukBinding(),
      children: [],
    ),
    GetPage(
      name: _Paths.PRODUK_BARU,
      page: () => ProdukbaruView(),
      binding: ProdukBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HALAMANKERANJANG,
      page: () => const HalamankeranjangView(),
      binding: HalamankeranjangBinding(),
    ),
    GetPage(
      name: _Paths.EDITPRODUK,
      page: () => const EditprodukView(),
      binding: EditprodukBinding(),
    ),
  ];
}
