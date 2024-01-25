import 'package:bizzytasks_app/screens/edit_task_page.dart';
import 'package:bizzytasks_app/theme/colors/light_colors.dart';
import 'package:bizzytasks_app/utilities/constants.dart';
import 'package:bizzytasks_app/utilities/date.dart';
import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  final Map tasks;
  // final String title;
  // final String subtitle;
  // final Color boxColor;
  // title: tasksList[index]['ca102nombre'],
  // subtitle: tasksList[index]['ca102descripcion'],
  TaskContainer({required this.tasks
      // required this.title,
      // required this.subtitle,
      // required this.boxColor,
      });

  @override
  Widget build(BuildContext context) {
    dynamic estadoTarea = kEstados[tasks['ca102estado']];
    dynamic prioridad = kPrioridad[tasks['ca102prioridad']];
    CustomDateFormat fechaVencimientoTarea =
        CustomDateFormat(date: tasks['ca102fecha_ejecucion_estimada']);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTaskPage(
                idTask: tasks['ca102cod_tarea'],
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.0),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tasks['ca102nombre'] +
                      ' (' +
                      tasks['ca102fecha_ejecucion_estimada'] +
                      ')',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(prioridad[1])
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                tasks['ca102descripcion'],
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
            )
          ],
        ),
        decoration: BoxDecoration(
            color: estadoTarea[1], borderRadius: BorderRadius.circular(30.0)),
      ),
    );
  }
}
