import 'package:bizzytasks_app/models/task_model.dart';
import 'package:bizzytasks_app/provider/list_app_provider.dart';
import 'package:bizzytasks_app/provider/tasks_provider.dart';
import 'package:bizzytasks_app/utilities/constants.dart';
import 'package:bizzytasks_app/widgets/my_date_picker.dart';
import 'package:bizzytasks_app/widgets/my_drop_down_button.dart';
import 'package:bizzytasks_app/widgets/my_item_list_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:bizzytasks_app/theme/colors/light_colors.dart';
import 'package:bizzytasks_app/widgets/task_container.dart';
import 'package:bizzytasks_app/screens/create_new_task_page.dart';
import 'package:bizzytasks_app/widgets/back_button.dart';
import 'package:provider/provider.dart';

class CalendarPage extends StatefulWidget {
  final String title;
  const CalendarPage({required this.title});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Task tasks = Task();
  dynamic selectedUsuerCreat = '';
  dynamic selectedUsuerAsig = '';

  var startSelectedDate = kDateFormat.format(DateTime.now());
  var endSelectedDate = kDateFormat.format(DateTime.now());

  void callStartDatePicker() async {
    var selectDate = await getDatePickerWidget(context, startSelectedDate);
    setState(() {
      startSelectedDate = kDateFormat.format(selectDate);
    });
  }

  void callEndDatePicker() async {
    var selectDate = await getDatePickerWidget(context, endSelectedDate);
    setState(() {
      endSelectedDate = kDateFormat.format(selectDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),
          child: Column(
            children: <Widget>[
              MyBackButton(),
              SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.title.length > 10
                          ? widget.title.substring(0, 10)
                          : widget.title,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 40.0,
                      width: 120,
                      decoration: BoxDecoration(
                        color: LightColors.kGreen,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateNewTaskPage(),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            'Crear tarea',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ]),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  MyDropDownButton(
                      title: "Creada por: ",
                      width: 200.0,
                      items: itemsDropdownUsuarios(context),
                      value: selectedUsuerCreat,
                      onChanged: (value) {
                        setState(() {
                          selectedUsuerCreat = value;
                        });
                      }),
                  MyDropDownButton(
                      title: "Asignada a: ",
                      width: 200.0,
                      items: itemsDropdownUsuarios(context),
                      value: selectedUsuerAsig,
                      onChanged: (value) {
                        setState(() {
                          selectedUsuerAsig = value;
                        });
                      }),
                  Row(
                    children: [
                      myDateWidget(
                          title: 'Inicial',
                          onPressed: callStartDatePicker,
                          dateString: startSelectedDate),
                      myDateWidget(
                          title: 'Final',
                          onPressed: callEndDatePicker,
                          dateString: endSelectedDate),
                      //Filtrar datos
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: GestureDetector(
                          child: Icon(Icons.filter_alt_outlined),
                          onTap: () {
                            context.read<TaskProvider>().setTasksFilter({
                              'ca102cod_usuario_operacion': selectedUsuerCreat,
                              'ca102cod_usuario_asignado': selectedUsuerAsig,
                              'ca102fecha_ejecucion_estimada1':
                                  startSelectedDate,
                              'ca102fecha_ejecucion_estimada2': endSelectedDate,
                            });
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
              // SizedBox(height: 30),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     'April, 2020',
              //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              //   ),
              // ),
              // SizedBox(height: 20.0),
              FutureBuilder(
                future: tasks.getTasks(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    dynamic data = snapshot.data;
                    dynamic tasks = data['data'];
                    return _taskasList(tasks);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Listado de tareas

  Widget _taskasList(tasks) {
    dynamic tasksList = tasks['tareas']['data'];
    if (tasksList.length == 0) return Text('No hay información');
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: tasksList.length,
                itemBuilder: (context, index) {
                  return TaskContainer(
                    tasks: tasksList[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
