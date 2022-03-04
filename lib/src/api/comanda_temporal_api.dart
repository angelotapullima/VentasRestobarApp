import 'package:ventas_restobar/src/database/detalle_comanda_temporal_database.dart';
import 'package:ventas_restobar/src/models/detalle_comanda_temporal_model.dart';
import 'package:ventas_restobar/src/models/productos_familia_model.dart';
import 'package:ventas_restobar/src/models/result_api_model.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';

class ComandaTemporalApi {
  final _preferences = Preferences();
  final _comandaTemporalDatabase = DetalleComandaTemporalDatabase();

  Future<ResultApiModel> guardarDetalleTemporal(
      ProductosFamiliaModel producto, int cantidad, String precioTotal, String despacho, String observaciones) async {
    final ResultApiModel result = ResultApiModel();

    try {
      final _listProducto =
          await _comandaTemporalDatabase.obtenerDetalleComandaPorIdProducto(producto.idProducto!, despacho, _preferences.idEnviarEnComanda);
      if (_listProducto.length > 0) {
        DetalleComandaTemporalModel detalle = DetalleComandaTemporalModel();
        detalle.id = _listProducto[0].id;
        detalle.idMesa = _preferences.idEnviarEnComanda;
        detalle.nombreProducto = producto.productoNombre;
        detalle.idProducto = producto.idProducto;
        detalle.fotoProducto = producto.productoFoto;
        detalle.cantidad = (cantidad + int.parse(_listProducto[0].cantidad!)).toString();

        detalle.subtotal = producto.productoPrecio;
        detalle.totalDetalle = (double.parse(precioTotal) + double.parse(_listProducto[0].totalDetalle!)).toStringAsFixed(2);
        detalle.observaciones = observaciones;
        detalle.despacho = despacho;
        final res = await _comandaTemporalDatabase.updateDetallePorIdComandaDetalle(detalle);
        if (res > 0) {
          result.code = 1;
          result.message = '';
        } else {
          result.code = 3;
          result.message = 'Ocurrió un error';
        }
      } else {
        DetalleComandaTemporalModel detalle = DetalleComandaTemporalModel();
        detalle.idMesa = _preferences.idEnviarEnComanda;
        detalle.nombreProducto = producto.productoNombre;
        detalle.idProducto = producto.idProducto;
        detalle.fotoProducto = producto.productoFoto;
        detalle.cantidad = cantidad.toString();
        detalle.subtotal = producto.productoPrecio;
        detalle.totalDetalle = precioTotal;
        detalle.observaciones = observaciones;
        detalle.despacho = despacho;
        final res = await _comandaTemporalDatabase.insertarDetalleComandaTemporal(detalle);
        if (res > 0) {
          result.code = 1;
          result.message = '';
        } else {
          result.code = 3;
          result.message = 'Ocurrió un error';
        }
      }

      return result;
    } catch (e) {
      result.code = 3;
      result.message = 'Ocurrió un error';
      return result;
    }
  }

  Future<ResultApiModel> updateDetalle(DetalleComandaTemporalModel dato, int cantidad) async {
    final ResultApiModel result = ResultApiModel();
    try {
      if (int.parse(dato.cantidad!) == 1 && cantidad < 0) {
        final res = await _comandaTemporalDatabase.deleteDetalleTemporalPorId(dato.id!);
        if (res > 0) {
          result.code = 1;
          result.message = 'Operación exitosa';
          return result;
        } else {
          result.code = 3;
          result.message = 'Ocurrió un error';
          return result;
        }
      } else {
        int newCant = int.parse(dato.cantidad!) + cantidad;
        double total = double.parse(dato.totalDetalle!) + (cantidad * double.parse(dato.subtotal!));
        DetalleComandaTemporalModel detalle = DetalleComandaTemporalModel();
        detalle.id = dato.id;
        detalle.idMesa = dato.idMesa;
        detalle.nombreProducto = dato.nombreProducto;
        detalle.idProducto = dato.idProducto;
        detalle.fotoProducto = dato.fotoProducto;
        detalle.cantidad = newCant.toString();
        detalle.subtotal = dato.subtotal;
        detalle.totalDetalle = total.toStringAsFixed(2);
        detalle.observaciones = dato.observaciones;
        detalle.despacho = dato.despacho;
        final res = await _comandaTemporalDatabase.updateDetallePorIdComandaDetalle(detalle);
        if (res > 0) {
          result.code = 1;
          result.message = '';
        } else {
          result.code = 3;
          result.message = 'Ocurrió un error';
        }
        return result;
      }
    } catch (e) {
      result.code = 3;
      result.message = 'Ocurrió un error';
      return result;
    }
  }
}
