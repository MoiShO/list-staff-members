import 'package:flutter/widgets.dart';

class ParentData {
  int id;
  String firstName;
  String lastName;
  String patronymic;
  int dateBirt;
  String position;

  ParentData({
    this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.patronymic,
    @required this.dateBirt,
    @required this.position
  });

  static ParentData fromMap(Map<String, dynamic> map) =>
    ParentData(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      patronymic: map['patronymic'],
      dateBirt: map['date_birth'],
      position: map['position']
    );
}