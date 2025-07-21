import 'package:path/path.dart';
import 'package:quicknote/model/notes_model.dart';
import 'package:quicknote/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'notes.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT, isi TEXT, tanggal TEXT)',
        );

        await db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT, email TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> registerUser({UserModel? data}) async {
    final db = await DbHelper.db();

    await db.insert('users', {
      'username': data?.username,
      'password': data?.password,
      'email': data?.email,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<UserModel?> login(String username, String password) async {
    final db = await DbHelper.db();
    final List<Map<String, dynamic>> data = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (data.isNotEmpty) {
      return UserModel.fromMap(data.first);
    } else {
      return null;
    }
  }

  static Future<void> insertNotes(Notes notes) async {
    final db = await DbHelper.db();
    await db.insert(
      'notes',
      notes.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateNotes(Notes notes) async {
    final db = await DbHelper.db();
    await db.update(
      'notes',
      notes.toMap(),
      where: 'id = ?',
      whereArgs: [notes.id],
    );
  }

  static Future<void> deleteNotes(int id) async {
    final db = await DbHelper.db();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Notes>> getAllNotes() async {
    final db = await DbHelper.db();
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (i) => Notes.fromMap(maps[i]));
  }
}
