import 'package:bizzytasks_app/helpers/networking.dart';
import 'package:bizzytasks_app/provider/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Task {
  //Obtener resumen tareas
  Future<dynamic> getSummaryTasks({context, body}) async {
    NetworHelper networHelper =
        NetworHelper(url: '/tasks/summaryTasks', context: context, body: body);

    var decodeData = await networHelper.getData();

    return decodeData;
  }

//Totalizar las tareas
  getTotals(data, type) {
    if (data.length == 0) return 0;
    return data.fold(0, (sum, tarea) => sum + tarea[type]);
  }

  //Obtener todas las tareas
  Future<dynamic> getTasks({required BuildContext context}) async {
    dynamic body = context.watch<TaskProvider>().tasksFilter;
    String filtro =
        body.entries.map((entry) => "${entry.key}=${entry.value}").join("&");
    NetworHelper networHelper =
        NetworHelper(url: '/tasks?' + filtro, context: context, body: {});

    var decodeData = await networHelper.getData();

    return decodeData;
  }

//Crear tarea
  Future<dynamic> storeTask({context, body}) async {
    NetworHelper networHelper =
        NetworHelper(url: '/tasks', context: context, body: body);

    var decodeData = await networHelper.postData();

    return decodeData;
  }

  //Consultar tarea
  Future<dynamic> getTask({context, idTask}) async {
    NetworHelper networHelper =
        NetworHelper(url: '/tasks/' + idTask, context: context, body: {});

    var decodeData = await networHelper.getData();

    return decodeData;
  }

  //Actualizar tarea
  Future<dynamic> updateTask({context, idTask, body}) async {
    NetworHelper networHelper =
        NetworHelper(url: '/tasks/' + idTask, context: context, body: body);

    var decodeData = await networHelper.putData();

    return decodeData;
  }

  //Actualizar tarea
  Future<dynamic> updateStatus({context, idTask, body}) async {
    NetworHelper networHelper = NetworHelper(
        url: '/tasks/cambiarEstado/' + idTask, context: context, body: body);

    var decodeData = await networHelper.putData();

    return decodeData;
  }
}
