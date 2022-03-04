import 'package:rxdart/rxdart.dart';
import 'package:ventas_restobar/src/database/productos_familia_database.dart';
import 'package:ventas_restobar/src/models/productos_familia_model.dart';

class ProductosFamiliaBloc {
  final _productosDatabase = ProductosFamiliaDatabase();

  final _productoFamiliaController = BehaviorSubject<List<ProductosFamiliaModel>>();

  Stream<List<ProductosFamiliaModel>> get productosFamiliaStream => _productoFamiliaController.stream;

  void obtenerProductosPorIdFamilia(String idFamilia) async {
    _productoFamiliaController.sink.add([]);
    _productoFamiliaController.sink.add(await _productosDatabase.obtenerProductosXIdFamilia(idFamilia));
  }

  void dispose() {
    _productoFamiliaController.close();
  }
}
