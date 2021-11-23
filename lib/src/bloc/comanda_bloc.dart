import 'package:rxdart/rxdart.dart';
import 'package:ventas_restobar/src/database/comanda_database.dart';
import 'package:ventas_restobar/src/models/comanda_model.dart';
import 'package:ventas_restobar/src/models/detalle_comanda_model.dart';

class ComandaBloc {
  final _comandaDatabase = ComandaDatabase();
  final _comandaPorMesaController = BehaviorSubject<List<ComandaModel>>();

  Stream<List<ComandaModel>> get comandaPorMesaStream => _comandaPorMesaController.stream;

  void obtenerComandaPorMesa(String idMesa) async {
    _comandaPorMesaController.sink.add(null);
    _comandaPorMesaController.sink.add(await obtenerComandaMesas(idMesa));
  }

  Future<List<ComandaModel>> obtenerComandaMesas(String idMesa) async {
    final List<ComandaModel> listaComandaGeneral = [];

    final _listaComandaMesa = await _comandaDatabase.obtenerComandaPorIdMesa(idMesa);

    if (_listaComandaMesa.length > 0) {
      ComandaModel comanda = ComandaModel();
      comanda.idComanda = _listaComandaMesa[0].idComanda;
      comanda.idMesa = _listaComandaMesa[0].idMesa;
      comanda.total = _listaComandaMesa[0].total;
      comanda.fecha = _listaComandaMesa[0].fecha;
      comanda.estado = _listaComandaMesa[0].estado;
      final List<DetalleComandaModel> listaDetalle = [];
      final _listaDetalleComanda = await _comandaDatabase.obtenerDetalleComandaPorIdComanda(_listaComandaMesa[0].idComanda);
      for (var i = 0; i < _listaDetalleComanda.length; i++) {
        listaDetalle.add(_listaDetalleComanda[i]);
      }
      comanda.detalleComanda = listaDetalle;
      listaComandaGeneral.add(comanda);
    }
    return listaComandaGeneral;
  }

  void dispose() {
    _comandaPorMesaController?.close();
  }
}
