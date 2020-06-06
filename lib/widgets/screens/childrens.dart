
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:list_staff_members/common/constants.dart';
import 'package:list_staff_members/models/children.dart';
import 'package:list_staff_members/common/theme.dart';
import 'package:list_staff_members/common/utils.dart';
import 'package:list_staff_members/state/childrent_bloc.dart';
import 'package:list_staff_members/state/parent_bloc.dart';
import 'package:list_staff_members/widgets/components/button.dart';
import 'package:list_staff_members/widgets/screens/form/add_form.dart';

class Childrens extends StatefulWidget {
  final String title;
  final int parentId;

  const Childrens({
    Key key,
    this.title = '', 
    this.parentId,
  }) : super(key: key);

  @override
  _ChildrensState createState() => _ChildrensState();
}

class _ChildrensState extends State<Childrens> {

  ChildrenBloc childrenBloc;
  ParentBloc parentBloc;

  @override
  void initState() {
    childrenBloc = Injector.appInstance.getDependency<ChildrenBloc>();
    parentBloc = Injector.appInstance.getDependency<ParentBloc>();
    childrenBloc.getChildrenById(widget.parentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.parentId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}')
      ),
       floatingActionButton: FloatingActionButton(
         onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddForm(
              who: Who.CHILDREN,
              title: 'Добавить ребенка',
              submitMessage: 'Добавлен ребенок ',
              onSubmit: (ChildrenData newChildren) async => await childrenBloc.append(newChildren, parentId: widget.parentId)
            ))),
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.75),
          child: Icon(Icons.add, size: 40,),
        ),
      body: StreamBuilder<List<ChildrenData>>(
        stream: childrenBloc.data,
        builder: (BuildContext context, AsyncSnapshot<List<ChildrenData>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          final children = snapshot.data;

          return ListView.builder(
            itemCount: children.length,
            itemBuilder: (BuildContext contex, int index) {
              final firstName = children[index].firstName;
              final lastName = children[index].lastName;
              final patronymic = children[index].patronymic;
              final id = children[index].id;
              final fio = '$firstName $lastName $patronymic';
              final birth = formatDate(fromTimestamp(children[index].dateBirt));

              return ChildWidget(
                fio: fio,
                birth: birth,
                childrenBloc: childrenBloc,
                id: id,
                index: index,
                parentId: widget.parentId,
                parentBloc: parentBloc
              );
            }
          );
        }
      )
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({
    Key key,
    @required this.fio,
    @required this.birth,
    @required this.childrenBloc,
    @required this.id,
    @required this.index,
    @required this.parentId,
    @required this.parentBloc,
  }) : super(key: key);

  final String fio;
  final String birth;
  final ChildrenBloc childrenBloc;
  final int id;
  final int index;
  final int parentId;
  final ParentBloc parentBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(index),
      margin: const EdgeInsets.symmetric(horizontal: Style.horizontalPadding, vertical: 5),
      padding: Style.defaultPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: Style.borderRadius,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).accentColor.withOpacity(0.2),
            offset: Offset(2, 5),
            blurRadius: 3
          )
        ]
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    fio,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                RichText(
                  maxLines: 4,
                  softWrap: true,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    children: <TextSpan>[
                      TextSpan(
                        children: <TextSpan> [
                          TextSpan(
                            text: 'Даеа рождения: '
                          ),
                          TextSpan(
                            text: '$birth \n',
                            style: Theme.of(context).textTheme.bodyText2
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
          ButtonCircle(
            child: Icon(Icons.delete_forever),
            onTap: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: Text('Вы действительно хотите удалить $fio'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Отмена'),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                  ),
                  FlatButton(
                    child: Text('Удалить'),
                    onPressed: () async {
                      await childrenBloc.removeChildren(id, parentId: parentId);
                      parentBloc.update();
                      Navigator.pop(context);
                    }
                  )
                ],
              )
            ),
          )
        ]
      ),
    );
  }
}