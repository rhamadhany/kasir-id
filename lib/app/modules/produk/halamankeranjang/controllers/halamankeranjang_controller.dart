import 'package:get/get.dart';
import 'package:kasir_id/app/modules/helper/snack_helper.dart';
import 'package:kasir_id/app/modules/produk/controllers/produk_controller.dart';
import 'package:kasir_id/app/modules/produk/database/database_helper.dart';
import 'package:kasir_id/app/modules/produk/halamankeranjang/models/keranjang_model.dart';
import 'package:kasir_id/app/modules/produk/models/produk_model.dart';
import 'package:kasir_id/app/routes/app_pages.dart';
import 'package:sqflite/sqflite.dart';

class HalamankeranjangController extends GetxController {
  final produkKeranjang = <KeranjangModel>[].obs;

  Database? database;
  @override
  void onInit() {
    super.onInit();
    initDatabase();
  }

  Future<void> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/keranjang.db';
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE keranjang (id INTEGER PRIMARY KEY, kode_produk TEXT, jumlah INTEGER)',
        );
      },
    );

    final keranjang = await DatabaseHelper.getRecord(
      database,
      KeranjangModel.tableName,
    );
    refreshKeranjang(keranjang);
  }

  void removeRecord(KeranjangModel model) async {
    await database?.delete(
      KeranjangModel.tableName,
      where: 'kode_produk = ?',
      whereArgs: [model.produk.kodeProduk],
    );
  }

  void checkoutKeranjang(String total) async {
    try {
      final products = produkKeranjang
          .where((w) => w.selected == true)
          .toList();
      final produkController = Get.find<ProdukController>();

      for (var item in products) {
        produkController.checkoutProduk(
          jumlah: item.jumlah,
          kodeProduk: item.produk.kodeProduk,
        );
        removeRecord(item);
      }
      final keranjang = await DatabaseHelper.getRecord(
        database,
        KeranjangModel.tableName,
      );
      refreshKeranjang(keranjang);
      final produk = await DatabaseHelper.getRecord(
        produkController.database,
        ProdukModel.tableName,
      );
      produkController.refreshProduk(produk);
      Get.offAllNamed(Routes.HOME);
      snackSuceed(
        title: 'Berhasil',
        message: 'Produk telah dijual sebesar $total',
      );
    } catch (e) {
      snackError(message: 'Gagal menjual produk $e');
    }
  }

  Future<List<Map<String, dynamic>>?> checkProduk(KeranjangModel model) async {
    final result = await database?.query(
      'keranjang',
      where: 'kode_produk = ?',
      whereArgs: [model.produk.kodeProduk],
    );
    return result;
  }

  void updateKeranjang(KeranjangModel model, int jumlah) async {
    await database?.update(
      KeranjangModel.tableName,
      {'jumlah': jumlah},
      where: 'kode_produk = ?',
      whereArgs: [model.produk.kodeProduk],
    );
    final keranjang = await DatabaseHelper.getRecord(
      database,
      KeranjangModel.tableName,
    );
    refreshKeranjang(keranjang);
  }

  void insertKeranjang(KeranjangModel model) async {
    try {
      if (database == null) {
        await initDatabase();
      }
      final exist = await checkProduk(model);
      if (exist != null && exist.isNotEmpty) {
        final jumlah = exist.first['jumlah'] as int;
        if (jumlah < model.produk.stok) {
          updateKeranjang(model, jumlah + 1);
        } else {
          throw Exception('Stok hanya tersisa $jumlah');
        }
      } else {
        await DatabaseHelper.insertRecord(
          database,
          KeranjangModel.tableName,
          model.toJson(),
          (value) {
            refreshKeranjang(value);
          },
        );
      }

      snackSuceed(
        message: '${model.produk.namaProduk} telah ditambahkan ke keranjang',
      );
    } catch (e) {
      snackError(
        message: 'Gagal menambahkan ${model.produk.namaProduk} ke keranjang $e',
      );
    }
  }

  void refreshKeranjang(List<Map<String, dynamic>> keranjang) {
    produkKeranjang.value = keranjang
        .map((json) => KeranjangModel.fromJson(json))
        .toList();
    produkKeranjang.refresh();
  }

  @override
  void onClose() {
    database?.close();
    super.onClose();
  }
}
