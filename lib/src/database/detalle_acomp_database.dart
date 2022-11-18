import 'package:sqflite/sqflite.dart';
import 'package:ventas_restobar/src/database/database_provider.dart';
import 'package:ventas_restobar/src/models/detalle_acomp_model.dart';

class DetalleAcompDatabase {
  final dbprovider = DatabaseProvider.db;

  Future<void> insertarDetalleAcomp(DetalleAcompModel detalle) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'DetalleAcomp',
        detalle.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      return;
    }
  }

  Future<List<DetalleAcompModel>> obtenerDetalleAcomps(String idAcomp) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM DetalleAcomp where idAcomp = '$idAcomp' AND estado='1' ");

    List<DetalleAcompModel> list = res.isNotEmpty ? res.map((c) => DetalleAcompModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteDetalleAcomps() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM DetalleAcomp');

    return res;
  }

  updateHabilitarCheck(String id, String value) async {
    final db = await dbprovider.database;

    final res = await db.rawUpdate("UPDATE DetalleAcomp SET "
        "valueCheck='$value' "
        "WHERE id='$id'");
    return res;
  }

  updateResetCheck() async {
    final db = await dbprovider.database;

    final res = await db.rawUpdate("UPDATE DetalleAcomp SET "
        "valueCheck='0'");
    return res;
  }
}
