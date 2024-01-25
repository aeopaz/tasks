import 'package:bizzytasks_app/models/task_model.dart';
import 'package:bizzytasks_app/utilities/constants.dart';
import 'package:bizzytasks_app/widgets/button_widget.dart';
import 'package:bizzytasks_app/widgets/my_date_picker.dart';
import 'package:bizzytasks_app/widgets/my_drop_down_button.dart';
import 'package:bizzytasks_app/widgets/my_item_list_drop_down.dart';
import 'package:bizzytasks_app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:bizzytasks_app/widgets/back_button.dart';

class EditTaskPage extends StatefulWidget {
  final int idTask;

  EditTaskPage({required this.idTask});
  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  Task task = Task();
  var isLoading = false;
  var isDiseabledButton = false;
  dynamic _selectedCategorie = '';
  dynamic _selectedUser = '';
  dynamic _selectedPriority = '';
  dynamic _selectedFrecuencie = 0;
  dynamic _selectedRepeatDay = 0;
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();

  var _selectDateEndTask = kDateFormat.format(DateTime.now());
  void callEndDateTaskPicker() async {
    var selectDate = await getDatePickerWidget(context, _selectDateEndTask);
    setState(() {
      _selectDateEndTask = kDateFormat.format(selectDate);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTasks();
  }

  void _getTasks() async {
    dynamic response =
        await task.getTask(context: context, idTask: widget.idTask.toString());

    if (response != null) {
      dynamic data = response['data'];
      setState(() {
        _selectedCategorie = data['ca102cod_categoria'];
        _selectedUser = data['ca102cod_usuario_asignado'];
        _selectedPriority = data['ca102prioridad'];
        _selectedFrecuencie = data['ca102frecuencia_ejecucion'];
        _selectedRepeatDay = data['ca102dia_semana_o_mes_ejecucion'];
        _selectDateEndTask = data['ca102fecha_ejecucion_estimada'];
      });
      _title.text = data['ca102nombre'];
      _description.text = data['ca102descripcion'];
    }
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
                        _title.text,
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  MyTextField(
                    label: 'Título',
                    controller: _title,
                    onChanged: (value) {
                      // _title = value;
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  MyTextField(
                    label: 'Description',
                    controller: _description,
                    minLines: 3,
                    maxLines: 3,
                    onChanged: (value) {
                      // _description = value;
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
                              tittleButton: 'Actualizar tarea',
                              isLoading: isLoading,
                              disabled: isDiseabledButton,
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                  isDiseabledButton = true;
                                });
                                dynamic result = await task
                                    .storeTask(context: context, body: {
                                  'ca102nombre': _title.text,
                                  'ca102cod_categoria': _selectedCategorie,
                                  'ca102descripcion': _description.text,
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
                                    _title.text = '';
                                    _selectedCategorie = '';
                                    _description.text = '';
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
