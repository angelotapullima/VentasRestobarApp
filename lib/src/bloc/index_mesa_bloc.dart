import 'package:flutter/cupertino.dart';

enum EnumIndex { mesas, productos, detalle }

class IndexMesasBlocListener with ChangeNotifier {
  IndexMesasBlocListener() {
    _init();
  }
  void _init() {}

  ValueNotifier<EnumIndex> _vista = ValueNotifier(EnumIndex.mesas);
  ValueNotifier<EnumIndex> get vista => this._vista;

  ValueNotifier<String> _select = ValueNotifier('Salón principal');
  ValueNotifier<String> get select => this._select;

  void changeToMesas() {
    _vista.value = EnumIndex.mesas;
    notifyListeners();
  }

  void changeToProductos() {
    _vista.value = EnumIndex.productos;
    notifyListeners();
  }

  void channgeToDetalle() {
    _vista.value = EnumIndex.detalle;
    notifyListeners();
  }

  void changeSelect(String v) {
    _select.value = v;
    notifyListeners();
  }
}
