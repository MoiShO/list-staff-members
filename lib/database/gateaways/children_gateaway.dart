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

  Future<List<ChildrenData>> getById(int parentId) async {
    final db = await this.db.database;
    final rs =  await db.rawQuery('SELECT * FROM children WHERE parent_id = ?', [parentId]);
    final children = rs.map((question) => ChildrenData.fromMap(question)).toList();
    return children;
  }

  Future<void> insert(ChildrenData child) async {
    final db = await this.db.database;
    await db.rawInsert(
      'INSERT INTO children (parent_id, first_name, last_name, patronymic, date_birth) VALUES (?, ?, ?, ?, ?)',
      [child.idParent, child.firstName, child.lastName, child.patronymic, child.dateBirt]
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

  Future<void> clear() async {
    final db = await this.db.database;
    await db.rawQuery('DELETE FROM children');
  }
}