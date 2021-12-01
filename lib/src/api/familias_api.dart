import 'package:ventas_restobar/src/database/familia_database.dart';
import 'package:ventas_restobar/src/database/productos_familia_database.dart';
import 'package:ventas_restobar/src/models/familias_model.dart';
import 'package:ventas_restobar/src/models/productos_familia_model.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class FamiliasApi {
  final _prefs = Preferences();
  final _familiasDatabase = FamiliaDatabase();
  final _productosDatabase = ProductosFamiliaDatabase();

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

      if (decodedData["result"]["code"] == 1) {
        for (var i = 0; i < decodedData["result"]["datos"].length; i++) {
          var data = decodedData["result"]["datos"][i];

          FamiliasModel familia = FamiliasModel();
          familia.idFamilia = data["id_producto_familia"];
          familia.familiaNombre = data["producto_familia_nombre"];
          familia.familiaEstado = data["producto_familia_estado"];

          await _familiasDatabase.insertarFamilia(familia);

          for (var x = 0; x < data["familias"].length; x++) {
            var data2 = data["familias"][x];

            ProductosFamiliaModel producto = ProductosFamiliaModel();
            producto.idProducto = data2["id_producto"];
            producto.idFamilia = data2["id_producto_familia"];
            producto.idReceta = data2["id_receta"];
            producto.productoNombre = data2["producto_nombre"];
            producto.productoDescripcion = data2["producto_descripcion"];
            producto.productoFoto = data2["producto_foto"];
            producto.productoPrecio = data2["producto_precio_venta"];
            producto.productoEstado = data2["producto_estado"];
            await _productosDatabase.insertarProductoFamilia(producto);
          }
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
