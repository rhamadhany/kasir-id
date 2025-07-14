import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:kasir_id/app/modules/produk/views/halaman_admin_view.dart';
import 'package:kasir_id/app/modules/produk/views/halaman_produk_view.dart';
import 'package:kasir_id/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: BackgroundStyle(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(height: kToolbarHeight / 2),
            Obx(
              () => Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Text(
                      controller.tabIndex.value == 0
                          ? 'Halaman Produk'
                          : 'Halaman Admin',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.HALAMANKERANJANG);
                      },
                      icon: Icon(FlutterIcons.shopping_cart_ent),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [HalamanProdukView(), HalamanAdminView()],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  controller: controller.tabController,
                  // indicatorColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  // labelColor: Colors.blue,
                  tabs: [
                    Tab(icon: Icon(Icons.shop), text: 'Toko'),
                    Tab(icon: Icon(Icons.admin_panel_settings), text: 'Admin'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
