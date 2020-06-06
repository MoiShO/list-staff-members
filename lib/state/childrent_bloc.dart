import 'package:list_staff_members/database/gateaways/gateaways.dart';
import 'package:list_staff_members/models/children.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class ChildrenBloc {
  final ChildrenGateway childrenGateway;
  BehaviorSubject<List<ChildrenData>> _childrenSubject;

  ChildrenBloc({
    @required this.childrenGateway,
  }) {
    _childrenSubject = new BehaviorSubject<List<ChildrenData>>();
  }

  getChildrenById(int parentId) async{
    final data = await childrenGateway.getById(parentId);
    _childrenSubject.add(data);
  }


  Future<void> removeChildren(int childrenId, {int parentId}) async {
    await childrenGateway.delete(childrenId);
    await getChildrenById(parentId);
  }

  Future<void> append(ChildrenData newChild, {int parentId}) async {
    newChild.idParent = parentId;
    print(newChild.idParent);
    await childrenGateway.insert(newChild);
    await getChildrenById(parentId);
  }


  ValueStream<List<ChildrenData>> get data => _childrenSubject.stream;

  void close() {
    _childrenSubject.close();
  }
}
