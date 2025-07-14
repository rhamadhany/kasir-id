import 'package:get/get.dart';
import 'package:kasir_id/app/modules/produk/controllers/produk_controller.dart';
import 'package:kasir_id/app/modules/produk/models/produk_model.dart';

class KeranjangModel {
  static final tableName = 'keranjang';
  ProdukModel produk;
  bool selected;
  int jumlah;
  KeranjangModel({ProdukModel? produk, int? jumlah, bool? selected})
    : produk = produk ?? ProdukModel(),
      jumlah = jumlah ?? 1,
      selected = selected ?? false;

  Map<String, dynamic> toJson() {
    return {'kode_produk': produk.kodeProduk, 'jumlah': jumlah};
  }

  factory KeranjangModel.fromJson(Map<String, dynamic> json) {
    final first = Variable.daftarProduk.firstWhereOrNull(
      (f) => f.kodeProduk == json['kode_produk'],
    );
    if (first != null) {
      return KeranjangModel(produk: first, jumlah: json['jumlah']);
    } else {
      return KeranjangModel();
    }
  }
}
