
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:list_staff_members/state/parent_bloc.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text('nono'),
            FlatButton(
              onPressed: () async => parentBloc.appendPreset(),
              child: Text('use preset'),
            )
          ],
        ),
      ),
    );
  }
}