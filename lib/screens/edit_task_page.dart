import 'package:bizzytasks_app/models/task_model.dart';
import 'package:bizzytasks_app/screens/task_history_page.dart';
import 'package:bizzytasks_app/theme/colors/light_colors.dart';
import 'package:bizzytasks_app/utilities/constants.dart';
import 'package:bizzytasks_app/widgets/button_widget.dart';
import 'package:bizzytasks_app/widgets/my_alert_dialog.dart';
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
  dynamic _idTask = 0;
  dynamic _taskData = '';
  dynamic _taskStatus = '';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _taskObservationsController = TextEditingController();

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

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    _taskObservationsController.dispose();
    super.dispose();
  }

  void _getTasks() async {
    dynamic response =
        await task.getTask(context: context, idTask: widget.idTask.toString());

    if (response != null) {
      _taskData = response['data'];

      setState(() {
        _idTask = _taskData['ca102cod_tarea'].toString();
        _selectedCategorie = _taskData['ca102cod_categoria'];
        _selectedUser = _taskData['ca102cod_usuario_asignado'];
        _selectedPriority = _taskData['ca102prioridad'];
        _selectedFrecuencie = _taskData['ca102frecuencia_ejecucion'];
        _selectedRepeatDay = _taskData['ca102dia_semana_o_mes_ejecucion'];
        _selectDateEndTask = _taskData['ca102fecha_ejecucion_estimada'];
        _taskStatus = _taskData['ca102estado'];
      });
      _titleController.text = _taskData['ca102nombre'];
      _descriptionController.text = _taskData['ca102descripcion'];
      _taskObservationsController.text = _taskData['ca102observaciones'];
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                        _titleController.text,
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
                      // _title = value;
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
                        width: width / 2.5,
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
                      width: width / 2.5,
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
                  Text(
                    'Cambiar estado:',
                    style: TextStyle(
                        decoration: TextDecoration.underline, fontSize: 20.0),
                  ),
                  MyTextField(
                      label: 'Observaciones',
                      minLines: 2,
                      maxLines: 3,
                      controller: _taskObservationsController,
                      onChanged: (value) => {}),
                  Row(
                    children: _textButtonChangeStatus(),
                  )
                ],
              ),
              if (_selectedFrecuencie > 0)
                TextButton.icon(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TaskHistoryPage(taskHistory: _taskData),
                        ))
                  },
                  icon: Icon(Icons.history),
                  label: Text(
                    'Ver historial de repeticiones',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: width / 2),
                    child: ButtonWidget(
                        tittleButton: 'Actualizar tarea',
                        isLoading: isLoading,
                        disabled: isDiseabledButton,
                        onPressed: () async {
                          _updateTask();
                        }),
                  ),
                ],
              ),
            ],
          ), ////Columna
        ),
      ),
    );
  }

// Botones para cambiar de estado a la tarea
  List<Widget> _textButtonChangeStatus() {
    dynamic array = [];
    switch (_taskStatus) {
      case 'PE':
        array.add({'codStatus': 'PR', 'label': 'En proceso'});
        break;
      case 'PR':
        array.add({'codStatus': 'PE', 'label': 'Pendiente'});
        array.add({'codStatus': 'FI', 'label': 'Finalizado'});
        break;
      case 'FI':
        array.add({'codStatus': 'PR', 'label': 'En proceso'});
        break;
      default:
    }
    List<Widget> listWidget = [];
    listWidget.add(Text('Marcar como: '));

    for (var status in array) {
      dynamic colorButton = kEstados[status['codStatus']]![1];
      listWidget.add(
        GestureDetector(
          onTap: isDiseabledButton
              ? null
              : () => {_updateStatus(status['codStatus'])},
          child: Chip(
            backgroundColor: isDiseabledButton ? Colors.grey : colorButton,
            label: Text(status['label']),
          ),
        ),
      );
    }
    return listWidget;
  }

//Actualizar tarea
  _updateTask() async {
    setState(() {
      isLoading = true;
      isDiseabledButton = true;
    });
    dynamic body = {
      'ca102nombre': _titleController.text,
      'ca102cod_categoria': _selectedCategorie,
      'ca102descripcion': _descriptionController.text,
      'ca102prioridad': _selectedPriority,
      'ca102fecha_ejecucion_estimada': _selectDateEndTask,
      'ca102frecuencia_ejecucion': _selectedFrecuencie,
      'ca102dia_semana_o_mes_ejecucion': _selectedRepeatDay,
      'ca102cod_usuario_asignado': _selectedUser
    };
    dynamic result =
        await task.updateTask(idTask: _idTask, context: context, body: body);

    setState(() {
      isLoading = false;
      isDiseabledButton = false;
    });
  }

//Cambiar estado tarea
  _updateStatus(newStatus) async {
    setState(() {
      isDiseabledButton = true;
    });

    dynamic result = await task.updateStatus(
        context: context,
        body: {
          'ca102estado': newStatus,
          'ca102observaciones': _taskObservationsController.text,
        },
        idTask: _idTask.toString());
    setState(() {
      isDiseabledButton = false;
    });

    if (result != null) {
      setState(() {
        _getTasks();
      });
    }
  }
}
