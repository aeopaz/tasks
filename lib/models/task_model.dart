import 'package:bizzytasks_app/helpers/networking.dart';

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
  Future<dynamic> getTasks({contex, body}) async {
    NetworHelper networHelper =
        NetworHelper(url: '/tasks', context: contex, body: body);

    var decodeData = await networHelper.getData();

    return decodeData;
  }
}
