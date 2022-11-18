import 'package:rxdart/rxdart.dart';
import 'package:ventas_restobar/src/database/acompanamiento_database.dart';
import 'package:ventas_restobar/src/database/detalle_acomp_database.dart';
import 'package:ventas_restobar/src/database/productos_familia_database.dart';
import 'package:ventas_restobar/src/models/acompanamiento_model.dart';
import 'package:ventas_restobar/src/models/detalle_acomp_model.dart';
import 'package:ventas_restobar/src/models/productos_familia_model.dart';

class ProductosFamiliaBloc {
  final _productosDatabase = ProductosFamiliaDatabase();
  final _acompDB = AcompanamientoDatabase();
  final _detalleAcompDB = DetalleAcompDatabase();

  final _productoFamiliaController = BehaviorSubject<List<ProductosFamiliaModel>>();
  Stream<List<ProductosFamiliaModel>> get productosFamiliaStream => _productoFamiliaController.stream;

  //Producto Fitzcarraldo
  final _productoController = BehaviorSubject<List<ProductosFamiliaModel>>();
  Stream<List<ProductosFamiliaModel>> get productoStream => _productoController.stream;

  void obtenerProductosPorIdFamilia(String idFamilia) async {
    _productoFamiliaController.sink.add([]);
    //_productoFamiliaController.sink.add(await _productosDatabase.obtenerProductosXIdFamilia(idFamilia));
    //TODO FITZCARRALDO
    _productoFamiliaController.sink.add(await productosANDCopania(idFamilia));
  }

  void obtenerProductoByIdProducto(String idProducto, bool delete) async {
    if (delete) _productoController.sink.add([]);
    _productoController.sink.add(await productoByIdProducto(idProducto));
  }

  void dispose() {
    _productoFamiliaController.close();
    _productoController.close();
  }

  //Fizcarraldo

  Future<List<ProductosFamiliaModel>> productosANDCopania(String idFamilia) async {
    final List<ProductosFamiliaModel> result = [];

    final productsDB = await _productosDatabase.obtenerProductosXIdFamilia(idFamilia);

    for (var i = 0; i < productsDB.length; i++) {
      final producto = ProductosFamiliaModel();

      producto.idProducto = productsDB[i].idProducto;
      producto.idFamilia = productsDB[i].idFamilia;
      producto.idReceta = productsDB[i].idReceta;
      producto.productoNombre = productsDB[i].productoNombre;
      producto.productoDescripcion = productsDB[i].productoDescripcion;
      producto.productoFoto = productsDB[i].productoFoto;
      producto.productoPrecio = productsDB[i].productoPrecio;
      producto.productoEstado = productsDB[i].productoEstado;

      //Obteniendo los Acompanamientos
      final listaAcomoDB = await _acompDB.obtenerAcomps(productsDB[i].idProducto.toString());
      final List<AcompanamientoModel> listAcomp = [];
      for (var x = 0; x < listaAcomoDB.length; x++) {
        final acomp = AcompanamientoModel();
        acomp.id = listaAcomoDB[x].id;
        acomp.idProducto = listaAcomoDB[x].idProducto;
        acomp.texto = listaAcomoDB[x].texto;
        acomp.estado = listaAcomoDB[x].estado;

        //Agregar Detalle Acompañamiento
        acomp.detalles = await _detalleAcompDB.obtenerDetalleAcomps(listaAcomoDB[x].id.toString());
        listAcomp.add(acomp);
      }

      //Guardar Acompañamientos
      producto.acompList = listaAcomoDB;

      result.add(producto);
    }

    return result;
  }

  Future<List<ProductosFamiliaModel>> productoByIdProducto(String idProducto) async {
    final List<ProductosFamiliaModel> result = [];

    final productDB = await _productosDatabase.obtenerProductosByIdProducto(idProducto);

    if (productDB.isNotEmpty) {
      final producto = ProductosFamiliaModel();

      producto.idProducto = productDB[0].idProducto;
      producto.idFamilia = productDB[0].idFamilia;
      producto.idReceta = productDB[0].idReceta;
      producto.productoNombre = productDB[0].productoNombre;
      producto.productoDescripcion = productDB[0].productoDescripcion;
      producto.productoFoto = productDB[0].productoFoto;
      producto.productoPrecio = productDB[0].productoPrecio;
      producto.productoEstado = productDB[0].productoEstado;

      //Obteniendo los Acompanamientos
      final listaAcomoDB = await _acompDB.obtenerAcomps(productDB[0].idProducto.toString());
      final List<AcompanamientoModel> listAcomp = [];
      for (var x = 0; x < listaAcomoDB.length; x++) {
        final acomp = AcompanamientoModel();
        acomp.id = listaAcomoDB[x].id;
        acomp.idProducto = listaAcomoDB[x].idProducto;
        acomp.texto = listaAcomoDB[x].texto;
        acomp.estado = listaAcomoDB[x].estado;

        //Agregar Detalle Acompañamiento
        acomp.detalles = await _detalleAcompDB.obtenerDetalleAcomps(listaAcomoDB[x].id.toString());

        listAcomp.add(acomp);
      }

      //Guardar Acompañamientos
      producto.acompList = listAcomp;

      result.add(producto);
    }

    return result;
  }
}
