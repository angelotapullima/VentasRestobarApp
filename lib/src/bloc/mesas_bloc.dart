import 'package:rxdart/rxdart.dart';
import 'package:ventas_restobar/src/api/mesas_api.dart';
import 'package:ventas_restobar/src/database/mesa_database.dart';
import 'package:ventas_restobar/src/models/mesas_model.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';

class MesasBloc {
  final _prefs = Preferences();
  final _mesasApi = MesasApi();
  final _mesasDatabase = MesaDatabase();

  final _mesasNegocioController = BehaviorSubject<List<MesaModel>>();
  final _mesasNegocioSalonController = BehaviorSubject<List<MesaModel>>();
  final _mesasNegocioBarraController = BehaviorSubject<List<MesaModel>>();
  final _mesaDetalleController = BehaviorSubject<List<MesaModel>>();
  //final _vistaSelect = BehaviorSubject<int>();

  Stream<List<MesaModel>> get mesasStream => _mesasNegocioController.stream;
  Stream<List<MesaModel>> get mesasSalonStream => _mesasNegocioSalonController.stream;
  Stream<List<MesaModel>> get mesasBarraStream => _mesasNegocioBarraController.stream;
  Stream<List<MesaModel>> get mesDetalleStream => _mesaDetalleController.stream;
  // Stream<int> get selectStream => _vistaSelect.stream;

  // Function(int) get changeSelect => _vistaSelect.sink.add;

  // int get select => _vistaSelect.value;

  void obtenerMesasNegocio(int lugar) async {
    if (lugar == 1) {
      _mesasNegocioBarraController.sink.add([]);
      _mesasNegocioSalonController.sink.add(await _mesasDatabase.obtenerMesasPorNegocioSalon(_prefs.tiendaId));
      await _mesasApi.obtenerMesasPorNegocio();
      _mesasNegocioSalonController.sink.add(await _mesasDatabase.obtenerMesasPorNegocioSalon(_prefs.tiendaId));
    } else {
      _mesasNegocioSalonController.sink.add([]);
      _mesasNegocioBarraController.sink.add(await _mesasDatabase.obtenerMesasPorNegocioBarra(_prefs.tiendaId));
      await _mesasApi.obtenerMesasPorNegocio();
      _mesasNegocioBarraController.sink.add(await _mesasDatabase.obtenerMesasPorNegocioBarra(_prefs.tiendaId));
    }
  }

  void obtenerDetalleMesa(String idMesa) async {
    print('Entré');
    _mesaDetalleController.sink.add(await _mesasDatabase.obtenerMesaPorIdMesa(idMesa));
  }

  Future<int> updateMesas(int lugar) async {
    await _mesasApi.obtenerMesasPorNegocio();
    if (lugar == 1) {
      //_mesasNegocioSalonController.sink.add(null);
      _mesasNegocioSalonController.sink.add(await _mesasDatabase.obtenerMesasPorNegocioSalon(_prefs.tiendaId));
    } else {
      //_mesasNegocioBarraController.sink.add(null);
      _mesasNegocioBarraController.sink.add(await _mesasDatabase.obtenerMesasPorNegocioBarra(_prefs.tiendaId));
    }
    return 0;
  }

  void limpiarMesa() async {
    _mesaDetalleController.sink.add([]);
  }

  void obtenerMesasDisponibles() async {
    _mesasNegocioController.sink.add(await _mesasDatabase.obtenerMesasDisponibles(_prefs.tiendaId));
  }

  dispose() {
    _mesasNegocioController.close();
    _mesasNegocioSalonController.close();
    _mesaDetalleController.close();
    _mesasNegocioBarraController.close();
    //_vistaSelect?.close();
  }
}
