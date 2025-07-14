import 'dart:convert';
import 'package:kasir_id/app/modules/extensions/String/formatter.dart';

class ProdukModel {
  static final String tableName = 'daftar_produk';
  String kodeProduk;
  String namaProduk;
  double hargaBeli;
  double hargaJual;
  int stok;
  int terjual;
  double? diskon;
  List<String> image;
  String? deskripsi;

  ProdukModel({
    String? kodeProduk,
    String? namaProduk,
    double? hargaBeli,
    double? hargaJual,
    int? stok,
    int? terjual,
    double? diskon,
    List<String>? image,
    String? deskripsi,
  }) : namaProduk = namaProduk ?? '',
       hargaBeli = hargaBeli ?? 0.0,
       hargaJual = hargaJual ?? 0.0,
       stok = stok ?? 0,
       terjual = terjual ?? 0,
       diskon = diskon ?? 0.0,
       image = image ?? [],
       kodeProduk =
           kodeProduk ??
           DateTime.now().millisecondsSinceEpoch.toString().plusGenerate,
       deskripsi = deskripsi ?? deskripsi;

  Map<String, dynamic> toJson() {
    return {
      'nama_produk': namaProduk,
      'harga_beli': hargaBeli,
      'harga_jual': hargaJual,
      'stok': stok,
      'terjual': terjual,
      'diskon': diskon,
      'image': jsonEncode(image),
      'kode_produk': kodeProduk,
      'deskripsi': deskripsi,
    };
  }

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    final image = jsonDecode(json['image']);
    return ProdukModel(
      namaProduk: json['nama_produk'],
      hargaBeli: json['harga_beli'],
      hargaJual: json['harga_jual'],
      stok: json['stok'],
      terjual: json['terjual'],
      diskon: json['diskon'],
      image: List<String>.from(image),
      kodeProduk: json['kode_produk'],
      deskripsi: json['deskripsi'],
    );
  }
}
