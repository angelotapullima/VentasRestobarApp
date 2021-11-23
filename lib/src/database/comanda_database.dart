import 'package:ventas_restobar/src/database/database_provider.dart';
import 'package:ventas_restobar/src/models/comanda_model.dart';
import 'package:ventas_restobar/src/models/detalle_comanda_model.dart';

class ComandaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarComanda(ComandaModel comanda) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Comanda(idComanda,idMesa,total,fecha,estado) "
          "VALUES ('${comanda.idComanda}','${comanda.idMesa}','${comanda.total}','${comanda.fecha}','${comanda.estado}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  insertarDetalleComanda(DetalleComandaModel detalleComanda) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO DetalleComandad(idDetalle,idComanda,idProducto,nombreProducto,fotoProducto,cantidad,subtotal,totalDetalle,observaciones,estado,llevar) "
          "VALUES ('${detalleComanda.idDetalle}','${detalleComanda.idComanda}','${detalleComanda.idProducto}','${detalleComanda.nombreProducto}','${detalleComanda.fotoProducto}','${detalleComanda.cantidad}','${detalleComanda.subtotal}','${detalleComanda.totalDetalle}','${detalleComanda.observaciones}','${detalleComanda.estado}','${detalleComanda.llevar}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<ComandaModel>> obtenerComandaPorIdMesa(String idMesa) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Comanda WHERE idMesa='$idMesa'");

    List<ComandaModel> list = res.isNotEmpty ? res.map((c) => ComandaModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<DetalleComandaModel>> obtenerDetalleComandaPorIdComanda(String idComanda) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM DetalleComandad WHERE idComanda='$idComanda'");

    List<DetalleComandaModel> list = res.isNotEmpty ? res.map((c) => DetalleComandaModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteComanda() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Comanda');

    return res;
  }

  deleteDetalleComanda() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM DetalleComandad');

    return res;
  }

  deleteComandaPorIdMesa(String idMesa) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Comanda WHERE idMesa='$idMesa'");

    return res;
  }
}
