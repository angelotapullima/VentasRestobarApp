import 'package:ventas_restobar/src/database/comanda_database.dart';
import 'package:ventas_restobar/src/database/detalle_comanda_temporal_database.dart';
import 'package:ventas_restobar/src/models/detalle_comanda_model.dart';
import 'package:ventas_restobar/src/models/productos_familia_model.dart';
import 'package:ventas_restobar/src/models/result_api_model.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';
import 'package:ventas_restobar/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ComandaApi {
  final _preferences = Preferences();
  final _comandaTemporalDatabase = DetalleComandaTemporalDatabase();
  Future<ResultApiModel> generarComanda(String idMesa) async {
    final ResultApiModel respuesta = ResultApiModel();
    try {
      String contenido = '';
      double total = 0;

      final _listaDetalleTemporal = await _comandaTemporalDatabase.obtenerDetalleComandaPorIdMesa(idMesa);

      if (_listaDetalleTemporal.length > 0) {
        for (var i = 0; i < _listaDetalleTemporal.length; i++) {
          contenido +=
              '${_listaDetalleTemporal[i].idProducto}-.-.${_listaDetalleTemporal[i].nombreProducto}-.-.${_listaDetalleTemporal[i].subtotal}-.-.${_listaDetalleTemporal[i].cantidad}-.-.${_listaDetalleTemporal[i].despacho}-.-.${_listaDetalleTemporal[i].observaciones}-.-.${_listaDetalleTemporal[i].totalDetalle}/./.';
          total = total + double.parse(_listaDetalleTemporal[i].totalDetalle);
        }

        final url = Uri.parse('$apiBaseURL/api/Pedido/guardar_comanda');

        final resp = await http.post(
          url,
          body: {
            'tn': _preferences.token,
            'id_mesa': idMesa,
            'comanda_total': '$total',
            'comanda_cantidad_personas': '-',
            'contenido': contenido,
            'app': 'true',
          },
        );

        if (resp.statusCode == 401) {
          respuesta.code = 3;
          respuesta.message = 'Problemas de conexión';

          return respuesta;
        }

        final decodedData = json.decode(resp.body);
        if (decodedData['result']["code"] == 1) {
          _comandaTemporalDatabase.deleteComandaPorIdMesa(idMesa);
          respuesta.code = decodedData['result']["code"];
          respuesta.message = 'Ok';
        } else {
          respuesta.code = decodedData['result']["code"];
          respuesta.message = 'Ocurrió un error';
        }

        return respuesta;
      } else {
        respuesta.code = 2;
        respuesta.message = 'Ocurrió un error';
        return respuesta;
      }
    } catch (e) {
      respuesta.code = 2;
      respuesta.message = 'Ocurrió un error';
      return respuesta;
    }
  }

  Future<ResultApiModel> agregarProductoAComanda(
      ProductosFamiliaModel producto, int cantidad, String precioTotal, String despacho, String observaciones) async {
    final ResultApiModel respuesta = ResultApiModel();
    try {
      String contenido =
          '${producto.idProducto}-.-.${producto.productoNombre}-.-.${producto.productoPrecio}-.-.$cantidad-.-.$despacho-.-.$observaciones-.-.$precioTotal/./.';

      final url = Uri.parse('$apiBaseURL/api/Pedido/guardar_comanda_nuevo');

      final resp = await http.post(
        url,
        body: {
          'tn': _preferences.token,
          'id_comanda': _preferences.idEnviarEnComanda,
          'contenido_pedido': contenido,
          'app': 'true',
        },
      );

      if (resp.statusCode == 401) {
        respuesta.code = 3;
        respuesta.message = 'Problemas de conexión';

        return respuesta;
      }

      final decodedData = json.decode(resp.body);
      print(decodedData);
      if (decodedData['result']["code"] == 1) {
        respuesta.code = decodedData['result']["code"];
        respuesta.message = 'Ok';
      } else {
        respuesta.code = decodedData['result']["code"];
        respuesta.message = 'Ocurrió un error';
      }

      return respuesta;
    } catch (e) {
      respuesta.code = 2;
      respuesta.message = 'Ocurrió un error';
      return respuesta;
    }
  }

  Future<ResultApiModel> eliminarProductoAComanda(DetalleComandaModel detalle, String contra, String motivo) async {
    final ResultApiModel respuesta = ResultApiModel();
    try {
      final url = Uri.parse('$apiBaseURL/api/Pedido/eliminar_comanda_detalle');

      final resp = await http.post(
        url,
        body: {
          'tn': _preferences.token,
          'id_comanda': detalle.idComanda,
          'password': contra,
          'id_comanda_detalle': detalle.idDetalle,
          'comanda_detalle_eliminacion': motivo,
          'id_mesa': _preferences.idMesa,
          'app': 'true',
        },
      );

      if (resp.statusCode == 401) {
        respuesta.code = 3;
        respuesta.message = 'Problemas de conexión';

        return respuesta;
      }

      final decodedData = json.decode(resp.body);
      print(decodedData);
      if (decodedData['result']["code"] == 1) {
        final _comandaDatabase = ComandaDatabase();
        await _comandaDatabase.deleteDetalleComandaPorIdDetalle(detalle.idDetalle);
        respuesta.code = decodedData['result']["code"];
        respuesta.message = 'Ok';
      } else {
        respuesta.code = decodedData['result']["code"];
        respuesta.message = 'Ocurrió un error';
      }

      return respuesta;
    } catch (e) {
      respuesta.code = 2;
      respuesta.message = 'Ocurrió un error';
      return respuesta;
    }
  }
}
