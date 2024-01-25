import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  Map<String, dynamic> _tasksFilter = {
    'ca102cod_usuario_operacion': '',
    'ca102cod_usuario_asignado': '',
    'ca102cod_categoria': '',
    'ca102estado': '',
    'ca102fecha_ejecucion_estimada1': '',
    'ca102fecha_ejecucion_estimada2': '',
  };

  Map<String, dynamic> get tasksFilter {
    return _tasksFilter;
  }

  void setTasksFilter(filter) {
    _tasksFilter = filter;

    notifyListeners();
  }
}


//  final taskProvider = Provider.of<TaskProvider>(context, listen: false);