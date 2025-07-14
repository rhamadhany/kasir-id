import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:kasir_id/app/modules/extensions/formatter.dart';
import 'package:kasir_id/app/modules/produk/views/halaman_produk_view.dart';

import '../controllers/halamankeranjang_controller.dart';

class HalamankeranjangView extends GetView<HalamankeranjangController> {
  const HalamankeranjangView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Material(
        child: BackgroundStyle(
          child: controller.produkKeranjang.isEmpty
              ? Center(
                  child: Icon(
                    FlutterIcons.shopping_cart_ent,
                    size: Get.height * 0.25,
                    color: Colors.grey,
                  ),
                )
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 8),

                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          if (Navigator.canPop(context))
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(FlutterIcons.arrow_back_mdi, size: 25),
                            ),
                          Text(
                            'Keranjang',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.produkKeranjang.length,
                        padding: EdgeInsets.only(bottom: Get.height * 0.25),
                        itemBuilder: (context, index) {
                          final item = controller.produkKeranjang[index];
                          return InkWell(
                            onTap: () {
                              item.selected = !item.selected;
                              controller.produkKeranjang.refresh();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  if (item.produk.image.isNotEmpty)
                                    Image.file(
                                      File(item.produk.image.first),

                                      height: Get.height * 0.15,
                                      width: Get.height * 0.15,
                                      fit: BoxFit.cover,
                                    ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.produk.namaProduk,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text('Jumlah ${item.jumlah}'),
                                      Text(
                                        'Rp ${item.produk.hargaJual.nominal}',
                                        style: TextStyle(
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Checkbox(
                                    value: item.selected,
                                    onChanged: (value) {
                                      item.selected = value ?? false;
                                      controller.produkKeranjang.refresh();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (totalHarga != 'Rp 0')
                      InkWell(
                        onTap: () {
                          controller.checkoutKeranjang(totalHarga);
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FlutterIcons.shopping_cart_ent,
                                  color: Colors.deepPurple,
                                  size: Get.height * 0.035,
                                ),
                                SizedBox(width: 20),

                                Text(
                                  totalHarga,
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      );
    });
  }

  String get totalHarga {
    final selected = controller.produkKeranjang
        .where((f) => f.selected == true)
        .toList();

    double total = 0;
    for (var item in selected) {
      final harga = item.produk.hargaJual * item.jumlah;
      total += harga;
    }

    return 'Rp ${total.nominal}';
  }
}
