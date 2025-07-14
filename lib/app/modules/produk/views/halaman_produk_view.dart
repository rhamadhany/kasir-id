import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kasir_id/app/modules/extensions/formatter.dart';
import 'package:kasir_id/app/modules/painter/background_painter.dart';
import 'package:kasir_id/app/modules/produk/controllers/produk_controller.dart';
import 'package:kasir_id/app/routes/app_pages.dart';

class HalamanProdukView extends GetView<ProdukController> {
  const HalamanProdukView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
        child: GridView.builder(
          padding: EdgeInsets.only(bottom: Get.height * 0.35),
          itemCount: Variable.daftarProduk.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final item = Variable.daftarProduk[index];
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.DETAILSPRODUK, arguments: item);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 210, 205, 203),
                      blurRadius: 0,
                      spreadRadius: 2.5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 238, 231, 229),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    if (item.image.isNotEmpty) imageView(item.image),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.namaProduk,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Rp ${item.hargaJual.nominal}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Terjual ${item.terjual}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget imageView(List<String> image) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.file(
          File(image.first),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}

class BackgroundStyle extends StatelessWidget {
  const BackgroundStyle({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 239, 216, 184),
          ),
        ),

        CustomPaint(
          painter: BackgroundPainter(),
          size: Size(Get.width, Get.height),
        ),

        child,
      ],
    );
  }
}
