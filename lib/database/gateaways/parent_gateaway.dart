import 'package:flutter/widgets.dart';
import 'package:list_staff_members/database/db_adapter.dart';
import 'package:list_staff_members/models/parent.dart';

class ParentGateway {
  final DbAdapter db;

  ParentGateway({@required this.db});

  Future<List<ParentData>> getParent() async {
    final db = await this.db.database;
    final rs = await db.rawQuery('SELECT * FROM parents ORDER BY id');
    final parents = rs.map((question) => ParentData.fromMap(question)).toList();
    return parents;
  }

  Future<void> insert(ParentData parent) async {
    final db = await this.db.database;
    await db.rawInsert(
      'INSERT INTO parents (first_name, last_name, patronymic, date_birth, position) VALUES (?, ?, ?, ?, ?)',
      [parent.firstName, parent.lastName, parent.patronymic, parent.dateBirt, parent.position]
    );
  }

  Future<void> update(ParentData parent) async {
    final db = await this.db.database;
    await db.rawUpdate(
      'UPDATE parents SET first_name = ?, last_name = ?, patronymic = ?, date_birth = ?, position = ?, WHERE id = ?', 
      [parent.firstName, parent.firstName, parent.lastName, parent.patronymic, parent.dateBirt, parent.position]
    );
  }

  // удаляет по ID
  Future<void> delete(int parentId) async {
    final db = await this.db.database;
    await db.rawQuery('DELETE FROM parents WHERE id = ?', [parentId]);
  }

  // develop
  Future<void> clear() async {
    final db = await this.db.database;
    await db.rawQuery('DELETE FROM parents');
  }
}