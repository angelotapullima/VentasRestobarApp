import 'package:ventas_restobar/src/database/comanda_database.dart';
import 'package:ventas_restobar/src/database/mesa_database.dart';
import 'package:ventas_restobar/src/models/comanda_model.dart';
import 'package:ventas_restobar/src/models/detalle_comanda_model.dart';
import 'package:ventas_restobar/src/models/mesas_model.dart';
import 'package:ventas_restobar/src/models/result_api_model.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class MesasApi {
  final _prefs = Preferences();
  final _mesaDatabase = MesaDatabase();
  final _comandaDatabase = ComandaDatabase();

  Future<bool> obtenerMesasPorNegocio() async {
    try {
      final url = Uri.parse('${_prefs.url}/api/Mesa/listar_mesas');

      final resp = await http.post(
        url,
        body: {
          'tn': _prefs.token,
          'id_sucursal': _prefs.tiendaId,
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);

      print(resp.body.toString());

      if (decodedData['result']["code"] == 1) {
        await _mesaDatabase.deleteMesas();
        for (var i = 0; i < decodedData['result']["datos"].length; i++) {
          MesaModel mesa = MesaModel();
          mesa.idMesa = decodedData['result']["datos"][i]['id_mesa'];
          mesa.idNegocio = decodedData['result']["datos"][i]['id_sucursal'];
          mesa.mesaNombre = decodedData['result']["datos"][i]['mesa_nombre'];
          mesa.mesaCapacidad = decodedData['result']["datos"][i]['mesa_capacidad'];
          mesa.mesaEstado = decodedData['result']["datos"][i]['mesa_estado'];
          mesa.mesaEstadoAtencion = decodedData['result']["datos"][i]['mesa_estado_atencion'];
          await _mesaDatabase.insertarMesa(mesa);

          if (decodedData['result']["datos"][i]['mesa_estado_atencion'] == '1' && decodedData['result']["datos"][i]['comanda'].length > 0) {
            ComandaModel comanda = ComandaModel();

            comanda.idMesa = decodedData['result']["datos"][i]['id_mesa'];
            comanda.idComanda = decodedData['result']["datos"][i]['comanda'][0]["id_comanda"];
            comanda.fecha = decodedData['result']["datos"][i]['comanda'][0]["comanda_fecha_registro"];
            comanda.total = decodedData['result']["datos"][i]['comanda'][0]["comanda_total"];
            comanda.estado = decodedData['result']["datos"][i]['comanda'][0]["comanda_estado"];

            for (var x = 0; x < decodedData['result']["datos"][i]['comanda'].length; x++) {
              var detalle = decodedData['result']["datos"][i]['comanda'][x];
              DetalleComandaModel detalleComanda = DetalleComandaModel();
              detalleComanda.idDetalle = detalle["id_comanda_detalle"];
              detalleComanda.idComanda = detalle["id_comanda"];
              detalleComanda.idProducto = detalle["id_producto"];
              detalleComanda.cantidad = detalle["comanda_detalle_cantidad"];
              detalleComanda.subtotal = detalle["producto_precio_venta"];
              detalleComanda.totalDetalle = detalle["comanda_detalle_total"];
              detalleComanda.observaciones = detalle["comanda_detalle_observacion"];
              detalleComanda.estado = detalle["comanda_detalle_estado"];
              detalleComanda.llevar = detalle["comanda_detalle_despacho"];
              detalleComanda.nombreProducto = detalle["producto_nombre"];
              detalleComanda.fotoProducto = detalle["producto_foto"];

              await _comandaDatabase.insertarDetalleComanda(detalleComanda);
            }

            await _comandaDatabase.insertarComanda(comanda);
          } else {
            await _comandaDatabase.deleteComandaPorIdMesa(decodedData['result']["datos"][i]['id_mesa']);
          }
        }
        return true;
      } else {
        await _mesaDatabase.deleteMesas();
        return false;
      }
    } catch (e) {
      await _mesaDatabase.deleteMesas();
      print('ERROR EXCEPCION: $e');
      return false;
    }
  }

  Future<ResultApiModel> cambiarMesa(String idMesaOrigen, String idMesaDestino) async {
    final ResultApiModel result = ResultApiModel();
    try {
      final _listaComandaMesa = await _comandaDatabase.obtenerComandaPorIdMesa(idMesaOrigen);

      if (_listaComandaMesa.length > 0) {
        final url = Uri.parse('${_prefs.url}/api/Pedido/cambiar_mesa');

        final resp = await http.post(
          url,
          body: {
            'tn': _prefs.token,
            'id_mesa': idMesaOrigen,
            'id_mesa_nuevo': idMesaDestino,
            'id_comanda': _listaComandaMesa[0].idComanda,
            'app': 'true',
          },
        );

        final decodedData = json.decode(resp.body);
        result.code = decodedData['result']["code"];

        if (decodedData['result']["code"] == 1) {
          result.message = 'Ok';
        } else {
          result.message = 'Ocurrió un error';
        }

        return result;
      } else {
        result.code = 2;
        result.message = 'Ocurrió un error';
        return result;
      }
    } catch (e) {
      result.code = 2;
      result.message = 'Ocurrió un error';
      return result;
    }
  }

  Future<ResultApiModel> limpiarMesa(String idMesa) async {
    final ResultApiModel result = ResultApiModel();
    try {
      final url = Uri.parse('${_prefs.url}/api/Pedido/habilitar_mesa');

      final resp = await http.post(
        url,
        body: {
          'tn': _prefs.token,
          'id_mesa': idMesa,
          'estado': '0',
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);
      result.code = decodedData['result']["code"];

      if (decodedData['result']["code"] == 1) {
        result.message = 'Ok';
      } else {
        result.message = 'Ocurrió un error';
      }

      return result;
    } catch (e) {
      result.code = 2;
      result.message = 'Ocurrió un error';
      return result;
    }
  }
}
