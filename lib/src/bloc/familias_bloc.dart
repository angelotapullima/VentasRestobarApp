import 'package:rxdart/rxdart.dart';
import 'package:ventas_restobar/src/api/familias_api.dart';
import 'package:ventas_restobar/src/database/familia_database.dart';
import 'package:ventas_restobar/src/models/familias_model.dart';

class FamiliasBloc {
  final _familiaApi = FamiliasApi();
  final _familiasDatabase = FamiliaDatabase();

  final _familiasController = BehaviorSubject<List<FamiliasModel>>();

  Stream<List<FamiliasModel>> get familiasStream => _familiasController.stream;

  void obtenerFamilias() async {
    _familiasController.sink.add(await _familiasDatabase.obtenerFamilias());
    await _familiaApi.obtenerFamilias();
    _familiasController.sink.add(await _familiasDatabase.obtenerFamilias());
  }

  void dispose() {
    _familiasController?.close();
  }
}
