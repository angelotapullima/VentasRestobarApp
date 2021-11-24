import 'package:ventas_restobar/src/database/database_provider.dart';
import 'package:ventas_restobar/src/models/detalle_comanda_temporal_model.dart';

class DetalleComandaTemporalDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarDetalleComandaTemporal(DetalleComandaTemporalModel detalleComanda) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO DetalleComandaTemporal(idMesa,idProducto,nombreProducto,fotoProducto,cantidad,subtotal,totalDetalle,observaciones,estado,despacho) "
          "VALUES ('${detalleComanda.idMesa}','${detalleComanda.idProducto}','${detalleComanda.nombreProducto}','${detalleComanda.fotoProducto}','${detalleComanda.cantidad}','${detalleComanda.subtotal}','${detalleComanda.totalDetalle}','${detalleComanda.observaciones}','${detalleComanda.estado}','${detalleComanda.despacho}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<DetalleComandaTemporalModel>> obtenerDetalleComandaPorIdMesa(String idMesa) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM DetalleComandaTemporal WHERE idMesa='$idMesa'");
    List<DetalleComandaTemporalModel> list = res.isNotEmpty ? res.map((c) => DetalleComandaTemporalModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<DetalleComandaTemporalModel>> obtenerDetalleComandaPorIdProducto(String idProducto, String despacho) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM DetalleComandaTemporal WHERE idProducto='$idProducto' AND despacho='$despacho'  ");

    List<DetalleComandaTemporalModel> list = res.isNotEmpty ? res.map((c) => DetalleComandaTemporalModel.fromJson(c)).toList() : [];
    return list;
  }

  updateDetallePorIdComandaDetalle(DetalleComandaTemporalModel detalle) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawUpdate("UPDATE DetalleComandaTemporal SET idMesa='${detalle.idMesa}',"
          "idProducto='${detalle.idProducto}',"
          "nombreProducto='${detalle.nombreProducto}',"
          "cantidad='${detalle.cantidad}',"
          "subtotal='${detalle.subtotal}',"
          "totalDetalle='${detalle.totalDetalle}',"
          "observaciones='${detalle.observaciones}',"
          "despacho='${detalle.despacho}',"
          "estado='${detalle.estado}' WHERE id='${detalle.id}'");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  deleteDetalleComanda() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM DetalleComandaTemporal');

    return res;
  }

  deleteComandaPorIdMesa(String idMesa) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM DetalleComandaTemporal WHERE idMesa='$idMesa'");

    return res;
  }

  deleteDetalleTemporalPorId(String id) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM DetalleComandaTemporal WHERE id='$id'");

    return res;
  }
}
