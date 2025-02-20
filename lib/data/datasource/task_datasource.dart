import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_new/data/data.dart';
import 'package:todo_new/utils/db_keys.dart';

class TaskDatasource {
  static final TaskDatasource _instance = TaskDatasource._();
  factory TaskDatasource() => _instance;

  TaskDatasource._(){
    _initDB();
  }
  static Database? _database;

  Future<Database> get database async{
    _database??= await _initDB();
    return _database!;
  }
  Future<Database> _initDB() async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DBKeys.dbName);
    return openDatabase(path,
    version: 2,
    onCreate: _onCreate,
    onUpgrade: _onUpgrade,
    );
  }

   

  
  Future<void> _onCreate(Database db, int version) async{
    await db.execute('''
        CREATE TABLE ${DBKeys.dbTable}(
          ${DBKeys.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${DBKeys.titleColumn} TEXT,
          ${DBKeys.noteColumn} TEXT,
          ${DBKeys.timeColumn} TEXT,
          ${DBKeys.dateColumn} TEXT,
          
          ${DBKeys.categoryColumn} TEXT,
          ${DBKeys.isCompletedColumn} INTEGER
        )

          ''');

         await db.execute('''
      CREATE TABLE IF NOT EXISTS settings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        isDarkMode INTEGER
        )
     
    ''');

         
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE ${DBKeys.dbTable} ADD COLUMN ${DBKeys.timeColumn} TEXT;");
    }

    await db.execute('''
      CREATE TABLE IF NOT EXISTS settings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,  -- ✅ Fixed typo
        isDarkMode INTEGER
      )
    ''');
  }
    Future<void> saveTheme(bool isDarkMode)async{
      final db = await database;
      await db.insert(
        'settings',
        {'isDarkMode': isDarkMode ? 1: 0},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<bool> getTheme() async {
    final db = await database;
    final result = await db.query('settings', limit: 1);

    if (result.isEmpty) {
      await db.insert(
        'settings',
        {'id': 1, 'isDarkMode': 0},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return false;
    }

    return result.first['isDarkMode'] == 1;
  }

   Future<int> addTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async{
      return await txn.insert(DBKeys.dbTable, task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    );

  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async{
      return await txn.update(
        DBKeys.dbTable, 
        task.toJson(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    }
    );

   }

   Future<int> deleteTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async{
      return await txn.delete(
        DBKeys.dbTable, 
        where: 'id = ?',
        whereArgs: [task.id],
      );
    }
    );

   }

    Future<List<Task>> getAllTasks() async{
      final db = await database;
      final List<Map<String, dynamic>> data = await db.query(DBKeys.dbTable, orderBy: "id DESC",);
      return List.generate(
        data.length, 
        (index) => Task.fromJson(data[index])
      );
    }
}