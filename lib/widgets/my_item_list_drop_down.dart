import 'package:bizzytasks_app/provider/list_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Lista de usuarios
List<DropdownMenuItem> itemsDropdownUsuarios(BuildContext context) {
  List<DropdownMenuItem> items = [];

  items = context
      .watch<ListAppProvider>()
      .listApp['data']['listaUsuarios']
      .map<DropdownMenuItem>((usuario) => DropdownMenuItem(
            child: Text(usuario['ca100nombre']),
            value: usuario['ca100cod_usuario'],
          ))
      .toList();
  items.insert(0, DropdownMenuItem(child: Text('Seleccione...'), value: ''));

  return items;
}

//Lista de categorías
List<DropdownMenuItem> itemsDropdownCategorias(BuildContext context) {
  List<DropdownMenuItem> items = [];

  items = context
      .watch<ListAppProvider>()
      .listApp['data']['listaCategorias']
      .map<DropdownMenuItem>((usuario) => DropdownMenuItem(
            child: Text(usuario['ca101nombre']),
            value: usuario['ca101cod_categoria'],
          ))
      .toList();
  items.insert(0, DropdownMenuItem(child: Text('Seleccione...'), value: ''));

  return items;
}

//Lista de Prioridades
List<DropdownMenuItem> itemsDropdownPrioridades(BuildContext context) {
  List<DropdownMenuItem> items = [];
  items.add(DropdownMenuItem(child: Text('Seleccione...'), value: ''));
  items.add(DropdownMenuItem(child: Text('Alto'), value: 'A'));
  items.add(DropdownMenuItem(child: Text('Medio'), value: 'M'));
  items.add(DropdownMenuItem(child: Text('Bajo'), value: 'B'));

  return items;
}

//Lista de Frecuencias
List<DropdownMenuItem> itemsDropdownFrecuencias(BuildContext context) {
  List<DropdownMenuItem> items = [];
  items.add(DropdownMenuItem(child: Text('No repetir'), value: 0));
  items.add(DropdownMenuItem(child: Text('Diario'), value: 1));
  items.add(DropdownMenuItem(child: Text('Semanal'), value: 8));
  items.add(DropdownMenuItem(child: Text('Quincenal'), value: 15));
  items.add(DropdownMenuItem(child: Text('Mensual'), value: 30));

  return items;
}

//Lista de días de la semana
List<DropdownMenuItem> itemsDropdownDiasSemana(BuildContext context) {
  List<DropdownMenuItem> items = [];
  items.add(DropdownMenuItem(child: Text('Seleccione...'), value: 0));
  items.add(DropdownMenuItem(child: Text('Lunes'), value: 1));
  items.add(DropdownMenuItem(child: Text('Martes'), value: 2));
  items.add(DropdownMenuItem(child: Text('Miércoles'), value: 3));
  items.add(DropdownMenuItem(child: Text('Jueves'), value: 4));
  items.add(DropdownMenuItem(child: Text('Viernes'), value: 5));
  items.add(DropdownMenuItem(child: Text('Sábado'), value: 6));
  items.add(DropdownMenuItem(child: Text('Doming'), value: 7));

  return items;
}

//Lista de días de la semana
List<DropdownMenuItem> itemsDropdownDiasMes(BuildContext context) {
  List<DropdownMenuItem> items = [];
  items.add(DropdownMenuItem(child: Text('Seleccione...'), value: 0));
  for (var i = 1; i < 32; i++) {
    items.add(DropdownMenuItem(child: Text('$i'), value: i));
  }

  return items;
}
