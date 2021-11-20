import 'package:flutter/material.dart';
import 'package:ventas_restobar/src/bloc/familias_bloc.dart';
import 'package:ventas_restobar/src/bloc/mesas_bloc.dart';

//singleton para obtner una unica instancia del Bloc
class ProviderBloc extends InheritedWidget {
  static ProviderBloc _instancia;

  factory ProviderBloc({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderBloc._internal(key: key, child: child);
    }

    return _instancia;
  }

  final mesasBloc = MesasBloc();
  final familiasBloc = FamiliasBloc();

  ProviderBloc._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MesasBloc mesas(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderBloc>().mesasBloc;
  }

  static FamiliasBloc familias(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderBloc>().familiasBloc;
  }
}
