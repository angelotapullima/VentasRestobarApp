import 'package:sqflite/sqflite.dart';
import 'package:ventas_restobar/src/database/database_provider.dart';
import 'package:ventas_restobar/src/models/mesas_model.dart';

class MesaDatabase {
  final dbprovider = DatabaseProvider.db;

  // insertarMesa(MesaModel mesa) async {
  //   print('inserrtar mesas');
  //   try {
  //     final db = await dbprovider.database;

  //     final res = await db.rawInsert("INSERT OR REPLACE INTO Mesas (idMesa,idNegocio,mesaNombre,mesaCapacidad,mesaEstado,mesaEstadoAtencion) "
  //         "VALUES ('${mesa.idMesa}','${mesa.idNegocio}','${mesa.mesaNombre}','${mesa.mesaCapacidad}','${mesa.mesaEstado}','${mesa.mesaEstadoAtencion}')");

  //     return res;
  //   } catch (exception) {
  //     print(exception);
  //   }
  // }

  Future<void> insertarMesa(MesaModel mesa) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Mesas',
        mesa.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      return;
    }
  }

  Future<List<MesaModel>> obtenerMesasPorNegocio(String idNegocio) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Mesas WHERE idNegocio='$idNegocio'");

    List<MesaModel> list = res.isNotEmpty ? res.map((c) => MesaModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<MesaModel>> obtenerMesasDisponibles(String idNegocio) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery(
        "SELECT * FROM Mesas WHERE idNegocio='$idNegocio' AND mesaEstadoAtencion='0' AND cast(idMesa as int) >0 ORDER BY cast(idMesa as int)");

    List<MesaModel> list = res.isNotEmpty ? res.map((c) => MesaModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<MesaModel>> obtenerMesasPorNegocioSalon(String idNegocio) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Mesas WHERE idNegocio='$idNegocio' AND cast(idMesa as int) >0 ORDER BY cast(idMesa as int) ");

    List<MesaModel> list = res.isNotEmpty ? res.map((c) => MesaModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<MesaModel>> obtenerMesasPorNegocioBarra(String idNegocio) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Mesas WHERE idNegocio='$idNegocio' AND cast(idMesa as int) < -6 ORDER BY cast(idMesa as int) DESC ");

    List<MesaModel> list = res.isNotEmpty ? res.map((c) => MesaModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<MesaModel>> obtenerMesaPorIdMesa(String idMesa) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Mesas WHERE idMesa='$idMesa'");

    List<MesaModel> list = res.isNotEmpty ? res.map((c) => MesaModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteMesas() async {
    print('borrando mesas');
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Mesas');

    return res;
  }
}
