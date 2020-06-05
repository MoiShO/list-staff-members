import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:list_staff_members/common/injector.dart';
import 'package:list_staff_members/state/parent_bloc.dart';
import 'package:list_staff_members/widgets/home.dart';

void main() async {
  await setupInjector();
  runApp(Root());
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  ParentBloc parentBloc;

  @override
  void initState() {
    parentBloc = Injector.appInstance.getDependency<ParentBloc>();
    parentBloc.update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }

  @override
  void dispose() {
    closeGlobalBlocs();
    super.dispose();
  }
}
