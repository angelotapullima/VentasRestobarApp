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

  Stream<List<MesaModel>> get mesasStream => _mesasNegocioController.stream;
  Stream<List<MesaModel>> get mesasSalonStream => _mesasNegocioSalonController.stream;

  void obtenerMesasNegocio(int lugar) async {
    if (lugar == 1) {
      _mesasNegocioController.sink.add(await _mesasDatabase.obtenerMesasPorNegocioSalon(_prefs.tiendaId));
      await _mesasApi.obtenerMesasPorNegocio();
      _mesasNegocioController.sink.add(await _mesasDatabase.obtenerMesasPorNegocioSalon(_prefs.tiendaId));
    } else {
      _mesasNegocioController.sink.add(await _mesasDatabase.obtenerMesasPorNegocioBarra(_prefs.tiendaId));
      await _mesasApi.obtenerMesasPorNegocio();
      _mesasNegocioController.sink.add(await _mesasDatabase.obtenerMesasPorNegocioBarra(_prefs.tiendaId));
    }
  }

  dispose() {
    _mesasNegocioController?.close();
    _mesasNegocioSalonController?.close();
  }
}
