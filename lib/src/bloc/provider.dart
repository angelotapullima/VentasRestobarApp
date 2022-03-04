import 'package:flutter/material.dart';
import 'package:ventas_restobar/src/bloc/comanda_bloc.dart';
import 'package:ventas_restobar/src/bloc/familias_bloc.dart';
import 'package:ventas_restobar/src/bloc/mesas_bloc.dart';
import 'package:ventas_restobar/src/bloc/productos_familia_bloc.dart';

//singleton para obtner una unica instancia del Bloc
class ProviderBloc extends InheritedWidget {
  final mesasBloc = MesasBloc();
  final familiasBloc = FamiliasBloc();
  final productosBloc = ProductosFamiliaBloc();
  final comandaBloc = ComandaBloc();

  ProviderBloc({required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MesasBloc mesas(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderBloc>()!.mesasBloc;
  }

  static FamiliasBloc familias(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderBloc>()!.familiasBloc;
  }

  static ProductosFamiliaBloc productos(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderBloc>()!.productosBloc;
  }

  static ComandaBloc comanda(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderBloc>()!.comandaBloc;
  }
}
