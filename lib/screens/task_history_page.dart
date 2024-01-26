import 'package:bizzytasks_app/theme/colors/light_colors.dart';
import 'package:bizzytasks_app/widgets/back_button.dart';
import 'package:flutter/material.dart';

class TaskHistoryPage extends StatefulWidget {
  final dynamic taskHistory;
  const TaskHistoryPage({required this.taskHistory});

  @override
  State<TaskHistoryPage> createState() => _TaskHistoryPageState();
}

class _TaskHistoryPageState extends State<TaskHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            MyBackButton(),
            Text(
              'Historial de: ' + widget.taskHistory['ca102nombre'],
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20.0),
            ListView.builder(
              itemCount: widget.taskHistory['repeticiones'].length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _taskHistoryContainer(
                    widget.taskHistory['repeticiones'][index]);
              },
            )
          ],
        ),
      )),
    );
  }

  Widget _taskHistoryContainer(repeticiones) {
    print(MediaQuery.of(context).size.width * 2);
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: 100, minWidth: MediaQuery.of(context).size.width),
          child: Container(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vencimiento estimado: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(repeticiones['ca104fecha_ejecucion_estimada']),
                Text('Vencimiento real: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(repeticiones['ca104fecha_ejecucion_real_tim']),
                Text('Observaciones: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: Text(repeticiones['ca104observaciones']),
                ),
                Text('Ejecutado por:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(repeticiones['usuario']['ca100nombre']),
              ],
            ),
            // height: 200.0,
            // color: LightColors.kLightGreen,
            decoration: BoxDecoration(
              color: LightColors.kLightGreen,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
