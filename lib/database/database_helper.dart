import 'package:sqflite/sqflite.dart';
import '../models/student.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'clubhub.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students(
        student_id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        year TEXT,
        dept_name TEXT,
        field_of_interest TEXT,
        clubs_joined TEXT,
        contact_info TEXT
      )
    ''');
  }

  Future<int> insertStudent(Student student) async {
    final db = await database;
    return await db.insert('students', student.toMap());
  }

  Future<Student?> loginStudent(String email, String password) async {
    final db = await database;
    final maps = await db.query(
      'students',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (maps.isNotEmpty) {
      return Student.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateClubsJoined(int studentId, String clubsJoined) async {
    final db = await database;
    return await db.update(
      'students',
      {'clubs_joined': clubsJoined},
      where: 'student_id = ?',
      whereArgs: [studentId],
    );
  }
}
