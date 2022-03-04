import 'package:ventas_restobar/src/models/result_api_model.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginApi {
  final _prefs = new Preferences();
  Future<ResultApiModel> login(String user, String pass) async {
    final ResultApiModel result = ResultApiModel();
    try {
      final url = Uri.parse('${_prefs.url}/api/Login/validar_sesion_app');

      final resp = await http.post(url, body: {
        'usuario_nickname': '$user',
        'usuario_contrasenha': '$pass',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      result.code = decodedData["result"]["code"];
      result.message = decodedData["result"]["message"];

      if (decodedData["result"]["code"] == 1) {
        var data = decodedData["data"];
        _prefs.idUsuarios = data["c_u"];
        _prefs.tokens = data["tn"];
        _prefs.nombresCompletoss= '${data["p_n"]} ${data["p_p"]} ${data["p_m"]}';
        _prefs.nombress = data["p_n"];
        //_prefs.codigoUsuario = data["c_p"];
        _prefs.apellidoPaternos = data["p_p"];
        _prefs.apellidoMaternos = data["p_m"];
        _prefs.tiendaIds = data["i_d"];
        _prefs.negocioNombres = data["n_n"];
        _prefs.negocioImagens = data["n_f"];
      }

      return result;
    } catch (e) {
      print(e);
      result.code = 2;
      result.message = 'Problema de conexión';
      return result;
    }
  }
}
