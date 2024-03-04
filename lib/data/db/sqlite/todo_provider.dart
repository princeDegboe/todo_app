import 'package:exercice_api/data/modeles/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String tableTodo = 'tableTodos';
const String columnlocalID = 'localID';
const String columnId = 'id';
const String columnDescription = 'description';
const String columnTitle = 'title';
const String columnBeginedAt = 'begined_at';
const String columnFinishedAt = 'Finished_at';
const String columnDeadlinedAt = 'deadline_at';
const String columnPriority = 'priority';
const String columnUserId = 'user_id';
const String columnCreatedAt = 'created_at';
const String columnUpdatedAt = 'updated_at';

class TodoProvider {
  Database? _database;

  Future<bool> doesTableExist(String tableName) async {
    var result = await _database!.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      [tableName],
    );

    return result.isNotEmpty;
  }

  Future<void> initializeDatabase() async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), 'todos.db'),
      onCreate: (db, version) {
        return createTable(db);
      },
      version: 1,
    );
    bool tableExists = await doesTableExist(tableTodo);

    if (!tableExists) {
      createTable(_database!);
    }
  }

  Future<void> createTable(Database db) {
    return db.execute(
      '''
          CREATE TABLE $tableTodo (
            $columnlocalID INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnId TEXT,
            $columnDescription TEXT,
            $columnTitle TEXT,
            $columnBeginedAt TEXT,
            $columnFinishedAt TEXT,
            $columnDeadlinedAt TEXT,
            $columnPriority TEXT,
            $columnUserId TEXT,
            $columnCreatedAt TEXT,
            $columnUpdatedAt TEXT
          )
        ''',
    );
  }

  Future<Todo> insertTodo(Todo todo) async {
    await initializeDatabase();
    todo.localID = await _database!.insert(
      tableTodo,
      todo.toMap(),
    );
    return todo;
  }

  Future<int> update(Todo todo) async {
    await initializeDatabase();
    final localID = await _database!.update(
      tableTodo,
      todo.toMap(),
      where: '$columnlocalID = ?',
      whereArgs: [todo.id],
    );
    return localID;
  }

  Future<int> delete(int? localID) async {
    await initializeDatabase();
    return await _database!.delete(
      tableTodo,
      where: '$columnId = ?',
      whereArgs: [localID],
    );
  }

  Future<List<Todo>> getTodos() async {
    await initializeDatabase();
    List<Map> records = await _database!.query(
      tableTodo,
    );
    return records.map(
      (record) {
        Todo todo = Todo.fromMap(record);
        todo.localID = record['localID'];
        return todo;
      },
    ).toList();
  }

  Future close() async => _database!.close();
}
