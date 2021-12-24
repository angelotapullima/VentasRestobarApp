import 'package:ventas_restobar/src/database/database_provider.dart';
import 'package:ventas_restobar/src/models/familias_model.dart';

class FamiliaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarFamilia(FamiliasModel familia) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Familias(idFamilia,familiaNombre,familiaEstado) "
          "VALUES ('${familia.idFamilia}','${familia.familiaNombre}','${familia.familiaEstado}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<FamiliasModel>> obtenerFamilias() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Familias where familiaEstado = '1'");

    List<FamiliasModel> list = res.isNotEmpty ? res.map((c) => FamiliasModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteFamilias() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Familias');

    return res;
  }
}
