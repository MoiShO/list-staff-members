import 'package:list_staff_members/common/presets.dart';
import 'package:list_staff_members/database/gateaways/gateaways.dart';
import 'package:list_staff_members/models/models.dart';
import 'package:list_staff_members/models/parent.dart';
import 'package:list_staff_members/models/parent_bloc_data.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class ParentBloc {
  final ParentGateway parentGateway;
  final ChildrenGateway childrenGateway;

  // BehaviorSubject<ParentBlocData> _parentSubject;

  ParentBloc({
    @required this.parentGateway,
    @required this.childrenGateway
  }) {
    // _parentSubject = new BehaviorSubject<ParentBlocData>();
    update();
  }

  Future<void> update() async {
    final data = await Future.wait([parentGateway.getParent(), childrenGateway.getChildren()]);
    data[0].forEach((element) {
      print(element);
    });
    // _parentSubject.sink.add(ParentBlocData(period, Map.fromIterable(data[0], key: (item) => item.uuid), data[1]));
  }

  Future<void> appendPreset() async {
    await Future.forEach<ParentData>(parentsPreset, (question) => parentGateway.insert(question));
    await update();
    // _parentSubject.sink.add(ParentBlocData(period, Map.fromIterable(data[0], key: (item) => item.uuid), data[1]));
  }


  // ValueStream<ParentBlocData> get data => _parentSubject.stream;

  void close() {
    // _parentSubject.close();
  }
}
