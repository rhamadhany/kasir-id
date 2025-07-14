import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasir_id/app/modules/produk/database/database_helper.dart';
import 'package:kasir_id/app/modules/produk/models/produk_model.dart';
import 'package:sqflite/sqflite.dart';

class ProdukController extends GetxController {
  Database? database;

  @override
  Future<void> onInit() async {
    super.onInit();
    initProduk();
  }

  Future<List<XFile>> imagePicker() async {
    final picker = ImagePicker();
    final image = await picker.pickMultiImage();
    return image;
  }

  void checkoutProduk({required int jumlah, required String kodeProduk}) async {
    await database?.rawUpdate(
      'UPDATE ${ProdukModel.tableName} SET terjual = terjual + ? WHERE kode_produk = ?',
      [jumlah, kodeProduk],
    );
  }

  void deleteProduk(ProdukModel model) async {
    await database?.delete(
      ProdukModel.tableName,
      where: 'kode_produk = ?',
      whereArgs: [model.kodeProduk],
    );
    final produk = await DatabaseHelper.getRecord(
      database,
      ProdukModel.tableName,
    );
    refreshProduk(produk);
  }

  void insertProduk(ProdukModel model) async {
    if (model.namaProduk.isEmpty || model.hargaJual <= 0) {
      return;
    }
    Get.back();
    final record = model.toJson();

    await DatabaseHelper.insertRecord(database, ProdukModel.tableName, record, (
      value,
    ) {
      refreshProduk(value);
    });
  }

  void refreshProduk(List<Map<String, dynamic>> value) {
    Variable.daftarProduk.value = value
        .map((json) => ProdukModel.fromJson(json))
        .toList();
    Variable.daftarProduk.refresh();
  }

  Future<void> initProduk() async {
    final query =
        'CREATE TABLE daftar_produk ( id INTEGER PRIMARY KEY,kode_produk TEXT NOT NULL, nama_produk TEXT NOT NULL, harga_jual REAL NOT NULL, harga_beli REAL NOT NULL,stok INTEGER, terjual INTEGER, diskon REAL, image TEXT, deskripsi TEXT)';
    database = await DatabaseHelper.initDatabase(
      fileDatabase: 'produk.db',
      query: query,
    );
    if (database != null) {
      // Variable.daftarProduk.va
      final produk = await DatabaseHelper.getRecord(
        database,
        ProdukModel.tableName,
      );
      refreshProduk(produk);
    }
  }

  @override
  void onClose() {
    database?.close();
    super.onClose();
  }
}

class Variable {
  static final daftarProduk = <ProdukModel>[].obs;
}
