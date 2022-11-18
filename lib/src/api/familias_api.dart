import 'package:ventas_restobar/src/database/acompanamiento_database.dart';
import 'package:ventas_restobar/src/database/detalle_acomp_database.dart';
import 'package:ventas_restobar/src/database/familia_database.dart';
import 'package:ventas_restobar/src/database/productos_familia_database.dart';
import 'package:ventas_restobar/src/models/acompanamiento_model.dart';
import 'package:ventas_restobar/src/models/detalle_acomp_model.dart';
import 'package:ventas_restobar/src/models/familias_model.dart';
import 'package:ventas_restobar/src/models/productos_familia_model.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class FamiliasApi {
  final _prefs = Preferences();
  final _familiasDatabase = FamiliaDatabase();
  final _productosDatabase = ProductosFamiliaDatabase();
  final _acompDB = AcompanamientoDatabase();
  final _detalleAcompDB = DetalleAcompDatabase();

  Future<bool> obtenerFamilias() async {
    try {
      final url = Uri.parse('${_prefs.url}/api/Pedido/listar_familias_productos');

      final resp = await http.post(
        url,
        body: {
          'tn': _prefs.token,
          'id_sucursal': _prefs.tiendaId,
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);
      print(decodedData);

      if (decodedData["result"]["code"] == 1) {
        for (var i = 0; i < decodedData["result"]["datos"].length; i++) {
          var data = decodedData["result"]["datos"][i];

          FamiliasModel familia = FamiliasModel();
          familia.idFamilia = data["id_producto_familia"];
          familia.familiaNombre = data["producto_familia_nombre"];
          familia.familiaEstado = data["producto_familia_estado"];

          await _familiasDatabase.insertarFamilia(familia);
          //TODO Fiztcarraldo
          // for (var x = 0; x < data["productos"].length; x++) {
          //   var data2 = data["productos"][x];

          //   // for (var x = 0; x < data["familias"].length; x++) {
          //   //   var data2 = data["familias"][x];

          //   ProductosFamiliaModel producto = ProductosFamiliaModel();
          //   producto.idProducto = data2["id_producto"];
          //   producto.idFamilia = data2["id_producto_familia"];
          //   producto.idReceta = data2["id_receta"];
          //   producto.productoNombre = data2["producto_nombre"];
          //   producto.productoDescripcion = data2["producto_descripcion"];
          //   producto.productoFoto = data2["producto_foto"];
          //   producto.productoPrecio = data2["producto_precio_venta"];
          //   producto.productoEstado = data2["producto_estado"];
          //   await _productosDatabase.insertarProductoFamilia(producto);

          //   // // TODO Insertar para Fitzcarraldo

          //   for (var y = 0; y < data2["acompanhamientos"].length; y++) {
          //     var datito = data2["acompanhamientos"][y];
          //     final acomp = AcompanamientoModel();

          //     acomp.id = datito["id_acompanhamiento"];
          //     acomp.idProducto = data2["id_producto"];
          //     acomp.texto = datito["acompanamiento_texto"];
          //     acomp.estado = datito["acompanamiento_estado"];
          //     await _acompDB.insertarAcomp(acomp);

          //     for (var z = 0; z < datito["buscar_detalle"].length; z++) {
          //       var datitos = datito["buscar_detalle"][z];
          //       final detalle = DetalleAcompModel();

          //       detalle.id = datitos["id_acompa_detalle"];
          //       detalle.idAcomp = datitos["id_acompanamiento"];
          //       detalle.texto = datitos["detalle_texto"];
          //       detalle.estado = datitos["detalle_estado"];
          //       detalle.valueCheck = '0';

          //       await _detalleAcompDB.insertarDetalleAcomp(detalle);
          //     }
          //   }
          //   // //****************************/
          // }
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
