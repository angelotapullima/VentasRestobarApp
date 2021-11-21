import 'package:ventas_restobar/src/database/mesa_database.dart';
import 'package:ventas_restobar/src/models/mesas_model.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';
import 'package:ventas_restobar/src/utils/constants.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class MesasApi {
  final _prefs = Preferences();
  final _mesaDatabase = MesaDatabase();

  Future<bool> obtenerMesasPorNegocio() async {
    try {
      final url = Uri.parse('$apiBaseURL/ventas_app/api/Mesa/listar_mesas');

      final resp = await http.post(
        url,
        body: {
          'tn': _prefs.token,
          'id_sucursal': _prefs.tiendaId,
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);

      if (decodedData['result']["code"] == 1) {
        for (var i = 0; i < decodedData['result']["datos"].length; i++) {
          MesaModel mesa = MesaModel();
          mesa.idMesa = decodedData['result']["datos"][i]['id_mesa'];
          mesa.idNegocio = decodedData['result']["datos"][i]['id_sucursal'];
          mesa.mesaNombre = decodedData['result']["datos"][i]['mesa_nombre'];
          mesa.mesaCapacidad = decodedData['result']["datos"][i]['mesa_capacidad'];
          mesa.mesaEstado = decodedData['result']["datos"][i]['mesa_estado'];
          mesa.mesaEstadoAtencion = decodedData['result']["datos"][i]['mesa_estado_atencion'];
          await _mesaDatabase.insertarMesa(mesa);

          // if (decodedData['result'][i]["pedido"]["id_pedido"] != 0 && decodedData['result'][i]['mesa_estado'] == '2') {
          //   PedidoModel pedido = PedidoModel();

          //   pedido.idPedido = decodedData['result'][i]["pedido"]["id_pedido"];
          //   pedido.idMesa = decodedData['result'][i]['id_mesa'];
          //   pedido.total = decodedData['result'][i]["pedido"]["pedido_total"];

          //   if (decodedData['result'][i]["pedido"]["detalle"].length > 0) {
          //     pedido.estado = decodedData['result'][i]["pedido"]["detalle"][0]["pedido_estado"];
          //     pedido.fecha = decodedData['result'][i]["pedido"]["detalle"][0]["pedido_datetime"];
          //     for (var x = 0; x < decodedData['result'][i]["pedido"]["detalle"].length; x++) {
          //       var detalle = decodedData['result'][i]["pedido"]["detalle"][x];
          //       DetallePedidoModel detallePedido = DetallePedidoModel();
          //       detallePedido.idDetalle = detalle["id_pedido_detalle"];
          //       detallePedido.idPedido = detalle["id_pedido"];
          //       detallePedido.idProducto = detalle["id_producto"];
          //       detallePedido.cantidad = detalle["pedido_detalle_cantidad"];
          //       detallePedido.subtotal = detalle["pedido_detalle_subtotal"];
          //       detallePedido.totalDetalle = detalle["pedido_detalle_subtotal"];
          //       detallePedido.observaciones = detalle["pedido_detalle_observaciones"].toString();
          //       detallePedido.estado = detalle["pedido_detalle_estado"];
          //       detallePedido.llevar = detalle["pedido_detalle_llevar"];
          //       detallePedido.nombreProducto = detalle["producto_nombre"];
          //       detallePedido.fotoProducto = detalle["producto_foto"];

          //       await _pedidosDatabase.insertarDetallePedido(detallePedido);
          //     }

          //     await _pedidosDatabase.insertarPedido(pedido);
          //   }
          // } else {
          //   await _pedidosDatabase.deletePedidoPorIdMesa(decodedData['result'][i]['id_mesa']);
          // }
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('ERROR EXCEPCION: $e');
      return false;
    }
  }
}
