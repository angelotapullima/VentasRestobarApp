import 'package:ventas_restobar/src/database/database_provider.dart';
import 'package:ventas_restobar/src/models/productos_familia_model.dart';

class ProductosFamiliaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarProductoFamilia(ProductosFamiliaModel producto) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO ProductosFamilia(idProducto,idFamilia,idReceta,productoNombre,productoDescripcion,productoFoto,productoPrecio,productoEstado) "
          "VALUES ('${producto.idProducto}','${producto.idFamilia}','${producto.idReceta}','${producto.productoNombre}','${producto.productoDescripcion}','${producto.productoFoto}','${producto.productoPrecio}','${producto.productoEstado}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<ProductosFamiliaModel>> obtenerProductosXIdFamilia(String idFamilia) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM ProductosFamilia WHERE idFamilia='$idFamilia' and productoEstado ='1' ");

    List<ProductosFamiliaModel> list = res.isNotEmpty ? res.map((c) => ProductosFamiliaModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteCProductosFamilia() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM ProductosFamilia');

    return res;
  }
}
