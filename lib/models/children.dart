import 'package:flutter/widgets.dart';

class ChildrenData {
  int id;
  int idParent;
  String firstName;
  String lastName;
  String patronymic;
  int dateBirt;

  ChildrenData({
    this.id,
    this.idParent,
    @required this.firstName,
    @required this.lastName,
    @required this.patronymic,
    @required this.dateBirt,
  });

  static ChildrenData fromMap(Map<String, dynamic> map) =>
    ChildrenData(
      id: map['id'],
      idParent: map['parent_id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      patronymic: map['patronymic'],
      dateBirt: map['date_birth'],
    );
}