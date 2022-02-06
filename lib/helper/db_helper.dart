import 'dart:io';
import 'dart:typed_data';
import 'package:db_miner2/models/database_model.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  final String CAT_TABLE = 'animal_category';
  final String ANIMAL_TABLE = 'animal_detail';
  final String CAT_ID = 'cat_id';
  final String CAT_NAME = 'cat_name';
  final String CAT_IMAGE = 'cat_img';
  final String CAT_ICON = 'cat_icon';
  final String ANIMAL_ID = 'animal_id';
  final String ANIMAL_NAME = 'animal_name';
  final String ANIMAL_DES = 'animal_description';
  final String ANIMAL_IMG = 'animal_image';

  Database? db;

  // initDB() async {
  //   var databasePath = await getDatabasesPath();
  //   String path = join(databasePath, 'rnw.db');
  //
  //   db = await openDatabase(
  //     path,
  //     version: 1,
  //     onCreate: (Database db, int version) async {
  //       await db.execute(
  //         'CREATE TABLE IF NOT EXISTS $TABLE ($COL_ID INTEGER PRIMARY KEY AUTOINCREMENT, $COL_NAME TEXT, $COL_AGE INTEGER, $COL_IMAGE BLOB)',
  //       );
  //       print("Table created successfully...");
  //     },
  //   );
  // }
  //
  // Future<int> insert(Student student) async {
  //   await initDB();
  //
  //   String sql = 'INSERT INTO $TABLE($COL_NAME, $COL_AGE, $COL_IMAGE) VALUES(?, ?, ?)';
  //
  //   List args = [student.name, student.age, student.image];
  //
  //   return await db!.rawInsert(sql, args);
  // }
  //
  // Future<List<Student>> fetchAllData() async {
  //   await initDB();
  //
  //   String sql = 'SELECT * FROM $TABLE';
  //
  //   List<Map<String, dynamic>> data = await db!.rawQuery(sql);
  //
  //   return data.map((e) => Student.fromMap(e)).toList();
  // }
  //
  // Future<int> delete(int? id) async {
  //   await initDB();
  //
  //   String sql = 'DELETE FROM $TABLE WHERE id=?';
  //
  //   List args = [id];
  //
  //   return await db!.rawDelete(sql, args);
  // }
  //
  // Future<int> update(int? id, Student student) async {
  //   await initDB();
  //
  //   String sql = 'UPDATE $TABLE SET name=?, age=?, image=? WHERE id=?';
  //
  //   List args = [student.name, student.age, student.image, id];
  //
  //   return await db!.rawUpdate(sql, args);
  // }
  //
  // Future<List<Student>> search(String name) async {
  //   await initDB();
  //
  //   String sql = "SELECT * FROM $TABLE WHERE name LIKE '%$name%'";
  //
  //   List<Map<String, dynamic>> data = await db!.rawQuery(sql);
  //
  //   return data.map((e) => Student.fromMap(e)).toList();
  // }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "animal.db");
    print(path);

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(
        join(
          "assets/database",
          "animal.db",
        ),
      );
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

      print("DB write successfully in device...");
    } else {
      print("Opening existing database");
    }
// open the database
    db = await openDatabase(path, readOnly: true);
  }

  Future<List<Category>> fetchCategoryData() async {
    await initDB();

    String category = 'SELECT * FROM $CAT_TABLE';

    List<Map<String, dynamic>> categoryData = await db!.rawQuery(category);
    print(categoryData);

    return categoryData.map((e) => Category.fromMap(e)).toList();
  }

  Future<List<AnimalData>> fetchAnimalData() async {
    await initDB();

    String quote = 'SELECT * FROM $ANIMAL_TABLE';

    List<Map<String, dynamic>> animalData = await db!.rawQuery(quote);
    print(animalData);

    return animalData.map((e) => AnimalData.fromMap(e)).toList();
  }

  Future<List> fetchDataCount() async {
    await initDB();

    String quote = 'SELECT COUNT($ANIMAL_ID), $CAT_ID FROM $ANIMAL_TABLE GROUP BY $CAT_ID';

    List<Map<String, dynamic>> animalData = await db!.rawQuery(quote);
    print(animalData);

    return animalData;
  }
}
