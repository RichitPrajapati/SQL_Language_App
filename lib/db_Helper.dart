import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqll_language/Students.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();

  String dbName = 'demo.db';
  String tableName = 'students';

  String colId = 'id';
  String colName = 'name';
  String colAge = 'age';
  String colCity = 'city';

  Database? db;
  String? path;

  Future<void> initDB() async {
    String directory = await getDatabasesPath();
    path = join(directory, dbName);

    db = await openDatabase(
      path!,
      version: 1,
      onCreate: (Database db, int version) async {
        String query =
            "CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colAge INTEGER, $colCity TEXT);";
        await db.execute(query);

        print("========================================");
        print("DATABASE created successfully");
        print("========================================");
      },
    );
  }

  Future<int?> insertRecord() async {
    await initDB();

    String name = 'Richit';
    int age = 24;
    String city ='Surat';

    List args = [name, age, city];

    String query =
        "INSERT INTO $tableName($colName, $colAge, $colCity) VALUES(?, ?, ?);";

    int? id = await db?.rawInsert(query, args);

    return id;
  }

  Future<List<Student>?> fetchAllRecords() async {
    await initDB();

    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>>? allStudents = await db?.rawQuery(query);

    List<Student>? studentsData =
    allStudents?.map((e) => Student.fromMap(e)).toList();

    return studentsData;
  }
}
