
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:list_staff_members/common/constants.dart';
import 'package:list_staff_members/common/theme.dart';
import 'package:list_staff_members/common/utils.dart';
import 'package:list_staff_members/models/children.dart';
import 'package:list_staff_members/models/parent.dart';
import 'package:list_staff_members/models/parent_bloc_data.dart';
import 'package:list_staff_members/state/parent_bloc.dart';
import 'package:list_staff_members/widgets/screens/form/add_form.dart';
import 'package:list_staff_members/widgets/screens/children.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ParentBloc parentBloc;

  @override
  void initState() {
    parentBloc = Injector.appInstance.getDependency<ParentBloc>();
    parentBloc.update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            // onPressed: () async => await parentBloc.appendPreset(),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddForm(
              who: Who.PARENT,
              title: 'Добавить сотрудника',
              onSubmit: (ParentData newParent) async => await parentBloc.append(newParent)
            ))),
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.75),
            child: Icon(Icons.add, size: 40,),
          ),
          body: StreamBuilder<List<ParentBlocData>>(
            stream: parentBloc.data,
            builder: (BuildContext context, AsyncSnapshot<List<ParentBlocData>> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              }
              final parentsWithChild = snapshot.data;
              return ListView.builder(
                itemCount: parentsWithChild.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final firstName = parentsWithChild[index].parent.firstName;
                  final lastName = parentsWithChild[index].parent.lastName;
                  final patronymic = parentsWithChild[index].parent.patronymic;
                  final id = parentsWithChild[index].parent.id;
                  final fio = '$firstName $lastName $patronymic';

                  final position = parentsWithChild[index].parent.position;
                  final children = parentsWithChild[index].children;
                  final birth = formatDate(fromTimestamp(parentsWithChild[index].parent.dateBirt));

                  return HomeParentWidget(
                    fio: fio,
                    children: children,
                    birth: birth,
                    position: position,
                    index: index,
                    parentId: id,
                  );
                }
              );
            }
          )
        ),
      ),
    );
  }
}

class HomeParentWidget extends StatelessWidget {
  const HomeParentWidget({
    Key key,
    @required this.fio,
    @required this.children,
    @required this.index,
    @required this.birth,
    @required this.position,
    @required this.parentId,
  }) : super(key: key);

  final String fio;
  final List<ChildrenData> children;
  final int index;
  final String birth;
  final String position;
  final int parentId;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(index),
      margin: const EdgeInsets.symmetric(horizontal: Style.horizontalPadding, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: Style.borderRadius,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).accentColor.withOpacity(0.2),
            offset: Offset(2, 5),
            blurRadius: 3
          )
        ]
      ),
      child: Material(
        color:Theme.of(context).cardColor,
        borderRadius: Style.borderRadius,
        child: InkWell(
          splashColor: Theme.of(context).accentColor,
          borderRadius: Style.borderRadius,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) =>
              Children(
                title: '$fio',
                parentId: parentId,
              )
            )
          ),
          child: Container(
            padding: Style.defaultPadding,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '$fio',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Text(
                        'Дети',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RichText(
                        maxLines: 4,
                        softWrap: true,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText1,
                          children: <TextSpan>[
                            TextSpan(
                              children: <TextSpan> [
                                TextSpan(
                                  text: 'Дата рождения: '
                                ),
                                TextSpan(
                                  text: '$birth \n',
                                  style: Theme.of(context).textTheme.bodyText2
                                )
                              ],
                            ),
                            TextSpan(
                              children: <TextSpan> [
                                TextSpan(
                                  text: 'Должность: '
                                ),
                                TextSpan(
                                  text: '$position',
                                  style: Theme.of(context).textTheme.bodyText2
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Style.horizontalPadding / 2),
                      child: Text(
                        '${children.length == 0 ? "" : children.length }',
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}