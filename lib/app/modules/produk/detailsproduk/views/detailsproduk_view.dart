import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:kasir_id/app/modules/extensions/formatter.dart';
import 'package:kasir_id/app/modules/produk/halamankeranjang/controllers/halamankeranjang_controller.dart';
import 'package:kasir_id/app/modules/produk/halamankeranjang/models/keranjang_model.dart';
import 'package:kasir_id/app/routes/app_pages.dart';

import '../controllers/detailsproduk_controller.dart';

class DetailsprodukView extends GetView<DetailsprodukController> {
  const DetailsprodukView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.produk.namaProduk,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.HALAMANKERANJANG);
            },
            icon: Icon(FlutterIcons.shopping_cart_ent),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: Get.height * 0.5,
              width: Get.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.produk.image.length,
                itemBuilder: (context, index) {
                  final image = controller.produk.image[index];
                  return Container(
                    margin: EdgeInsets.all(12),
                    height: Get.height * 0.5,
                    width: Get.width * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.file(File(image), fit: BoxFit.cover),
                  );
                },
              ),
            ),

            Text(
              "Rp ${controller.produk.hargaJual.nominal}",
              style: TextStyle(fontSize: 20, color: Colors.deepPurple),
            ),
            Text(
              "Terjual ${controller.produk.terjual}/${controller.produk.stok}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            description(),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Get.find<HalamankeranjangController>().insertKeranjang(
            KeranjangModel(produk: controller.produk, jumlah: 1),
          );
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.deepPurpleAccent),
          child: Icon(
            FlutterIcons.cart_plus_faw,
            size: Get.height * 0.075,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 255, 242, 223),
      ),
      child: controller.produk.deskripsi != null
          ? RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: 'Deskripsi\n\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(text: controller.produk.deskripsi),
                ],
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
