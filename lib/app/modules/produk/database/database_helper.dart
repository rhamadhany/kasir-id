import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<void> insertRecord(
    Database? database,
    String tableName,
    Map<String, dynamic> record,
    Function(List<Map<String, dynamic>>) callBack,
  ) async {
    if (database == null) {
      throw Exception('Failed to getRecord database is null!');
    }

    print('insert $record');
    await database.insert(tableName, record);
    final update = await getRecord(database, tableName);
    callBack(update);
  }

  static Future<List<Map<String, dynamic>>> getRecord(
    Database? database,
    String tableName,
  ) async {
    if (database == null) {
      throw Exception('Failed to getRecord database is null!');
    }
    return await database.query(tableName);
  }

  static Future<Database> initDatabase({
    required String fileDatabase,
    required String query,
  }) async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$fileDatabase';

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(query);
      },
    );
  }
}
