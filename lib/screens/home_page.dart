import 'package:bizzytasks_app/models/list_app_model.dart';
import 'package:bizzytasks_app/models/task_model.dart';
import 'package:bizzytasks_app/models/user_model.dart';
import 'package:bizzytasks_app/provider/list_app_provider.dart';
import 'package:bizzytasks_app/provider/tasks_provider.dart';
import 'package:bizzytasks_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:bizzytasks_app/screens/calendar_page.dart';
import 'package:bizzytasks_app/theme/colors/light_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:bizzytasks_app/widgets/task_column.dart';
import 'package:bizzytasks_app/widgets/active_project_card.dart';
import 'package:bizzytasks_app/widgets/top_container/top_container.dart';
import 'package:bizzytasks_app/widgets/top_container/user_info.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const id = 'home';

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user = User();
  Task tasks = Task();
  ListApp list = ListApp();

  @override
  void initState() {
    super.initState();
    _getListApp();
  }

//Obtener las listas que necesita la app
  void _getListApp() async {
    dynamic lists = await list.getList(context: context);
    context.read<ListAppProvider>().setListApp(lists);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            //Contenedor superior
            TopContainer(
              height:
                  MediaQuery.of(context).size.height / 3, //200,// Modificado
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.menu,
                            color: LightColors.kDarkBlue, size: 30.0),
                        Icon(Icons.search,
                            color: LightColors.kDarkBlue, size: 25.0),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // Avatar usuario
                          CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 5.0,
                            animation: true,
                            percent: 0.75,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: LightColors.kRed,
                            backgroundColor: LightColors.kDarkYellow,
                            center: CircleAvatar(
                              backgroundColor: LightColors.kBlue,
                              radius: 35.0,
                              backgroundImage: AssetImage(
                                'assets/images/avatar.png',
                              ),
                            ),
                          ),
                          // Información Usuario
                          FutureBuilder(
                            future: user.getUser(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return userInfo(context, snapshot.data);
                              }
                              return CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: tasks.getSummaryTasks(context: context, body: {}),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      dynamic data = snapshot.data;
                      dynamic summaryTasks = data['data'];
                      return bodySummaryTasks(context, summaryTasks);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//Subtitulos
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  //Cuerpo donde se encuentra el resumen de las tareas
  Column bodySummaryTasks(BuildContext context, summaryTasks) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  subheading('Mis tareas'),
                  GestureDetector(
                    onTap: () {
                      _onTapTodas();
                    },
                    child: HomePage.calendarIcon(),
                  ),
                ],
              ),
              // Resumen de tareas por estado
              summaryTasksStatus(summaryTasks)
            ],
          ),
        ),
        // Resumen tareas por categoría
        summaryTasksCategorie(summaryTasks),
      ],
    );
  }

  //Resumen tareas por estado
  Column summaryTasksStatus(data) {
    return Column(
      children: [
        SizedBox(height: 15.0),
        TaskColumn(
          icon: Icons.alarm,
          iconBackgroundColor: LightColors.kRed,
          onTap: () => {_onTapEstado('PE')},
          title: 'Pendiente',
          subtitle: tasks.getTotals(data, 'pendientes').toString() +
              ' tareas por comenzar',
        ),
        SizedBox(
          height: 15.0,
        ),
        TaskColumn(
          icon: Icons.blur_circular,
          iconBackgroundColor: LightColors.kDarkYellow,
          onTap: () => {_onTapEstado('PR')},
          title: 'En proceso',
          subtitle: tasks.getTotals(data, 'enProceso').toString() +
              ' tareas iniciadas',
        ),
        SizedBox(height: 15.0),
        TaskColumn(
          icon: Icons.check_circle_outline,
          iconBackgroundColor: LightColors.kBlue,
          onTap: () => {_onTapEstado('FI')},
          title: 'Finalizadas',
          subtitle: tasks.getTotals(data, 'finalizadas').toString() +
              ' tareas terminadas',
        ),
      ],
    );
  }

//Resumen tareas por categoría
  Container summaryTasksCategorie(data) {
    int itemCount = (data.length / 2).ceil();
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          subheading('Categorías'),
          SizedBox(height: 5.0),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                final firstCardIndex = index * 2;
                final secondCardIndex = firstCardIndex + 1;
                final firstCard = data[firstCardIndex];
                final secondCard = secondCardIndex < data.length
                    ? data[secondCardIndex]
                    : data[0];
                return Row(
                  children: [
                    ActiveProjectsCard(
                      cardColor: LightColors.kGreen,
                      loadingPercent: _calcPercent(firstCard),
                      title: firstCard['ca101nombre'],
                      subtitle: _organizeSubtitle(firstCard),
                      onTap: () => {
                        _onTapCategoria(firstCard['ca101cod_categoria'],
                            firstCard['ca101nombre'])
                      },
                    ),
                    SizedBox(width: 20.0),
                    if (secondCardIndex < data.length)
                      ActiveProjectsCard(
                        cardColor: LightColors.kRed,
                        loadingPercent: _calcPercent(secondCard),
                        title: secondCard['ca101nombre'],
                        subtitle: _organizeSubtitle(secondCard),
                        onTap: () => {
                          _onTapCategoria(secondCard['ca101cod_categoria'],
                              secondCard['ca101nombre'])
                        },
                      ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  _calcPercent(infoCard) {
    return infoCard['numTareas'] == 0
        ? 0.0
        : infoCard['finalizadas'] / infoCard['numTareas'];
  }

  _organizeSubtitle(infoCard) {
    return infoCard['finalizadas'].toString() +
        ' fin de ' +
        infoCard['numTareas'].toString();
  }

  _onTapEstado(estado) {
    dynamic title = kEstados[estado]?[0];
    context.read<TaskProvider>().setTasksFilter({
      'ca102estado': estado,
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarPage(
          title: title,
        ),
      ),
    );
  }

  _onTapCategoria(categoria, nombre) {
    context.read<TaskProvider>().setTasksFilter({
      'ca102cod_categoria': categoria,
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarPage(
          title: nombre,
        ),
      ),
    );
  }

  _onTapTodas() {
    context.read<TaskProvider>().setTasksFilter({
      'todos': '',
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarPage(
          title: "Tareas",
        ),
      ),
    );
  }
}
