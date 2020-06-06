import 'package:list_staff_members/models/children.dart';
import 'package:list_staff_members/models/parent.dart';

class ChildAndParent {
  final List<ChildrenData> children;
  final List<ParentData> parents;

  ChildAndParent({this.children, this.parents});
}
class ParentBlocData {
  final List<ChildrenData> children;
  final ParentData parent;

  ParentBlocData({this.children, this.parent});
}
