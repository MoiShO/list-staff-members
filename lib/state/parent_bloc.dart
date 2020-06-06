import 'package:list_staff_members/common/presets.dart';
import 'package:list_staff_members/database/gateaways/gateaways.dart';
import 'package:list_staff_members/models/children.dart';
import 'package:list_staff_members/models/parent.dart';
import 'package:list_staff_members/models/parent_bloc_data.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class ParentBloc {
  final ParentGateway parentGateway;
  final ChildrenGateway childrenGateway;

  BehaviorSubject<List<ParentBlocData>> _parentSubject;

  ParentBloc({
    @required this.parentGateway,
    @required this.childrenGateway
  }) {
    _parentSubject = new BehaviorSubject<List<ParentBlocData>>();
    update();
  }

  Future<void> update() async {
    // clearBD
    // parentGateway.clear();
    // childrenGateway.clear();
    final data = await Future.wait([parentGateway.getParent(), childrenGateway.getChildren()]);
    final parentData = ChildAndParent(parents: data[0], children: data[1]);
    final parentBlocData = parentData.parents.map((parent) => 
        ParentBlocData(
          parent: parent,
          children: parentData.children.where((child) => child.idParent == parent.id).toList()
        )
      ).toList();
    _parentSubject.sink.add(parentBlocData);
  }

  // add from prets
  // Future<void> appendPreset() async {
  //   await Future.forEach<ParentData>(parentsPreset, (parent) => parentGateway.insert(parent));
  //   await Future.forEach<ChildrenData>(childrenPreset, (child) => childrenGateway.insert(child));
  //   await update();
  // }

  Future<void> append(ParentData parent) async {
    await parentGateway.insert(parent);
    await update();
  }

  ValueStream<List<ParentBlocData>> get data => _parentSubject.stream;

  void close() {
    _parentSubject.close();
  }
}
