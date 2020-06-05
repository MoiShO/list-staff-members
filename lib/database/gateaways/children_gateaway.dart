import 'package:flutter/widgets.dart';
import 'package:list_staff_members/database/db_adapter.dart';
import 'package:list_staff_members/models/children.dart';

class ChildrenGateway {
  final DbAdapter db;

  ChildrenGateway({@required this.db});

  Future<List<ChildrenData>> getChildren() async {
    final db = await this.db.database;
    final rs = await db.rawQuery('SELECT * FROM children ORDER BY parent_id');
    final children = rs.map((question) => ChildrenData.fromMap(question)).toList();
    return children;
  }

  Future<void> insert(ChildrenData child) async {
    final db = await this.db.database;
    final rs = await db.rawQuery('SELECT MAX(number) AS last FROM children');
    final last = rs.first['last'] ?? 0;
    await db.rawInsert(
      'INSERT INTO children (id, parent_id, first_name, last_name, patronymic, date_birth) VALUES (?, ?, ?, ?, ?, ?)',
      [last + 1, child.idParent, child.firstName, child.lastName, child.patronymic, child.dateBirt]
    );
  }

  Future<void> update(ChildrenData child) async {
    final db = await this.db.database;
    await db.rawUpdate(
      'UPDATE children SET parent_id = ?, first_name = ?, last_name = ?, patronymic = ?, date_birth = ? WHERE id = ?', 
      [child.idParent, child.firstName, child.firstName, child.lastName, child.patronymic, child.dateBirt, child.id]
    );
  }

  Future<void> delete(int childId) async {
    final db = await this.db.database;
    await db.rawQuery('DELETE FROM children WHERE id = ?', [childId]);
  }
}