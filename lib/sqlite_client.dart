import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final _dbName = 'ex.db';
final _dbVersion = 2;

Database db;

Future<Database> sqliteClient() async {
  return db ?? await _init();
}

Future<Database> _init() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final path = join(documentsDirectory.path, _dbName);
  return openDatabase(path,
      version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
}

_onCreate(Database db, int version) async {
  /**
   * This script is executed only once on database startup.
   * So if you already initialized the database, then you should use `_onUpgrade` to add table/columns or anything else.
   * 
   * And if you're testing on iOS Simulator, go to `Hardware` > `Erase All Content And Settings`,
   * and you can roll up a fresh database, ie, `_onCreate` will be executed.
   */
}

/// To fire this function, just add one more to`_dbVersion`.
_onUpgrade(Database db, int oldVersion, int newVersion) async {
  final scripts = [
    '''
    --sql
    create table todos (
      id integer primary key,
      name varchar(20)
    );
    ''',
    '''
    --sql
    insert into todos ('name') values ('todo1'), ('todo2'), ('todo3');
    ''',
  ];

  final batch = db.batch();
  await Future.forEach(scripts, (script) async {
    await db.execute(script);
  });
  await batch.commit();
}
