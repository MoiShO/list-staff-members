import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_staff_members/common/constants.dart';
import 'package:list_staff_members/common/theme.dart';
import 'package:list_staff_members/common/utils.dart';
import 'package:list_staff_members/models/children.dart';
import 'package:list_staff_members/models/parent.dart';
import 'package:list_staff_members/widgets/components/button.dart';
import 'package:list_staff_members/widgets/screens/form/components/default_input.dart';

typedef ParentCallback = void Function(ParentData);
typedef ChildrenCallback = void Function(ChildrenData);

class AddForm extends StatefulWidget {
  AddForm({
    Key key,
    @required this.title,
    @required this.onSubmit,
    @required this.who,
    this.parentId,
    this.submitMessage = 'Добавлен сотрудник'
  }) : super(key: key);

  final String title;
  final Function onSubmit;
  final Who who;
  final int parentId;
  final String submitMessage;

  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  DateTime _selectedDate;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController patronymicController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  
  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: SafeArea(
        child: Scaffold(
          key: _key,
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Container(
            padding: Style.defaultPadding,
            child: Form(
              key: this._formKey,
              child: ListView(
                children: <Widget>[
                  DefaultInput(
                    hintText: 'Имя',
                    labelText: 'Иван',
                    controller: firstNameController,
                  ),
                  DefaultInput(
                    hintText: 'Иванович',
                    labelText: 'Отчество',
                    controller: lastNameController,
                  ),
                  DefaultInput(
                    hintText: 'Иванов',
                    labelText: 'Фамилия',
                    controller: patronymicController
                  ),
                  Who.PARENT == widget.who
                  ? DefaultInput(
                    hintText: 'Профессиональный иван',
                    labelText: 'Должность',
                    controller: positionController,
                  ) : Container(),
                  Padding(
                    padding: const EdgeInsets.only(top: Style.vertical),
                    child: Row(
                      children: <Widget>[
                        Text('Дата рождения:'),
                        ButtonCircle(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            child: Text('${formatDate(_selectedDate)}')
                          ),
                          onTap: () =>  showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(1920, 1, 1),
                            lastDate: DateTime.now()
                          ).then((date) => setState(() {
                            if(date != null) {
                              _selectedDate = date;
                            }
                          }))
                        )
                      ],
                    ),
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    child: new RaisedButton(
                      child: new Text(
                        'Добавить',
                        style: new TextStyle(
                          color: Colors.white
                        ),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          final firstName = firstNameController.text;
                          final lastName = lastNameController.text;
                          final patronymic = patronymicController.text;
                          if(Who.PARENT == widget.who) {
                            await widget.onSubmit(
                              ParentData(
                                firstName: firstName,
                                lastName: lastName,
                                patronymic: patronymic,
                                dateBirt: toTimestamp(_selectedDate),
                                position: positionController.text
                              )
                            );
                          } if(Who.CHILDREN == widget.who) {
                            await widget.onSubmit(
                              ChildrenData(
                                firstName: firstName,
                                lastName: lastName,
                                patronymic: patronymic,
                                dateBirt: toTimestamp(_selectedDate),
                              )
                            );
                          }
                          _key.currentState.showSnackBar(
                            SnackBar(
                              content: Text(
                              '${widget.submitMessage} $firstName $lastName $patronymic'
                            ),
                          ));
                          firstNameController.clear();
                          lastNameController.clear();
                          patronymicController.clear();
                          positionController.clear();
                          setState(() {
                            _selectedDate = DateTime.now();
                          });
                        }
                      },
                      color: Colors.blue,
                    ),
                    margin: new EdgeInsets.only(
                      top: 20.0
                    ),
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}