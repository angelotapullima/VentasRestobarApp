import 'package:ventas_restobar/src/database/familia_database.dart';
import 'package:ventas_restobar/src/models/familias_model.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ventas_restobar/src/utils/constants.dart';

class FamiliasApi {
  final _prefs = Preferences();
  final _familiasDatabase = FamiliaDatabase();

  Future<bool> obtenerFamilias() async {
    try {
      final url = Uri.parse('$apiBaseURL/ventas_app/api/Pedido/listar_familias_productos');

      final resp = await http.post(
        url,
        body: {
          'tn': _prefs.token,
          'id_sucursal': _prefs.tiendaId,
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);

      if (decodedData["result"]["code"] == 1) {
        for (var i = 0; i < decodedData["result"]["datos"].length; i++) {
          var data = decodedData["result"]["datos"][i];

          FamiliasModel familia = FamiliasModel();
          familia.idFamilia = data["id_producto_familia"];
          familia.familiaNombre = data["producto_familia_nombre"];
          familia.familiaEstado = data["producto_familia_estado"];

          await _familiasDatabase.insertarFamilia(familia);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
