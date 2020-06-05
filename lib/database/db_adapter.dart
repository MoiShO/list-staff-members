import 'package:list_staff_members/common/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


// Подчиненные
// 1.      Фамилия
// 2.      Имя
// 3.      Отчество
// 4.      Дата рождения
// 5.      Должность
final initialisation = ['''
  CREATE TABLE parents (
    id INTEGER NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    patronymic TEXT NOT NULL,
    date_birth INTEGER NOT NULL,
    position TEXT NOT NULL,
    PRIMARY KEY (id)
  )
''',
// Дети
// 1.      Фамилия
// 2.      Имя
// 3.      Отчество
// 4.      Дата рождения
'''
  CREATE TABLE children (
    id INTEGER NOT NULL,
    parent_id INTEGER NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    patronymic TEXT NOT NULL,
    date_birth INTEGER NOT NULL,
    PRIMARY KEY (id)
  )
'''
];

final migrations = [];

class DbAdapter {
  Future<Database> database;

  DbAdapter() {
    database = open();
  }

  Future<Database> open() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), SQLITE_DB_NAME),
      version: migrations.length + 1,
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion == 0) {
          initialisation.forEach((sql) async => await db.execute(sql));
          migrations.forEach((sql) async => await db.execute(sql));
        } else {
          for (var i = oldVersion - 1; i < newVersion - 1; i++) {
            await db.execute(migrations[i]);
          }
        }
      }
    );
    await db.rawQuery('PRAGMA foreign_keys = ON');
    return db;
  }
}
