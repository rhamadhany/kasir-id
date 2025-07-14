import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:kasir_id/app/modules/produk/controllers/produk_controller.dart';
import 'package:kasir_id/app/modules/produk/models/produk_model.dart';

class GambarProdukBaru extends StatelessWidget {
  const GambarProdukBaru({
    super.key,
    required this.controller,
    required this.listImage,
    required this.model,
  });

  final ProdukController controller;
  final RxList<String> listImage;
  final ProdukModel model;

  @override
  Widget build(BuildContext context) {
    IconButton addButton() {
      return IconButton(
        onPressed: () async {
          final listXFile = await controller.imagePicker();

          for (var cache in listXFile) {
            final dir = Directory('/data/user/0/com.BNeoTech.kasir_id/image/');
            if (!await dir.exists()) {
              await dir.create();
            }
            final out =
                dir.path +
                DateTime.now().millisecondsSinceEpoch.toString() +
                cache.name;

            await cache.saveTo(out);
            listImage.add(out);
          }
        },
        icon: Icon(
          FlutterIcons.add_shopping_cart_mdi,
          size: Get.height * 0.075,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: Get.height * 0.05,
        top: Get.height * 0.015,
      ),
      child: Obx(() {
        return listImage.isEmpty
            ? addButton()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (listImage.isNotEmpty)
                      ...List.generate(listImage.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.file(
                                  File(listImage[index]),

                                  width: Get.height * 0.15,
                                  height: Get.height * 0.15,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    listImage.removeAt(index);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    radius: 15,
                                    // onPressed: () {},
                                    child: Icon(Icons.clear),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    addButton(),
                  ],
                ),
              );
      }),
    );
  }
}
