import 'package:flutter/material.dart';

enum EnumIndex { mesas, pedidos, asistencia }

class IndexBlocListener with ChangeNotifier {
  // int index = 0;
  // //final preferences = Preferences();

  // void changeIndex(int i) {
  //   print('index $i');
  //   index = i;
  //   notifyListeners();
  // }

  ValueNotifier<EnumIndex> _page = ValueNotifier(EnumIndex.mesas);
  ValueNotifier<EnumIndex> get page => this._page;

  ValueNotifier<bool> _cargandoEnvio = ValueNotifier(false);
  ValueNotifier<bool> get cargandoEnvio => this._cargandoEnvio;

  ValueNotifier<bool> _cargandoDisgregacion = ValueNotifier(false);
  ValueNotifier<bool> get cargandoDisgregacion => this._cargandoDisgregacion;

  IndexBlocListener() {
    _init();
  }
  void _init() {}

  void changeToMesa(BuildContext context) {
    _page.value = EnumIndex.mesas;
    notifyListeners();
  }

  void changeToMesa2(BuildContext context) {
    _page.value = EnumIndex.mesas;
    notifyListeners();
  }

  void changeToPedidos() {
    _page.value = EnumIndex.pedidos;
    notifyListeners();
  }

  void changeToAsistencia() {
    _page.value = EnumIndex.asistencia;
    notifyListeners();
  }

  void changeCargandoTrue() {
    _cargandoEnvio.value = true;
    notifyListeners();
  }

  void changeCargandoFalse() {
    _cargandoEnvio.value = false;
    notifyListeners();
  }

  void changeCargandoTrueDisgregacion() {
    _cargandoDisgregacion.value = true;
    notifyListeners();
  }

  void changeCargandoFalseDisgregacion() {
    _cargandoDisgregacion.value = false;
    notifyListeners();
  }
}
