import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {


  static final _databaseName = "myDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'khatabook';
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnnumber = 'number';
  static final columnmoney = 'money';
  static final columntype = 'type';
  static final date = 'date';
  static final isgetmoney = 'isgetmoney';

  // make this a singleton class
  SQLiteHelper._privateConstructor();
  static final SQLiteHelper sqLiteHelper = SQLiteHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static  Database? _mydatabase;

  Future<Database> get database async {
    if (_mydatabase != null) return _mydatabase!;
    _mydatabase = await _initDatabase();
    return _mydatabase!;
  }
  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) {
          db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnnumber INTEGER NOT NULL,
            $columnmoney INTEGER NOT NULL,
            $columntype TEXT NOT NULL,
            $date DATE NOT NULL,
            $isgetmoney BOOLEAN NOT NULL
          )
          ''');
        });
  }


  adddata(String name, int number, int money, String type) async {
    final db = await database;
    await db.insert(
      '$table',
      {
        '$columnName': name,
        '$columnnumber': number, // Corrected column name
        '$columnmoney': money,
        '$columntype': type,
        '$date': DateTime.now().toString(),
        '$isgetmoney': 0
      },
    );
  }


  updatedata(int id, String name, int number, int money, String type) async {
    final db = await database;
    await db.update(
      '$table',
      {
        '$columnName': name,
        '$columnmoney': number,
        '$columnmoney': money,
        '$columntype': type
      },
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }


  deletedata(int id) async {
    final db = await database;
    await db.delete(
      '$table',
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }


  getdata() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM $table');
    return list;
  }

  getCreditdata() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM $table WHERE $columntype = "Credit"');
    return list;
  }

  getDeditdata() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM $table WHERE $columntype = "Debit"');
    return list;
  }

  gettotalcredit() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM $table WHERE $columntype = "Credit"');
    int total = 0;
    for (var i = 0; i < list.length; i++) {
      total = total + list[i]['$columnmoney'] as int;
    }
    return total;
  }

  gettotalDebit() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM $table WHERE $columntype = "Debit"');
    int total = 0;
    for (var i = 0; i < list.length; i++) {
      total = total + list[i]['$columnmoney'] as int;
    }
    return total;
  }


  // adddata() async {
  //   final db = await database;
  //   await db.insert(
  //     '$table',
  //     {
  //       'column1': 'value1',
  //       'column2': 42,
  //     },
  //   );
  // }


}