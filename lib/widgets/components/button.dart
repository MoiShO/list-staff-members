import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCircle extends StatelessWidget {
  const ButtonCircle({
    Key key,
    @required this.child,
    @required this.onTap,
    this.materialBackgroud = Colors.transparent,
  }) : super(key: key);

  final Widget child;
  final Function onTap;
  final Color materialBackgroud;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: materialBackgroud,
      borderRadius: BorderRadius.all(Radius.circular(120)),
      child: ClipOval(
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(120)),
          splashColor: Theme.of(context).accentColor,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          )
        ),
      ),
    );
  }
}