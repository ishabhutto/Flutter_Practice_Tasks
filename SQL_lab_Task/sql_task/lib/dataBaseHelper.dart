import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_task/notes.dart';

class DatabaseHelper {
  static Database? _database;
  final String tablename = "notes";

  Future<Database> get dataBase async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDb();
      return _database!;
    }
  }

  // Create database
  Future<Database> initDb() async {
    final dbpath = await getDatabasesPath();
    final db = join(dbpath, 'notes.db');
    return await openDatabase(db, version: 2, onCreate: (db, version) {
      db.execute(
          "CREATE TABLE $tablename(id INTEGER PRIMARY KEY, rollno TEXT, name TEXT)");
    });
  }

  insert(Notes note) async {
    final db = await dataBase;

    Map<String, dynamic> notemap = {
      "id": note.id,
      "rollno": note.rollno,
      "name": note.name,
    };
    db.insert(tablename, notemap);
  }

  Future<List<Notes>> queryAll() async {
    final db = await dataBase;

    List<Map<String, dynamic>> maps = await db.query(tablename);
    return List.generate(
        maps.length,
        (index) => Notes(
              id: maps[index]["id"],
              rollno: maps[index]["rollno"],
              name: maps[index]["name"],
            ));
  }

  update(Notes note) async {
    final db = await dataBase;
    Map<String, dynamic> notemap = {
      "rollno": note.rollno,
      "name": note.name,
    };
    db.update(tablename, notemap, where: "id = ?", whereArgs: [note.id]);
  }

  delete(int id) async {
    final db = await dataBase;
    db.delete(tablename, where: "id=?", whereArgs: [id]);
  }

  Future<List<Notes>> searchStudents(String query) async {
    final db = await dataBase;

    List<Map<String, dynamic>> maps = await db.query(tablename,
        where: "name LIKE ? OR rollno LIKE ?",
        whereArgs: ['%$query%', '%$query%']);

    return List.generate(
      maps.length,
      (index) => Notes(
        id: maps[index]["id"],
        rollno: maps[index]["rollno"],
        name: maps[index]["name"],
      ),
    );
  }
}
