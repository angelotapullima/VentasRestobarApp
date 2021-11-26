import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

void showToast2(String texto, Color color) {
  Fluttertoast.showToast(msg: "$texto", toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3, backgroundColor: color, textColor: Colors.white);
}

obtenerFechaActualApi() {
  var date = DateTime.now();
  final DateFormat fecha = new DateFormat('dd/MM/yyyy');

  return fecha.format(date);
}

obtenerHoraActualApi() {
  var date = DateTime.now();
  final DateFormat fecha = new DateFormat('H:mm');

  return fecha.format(date);
}
