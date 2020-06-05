
import 'package:list_staff_members/models/parent.dart';
import 'package:list_staff_members/common/utils.dart';

var time = toTimestamp(DateTime(1989, 10, 24));

final List<ParentData> parentsPreset = [
  ParentData(
    id: 1,
    firstName: 'Jon',
    lastName: 'Dou',
    patronymic: 'Аркадьевич',
    dateBirt: toTimestamp(DateTime(1989, 10, 24)),
    position: 'Good Boy',
  ),
  ParentData(
    id: 2,
    firstName: 'Alina',
    lastName: 'Ilyinishana',
    patronymic: 'Maksimova',
    dateBirt: toTimestamp(DateTime(1989, 10, 24)),
    position: 'Middle developer',
  ),
  ParentData(
    id: 3,
    firstName: 'Diana',
    lastName: 'Arbenina',
    patronymic: 'Lvovna',
    dateBirt: toTimestamp(DateTime(1989, 10, 24)),
    position: 'Tester',
  ),
];