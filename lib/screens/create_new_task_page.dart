import 'package:bizzytasks_app/models/task_model.dart';
import 'package:bizzytasks_app/utilities/constants.dart';
import 'package:bizzytasks_app/widgets/button_widget.dart';
import 'package:bizzytasks_app/widgets/my_date_picker.dart';
import 'package:bizzytasks_app/widgets/my_drop_down_button.dart';
import 'package:bizzytasks_app/widgets/my_item_list_drop_down.dart';
import 'package:bizzytasks_app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:bizzytasks_app/widgets/back_button.dart';

class CreateNewTaskPage extends StatefulWidget {
  @override
  State<CreateNewTaskPage> createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  Task task = Task();
  var isLoading = false;
  var isDiseabledButton = false;
  dynamic _selectedCategorie = '';
  dynamic _selectedUser = '';
  dynamic _selectedPriority = '';
  dynamic _selectedFrecuencie = 0;
  dynamic _selectedRepeatDay = 0;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  var _selectDateEndTask = kDateFormat.format(DateTime.now());
  void callEndDateTaskPicker() async {
    var selectDate = await getDatePickerWidget(context, _selectDateEndTask);
    setState(() {
      _selectDateEndTask = kDateFormat.format(selectDate);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    double height = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Crear nueva tarea',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  MyTextField(
                    label: 'Título',
                    controller: _titleController,
                    onChanged: (value) {
                      // _titleController = value;
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  MyTextField(
                    label: 'Description',
                    controller: _descriptionController,
                    minLines: 3,
                    maxLines: 3,
                    onChanged: (value) {
                      // _descriptionController = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: MyDropDownButton(
                          title: 'Categorías',
                          value: _selectedCategorie,
                          orientation: 'column',
                          items: itemsDropdownCategorias(context),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategorie = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 40),
                      Expanded(
                        child: MyDropDownButton(
                          title: 'Prioridad',
                          value: _selectedPriority,
                          orientation: 'column',
                          items: itemsDropdownPrioridades(context),
                          onChanged: (value) {
                            setState(() {
                              _selectedPriority = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  MyDropDownButton(
                    title: 'Asignar a: ',
                    value: _selectedUser,
                    orientation: 'column',
                    items: itemsDropdownUsuarios(context),
                    onChanged: (value) {
                      setState(() {
                        _selectedUser = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myDateWidget(
                          title: 'Fecha vencimiento',
                          onPressed: callEndDateTaskPicker,
                          dateString: _selectDateEndTask),
                      MyDropDownButton(
                        title: 'Repetir cada: ',
                        value: _selectedFrecuencie,
                        orientation: 'column',
                        width: MediaQuery.of(context).size.width / 2.5,
                        items: itemsDropdownFrecuencias(context),
                        onChanged: (value) {
                          setState(() {
                            _selectedFrecuencie = value;
                          });
                        },
                      ),
                    ],
                  ),
                  if (_selectedFrecuencie > 1)
                    MyDropDownButton(
                      title: 'Los días: ',
                      value: _selectedRepeatDay,
                      orientation: 'column',
                      width: MediaQuery.of(context).size.width / 2.5,
                      items: _selectedFrecuencie > 15
                          ? itemsDropdownDiasMes(context)
                          : itemsDropdownDiasSemana(context),
                      onChanged: (value) {
                        setState(() {
                          _selectedRepeatDay = value;
                        });
                      },
                    ),
                  SizedBox(height: 20),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: width,
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: width,
                          child: ButtonWidget(
                              tittleButton: 'Crear tarea',
                              isLoading: isLoading,
                              disabled: isDiseabledButton,
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                  isDiseabledButton = true;
                                });
                                dynamic result = await task
                                    .storeTask(context: context, body: {
                                  'ca102nombre': _titleController.text,
                                  'ca102cod_categoria': _selectedCategorie,
                                  'ca102descripcion':
                                      _descriptionController.text,
                                  'ca102prioridad': _selectedPriority,
                                  'ca102fecha_ejecucion_estimada':
                                      _selectDateEndTask,
                                  'ca102frecuencia_ejecucion':
                                      _selectedFrecuencie,
                                  'ca102dia_semana_o_mes_ejecucion':
                                      _selectedRepeatDay,
                                  'ca102cod_usuario_asignado': _selectedUser
                                });
                                setState(() {
                                  isLoading = false;
                                  isDiseabledButton = false;
                                });

                                if (result != null) {
                                  setState(() {
                                    _titleController.text = '';
                                    _selectedCategorie = '';
                                    _descriptionController.text = '';
                                    _selectedPriority = '';
                                    _selectedFrecuencie = 0;
                                    _selectedRepeatDay = 0;
                                    _selectedUser = '';
                                  });
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ), ////Columna
        ),
      ),
    );
  }
}
