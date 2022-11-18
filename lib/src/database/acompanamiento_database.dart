import 'package:sqflite/sqflite.dart';
import 'package:ventas_restobar/src/database/database_provider.dart';
import 'package:ventas_restobar/src/models/acompanamiento_model.dart';

class AcompanamientoDatabase {
  final dbprovider = DatabaseProvider.db;

  Future<void> insertarAcomp(AcompanamientoModel acomp) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Acompanamiento',
        acomp.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      return;
    }
  }

  Future<List<AcompanamientoModel>> obtenerAcomps(String idProducto) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Acompanamiento where idProducto = '$idProducto' AND estado='1' ");

    List<AcompanamientoModel> list = res.isNotEmpty ? res.map((c) => AcompanamientoModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteAcomps() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Acompanamiento');

    return res;
  }
}
