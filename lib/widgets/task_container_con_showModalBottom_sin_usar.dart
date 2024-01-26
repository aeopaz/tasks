import 'package:bizzytasks_app/models/task_model.dart';
import 'package:bizzytasks_app/screens/edit_task_page.dart';
import 'package:bizzytasks_app/utilities/constants.dart';
import 'package:bizzytasks_app/utilities/date.dart';
import 'package:bizzytasks_app/utilities/text_format.dart';
import 'package:bizzytasks_app/widgets/button_widget.dart';
import 'package:bizzytasks_app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class TaskContainer extends StatefulWidget {
  final Map tasks;

  TaskContainer({required this.tasks});

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  Task task = Task();
  TextEditingController _taskObservations = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    dynamic estadoTarea = kEstados[widget.tasks['ca102estado']];
    dynamic prioridad = kPrioridad[widget.tasks['ca102prioridad']];
    CustomDateFormat fechaVencimientoTarea =
        CustomDateFormat(date: widget.tasks['ca102fecha_ejecucion_estimada']);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                organizeTitle(
                    widget.tasks['ca102cod_tarea'].toString() +
                        '-' +
                        widget.tasks['ca102nombre'],
                    long: 20),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                child: Row(children: [
                  if (widget.tasks['ca102frecuencia_ejecucion'] > 0)
                    Icon(Icons.repeat),
                  Icon(prioridad[1]),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditTaskPage(
                                idTask: widget.tasks['ca102cod_tarea'],
                              ),
                            ));
                      },
                      child: Icon(Icons.edit))
                ]),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              widget.tasks['ca102fecha_ejecucion_estimada'],
              maxLines: 1,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(fechaVencimientoTarea.vencimiento()),
              Text(estadoTarea[0]),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _textButtonChangeStatus(),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: estadoTarea[1], borderRadius: BorderRadius.circular(30.0)),
    );
  }

  List<Widget> _textButtonChangeStatus() {
    dynamic array = [];
    switch (widget.tasks['ca102estado']) {
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
      listWidget.add(
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                _taskObservations.text = widget.tasks['ca102observaciones'];
                return changeStatusContainer(context, status);
              },
            );
          },
          child: Chip(
            label: Text(status['label']),
          ),
        ),
      );
    }

    return listWidget;
  }

  Container changeStatusContainer(BuildContext context, status) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text('Pasar la tarea No ' +
                widget.tasks['ca102cod_tarea'].toString() +
                ' a ' +
                status['label']),
            MyTextField(
                label: 'Observaciones',
                minLines: 2,
                maxLines: 3,
                controller: _taskObservations,
                onChanged: (value) => {}),
            SizedBox(
              height: 20,
            ),
            ButtonWidget(
                tittleButton: 'Cambiar estado',
                isLoading: isLoading,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  dynamic result = await task.updateStatus(
                      context: context,
                      body: {
                        'ca102estado': status['codStatus'],
                        'ca102observaciones': _taskObservations.text,
                      },
                      idTask: widget.tasks['ca102cod_tarea'].toString());
                  setState(() {
                    isLoading = false;
                  });
                })
          ],
        ),
      ),
    );
  }
}
