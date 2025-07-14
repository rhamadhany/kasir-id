import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kasir_id/app/modules/produk/controllers/produk_controller.dart';
import 'package:kasir_id/app/modules/produk/models/produk_model.dart';
import 'package:kasir_id/app/modules/produk/views/gambar_produk_baru.dart';

class ProdukbaruView extends GetView<ProdukController> {
  ProdukbaruView({super.key});
  final listImage = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    final model = ProdukModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambahkan Produk',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              model.image = listImage;
              controller.insertProduk(model);
            },
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            GambarProdukBaru(
              controller: controller,
              listImage: listImage,
              model: model,
            ),
            textField(
              label: 'Nama Produk',
              keyboardType: TextInputType.text,
              onChanged: (value) {
                model.namaProduk = value;
              },
            ),
            textField(
              label: 'Stok',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final valueInt = int.tryParse(value);
                if (valueInt != null) {
                  model.stok = valueInt;
                }
              },
            ),
            textField(
              label: 'Harga Beli',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final d = double.tryParse(value);

                if (d != null) {
                  model.hargaBeli = d;
                }
              },
              prefixText: 'Rp ',
            ),
            textField(
              label: 'Harga Jual',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final d = double.tryParse(value);
                if (d != null) {
                  model.hargaJual = d;
                }
              },
              prefixText: 'Rp ',
            ),
            textField(
              keyboardType: TextInputType.multiline,
              label: 'Deskripsi',
              onChanged: (value) {
                model.deskripsi = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget textField({
    String? label,
    Function(String)? onChanged,
    String? prefixText,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      inputFormatters: [],
      controller: controller,
      decoration: InputDecoration(labelText: label, prefixText: prefixText),
      onChanged: onChanged,
    );
  }
}
