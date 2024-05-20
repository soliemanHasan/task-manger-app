import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_manger_app/modules/home/domain/entities/item_entity.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'task_manager.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY,
        todo TEXT,
        completed INTEGER,
        userId INTEGER
      )
    ''');
  }

  Future<void> insertItem(ItemEntity item) async {
    final db = await database;
    await db.insert('items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ItemEntity>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('items');

    return List.generate(maps.length, (i) {
      return ItemEntity(
        id: maps[i]['id'],
        todo: maps[i]['todo'],
        completed: maps[i]['completed'] == 1 ? true : false,
        userId: maps[i]['userId'],
      );
    });
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateItem(ItemEntity item) async {
    final db = await database;
    await db
        .update('items', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  Future<void> clearItems() async {
    final db = await database;
    await db.delete('items');
  }
}
