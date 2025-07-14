import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:kasir_id/app/modules/produk/controllers/produk_controller.dart';
import 'package:kasir_id/app/modules/produk/views/halaman_produk_view.dart';

import '../controllers/editproduk_controller.dart';

class EditprodukView extends GetView<EditprodukController> {
  const EditprodukView({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: BackgroundStyle(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(8, kTextTabBarHeight, 8, 8),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: Colors.white),
              child: Text(
                'Edit Produk',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: Variable.daftarProduk.length,
                  padding: EdgeInsetsDirectional.only(
                    bottom: Get.height * 0.25,
                  ),
                  itemBuilder: (context, index) {
                    final item = Variable.daftarProduk[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              onPressed: (_) {
                                final produkController =
                                    Get.find<ProdukController>();
                                produkController.deleteProduk(item);
                              },

                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (item.image.isNotEmpty)
                              Image.file(
                                File(item.image.first),
                                height: Get.height * 0.15,
                                width: Get.height * 0.15,
                                fit: BoxFit.cover,
                              ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Text(
                                  item.namaProduk,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Stok ${item.stok}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
