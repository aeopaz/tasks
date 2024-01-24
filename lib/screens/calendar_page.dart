import 'package:bizzytasks_app/models/list_app_model.dart';
import 'package:bizzytasks_app/models/task_model.dart';
import 'package:bizzytasks_app/provider/list_app_provider.dart';
import 'package:bizzytasks_app/widgets/my_drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:bizzytasks_app/utilities/dates_list.dart';
import 'package:bizzytasks_app/theme/colors/light_colors.dart';
import 'package:bizzytasks_app/widgets/calendar_dates.dart';
import 'package:bizzytasks_app/widgets/task_container.dart';
import 'package:bizzytasks_app/screens/create_new_task_page.dart';
import 'package:bizzytasks_app/widgets/back_button.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Task tasks = Task();
  dynamic selectedUsuer = '';
  dynamic selectedCategorie = '';

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
              SizedBox(height: 30.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Tareas',
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
                      items: _itemsDropdownUsuarios(),
                      value: selectedUsuer,
                      onChanged: (value) {
                        setState(() {
                          selectedUsuer = value;
                        });
                      }),
                  MyDropDownButton(
                      items: _itemsDropdownCategorias(),
                      value: selectedCategorie,
                      onChanged: (value) {
                        setState(() {
                          selectedCategorie = value;
                        });
                      }),
                ],
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'April, 2020',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              SizedBox(height: 20.0),
              FutureBuilder(
                future: tasks.getTasks(contex: context, body: {}),
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

  Expanded _taskasList(tasks) {
    dynamic tasksList = tasks['tareas']['data'];
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
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

//Lista de usuarios
  List<DropdownMenuItem> _itemsDropdownUsuarios() {
    List<DropdownMenuItem> items = [];
    var listaUsuarios =
        context.watch<ListAppProvider>().listApp['data']['listaUsuarios'];
    DropdownMenuItem new_item = DropdownMenuItem(
      child: Text('Seleccione...'),
      value: '',
    );
    items.add(new_item);
    for (var usuario in listaUsuarios) {
      DropdownMenuItem new_item = DropdownMenuItem(
        child: Text(usuario['ca100nombre']),
        value: usuario['ca100cod_usuario'],
      );

      items.add(new_item);
    }
    return items;
  }

  //Lista de categorías
  List<DropdownMenuItem> _itemsDropdownCategorias() {
    List<DropdownMenuItem> items = [];
    var lista =
        context.watch<ListAppProvider>().listApp['data']['listaCategorias'];
    DropdownMenuItem new_item = DropdownMenuItem(
      child: Text('Seleccione...'),
      value: '',
    );
    items.add(new_item);
    for (var l in lista) {
      DropdownMenuItem new_item = DropdownMenuItem(
        child: Text(l['ca101nombre']),
        value: l['ca101cod_categoria'],
      );

      items.add(new_item);
    }
    return items;
  }
}
