import 'package:rxdart/rxdart.dart';
import 'package:ventas_restobar/src/database/comanda_database.dart';
import 'package:ventas_restobar/src/database/detalle_comanda_temporal_database.dart';
import 'package:ventas_restobar/src/models/comanda_model.dart';
import 'package:ventas_restobar/src/models/detalle_comanda_model.dart';
import 'package:ventas_restobar/src/models/detalle_comanda_temporal_model.dart';

class ComandaBloc {
  final _comandaDatabase = ComandaDatabase();
  final _comandaTemporalDatabase = DetalleComandaTemporalDatabase();

  final _comandaPorMesaController = BehaviorSubject<List<ComandaModel>>();
  final _comandaTemporalController = BehaviorSubject<List<DetalleComandaTemporalModel>>();

  Stream<List<ComandaModel>> get comandaPorMesaStream => _comandaPorMesaController.stream;
  Stream<List<DetalleComandaTemporalModel>> get comandaTemporalStream => _comandaTemporalController.stream;

  void obtenerComandaPorMesa(String idMesa) async {
    _comandaPorMesaController.sink.add([]);
    _comandaPorMesaController.sink.add(await _obtenerComandaMesas(idMesa));
  }

  Future<List<ComandaModel>> _obtenerComandaMesas(String idMesa) async {
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

  void obtenerComandaTemporal(String idMesa) async {
    _comandaTemporalController.sink.add([]);
    _comandaTemporalController.sink.add(await _comandaTemporalDatabase.obtenerDetalleComandaPorIdMesa(idMesa));
  }

  void dispose() {
    _comandaPorMesaController.close();
    _comandaTemporalController.close();
  }
}
