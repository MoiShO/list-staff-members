
import 'package:list_staff_members/models/children.dart';
import 'package:list_staff_members/models/parent.dart';
import 'package:list_staff_members/common/utils.dart';

final List<ParentData> parentsPreset = [
  ParentData(
    id: 1,
    firstName: 'Jon',
    lastName: 'Dou',
    patronymic: 'Аркадьевич',
    dateBirt: toTimestamp(DateTime(1990, 12, 24)),
    position: 'Good Boy',
  ),
  ParentData(
    id: 2,
    firstName: 'Alina',
    lastName: 'Maksimova',
    patronymic: 'Ilyinishana',
    dateBirt: toTimestamp(DateTime(1992, 2, 26)),
    position: 'Middle developer',
  ),
  ParentData(
    id: 3,
    firstName: 'Diana',
    lastName: 'Arbenina',
    patronymic: 'Lvovna',
    dateBirt: toTimestamp(DateTime(1995, 1, 10)),
    position: 'Tester',
  ),
];

final List<ChildrenData> childrenPreset = [
  ChildrenData(
    id: 1,
    idParent: 2,
    firstName: 'Stefan',
    lastName: 'Artac',
    patronymic: 'Flutter',
    dateBirt: toTimestamp(DateTime(2016, 10, 4)),
  ),
  ChildrenData(
    id: 2,
    idParent: 1,
    firstName: 'Dick',
    lastName: 'Dou',
    patronymic: 'Jonнович',
    dateBirt: toTimestamp(DateTime(2002, 3, 6)),
  ),
  ChildrenData(
    id: 3,
    idParent: 1,
    firstName: 'Maria',
    lastName: 'Dou',
    patronymic: 'Jonнович',
    dateBirt: toTimestamp(DateTime(2019, 8, 20)),
  ),
];