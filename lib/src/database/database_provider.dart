import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._privateConstructor();
  static final DatabaseProvider db = DatabaseProvider._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await getDatabase();

  Future<Database> getDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ventas.db');


    Future _onConfigure(Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }
    
     return openDatabase(
      path,
      onCreate: (db, version)async {
       await db.execute(' CREATE TABLE Mesas('
          ' idMesa TEXT PRIMARY KEY,'
          ' idNegocio TEXT,'
          ' mesaNombre TEXT,'
          ' mesaCapacidad TEXT,'
          ' mesaEstado TEXT,'
          ' mesaEstadoAtencion TEXT'
          ')');

      await db.execute(' CREATE TABLE Familias('
          ' idFamilia TEXT PRIMARY KEY,'
          ' familiaNombre TEXT,'
          ' familiaEstado TEXT'
          ')');

      await db.execute(' CREATE TABLE ProductosFamilia('
          ' idProducto TEXT PRIMARY KEY,'
          ' idFamilia TEXT,'
          ' idReceta TEXT,'
          ' productoNombre TEXT,'
          ' productoDescripcion TEXT,'
          ' productoFoto TEXT,'
          ' productoPrecio TEXT,'
          ' productoEstado TEXT'
          ')');

      await db.execute(' CREATE TABLE Comanda('
          ' idComanda TEXT PRIMARY KEY,'
          ' idMesa TEXT,'
          ' total TEXT,'
          ' fecha TEXT,'
          ' estado TEXT'
          ')');

      await db.execute(' CREATE TABLE DetalleComandad('
          ' idDetalle TEXT PRIMARY KEY,'
          ' idComanda TEXT,'
          ' idProducto TEXT,'
          ' nombreProducto TEXT,'
          ' fotoProducto TEXT,'
          ' cantidad TEXT,'
          ' subtotal TEXT,'
          ' totalDetalle TEXT,'
          ' observaciones TEXT,'
          ' estado TEXT,'
          ' llevar TEXT'
          ')');

      await db.execute(' CREATE TABLE DetalleComandaTemporal('
          ' id INTEGER PRIMARY KEY AUTOINCREMENT,'
          ' idMesa TEXT,'
          ' idProducto TEXT,'
          ' nombreProducto TEXT,'
          ' fotoProducto TEXT,'
          ' cantidad TEXT,'
          ' subtotal TEXT,'
          ' totalDetalle TEXT,'
          ' observaciones TEXT,'
          ' estado TEXT,'
          ' despacho TEXT'
          ')');

      
    
      },
      version: 1,
      onConfigure: _onConfigure,
    );
  
    }
    }

/* 
  static Database _database;
  static final DatabaseProvider db = DatabaseProvider._();

  DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'restoBarApp.db');
    Future _onConfigure(Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }

    return await openDatabase(path, version: 1, onOpen: (db) {}, onConfigure: _onConfigure, onCreate: (
      Database db,
      int version,
    ) async {
      await db.execute(' CREATE TABLE Mesas('
          ' idMesa TEXT PRIMARY KEY,'
          ' idNegocio TEXT,'
          ' mesaNombre TEXT,'
          ' mesaCapacidad TEXT,'
          ' mesaEstado TEXT,'
          ' mesaEstadoAtencion TEXT'
          ')');

      await db.execute(' CREATE TABLE Familias('
          ' idFamilia TEXT PRIMARY KEY,'
          ' familiaNombre TEXT,'
          ' familiaEstado TEXT'
          ')');

      await db.execute(' CREATE TABLE ProductosFamilia('
          ' idProducto TEXT PRIMARY KEY,'
          ' idFamilia TEXT,'
          ' idReceta TEXT,'
          ' productoNombre TEXT,'
          ' productoDescripcion TEXT,'
          ' productoFoto TEXT,'
          ' productoPrecio TEXT,'
          ' productoEstado TEXT'
          ')');

      await db.execute(' CREATE TABLE Comanda('
          ' idComanda TEXT PRIMARY KEY,'
          ' idMesa TEXT,'
          ' total TEXT,'
          ' fecha TEXT,'
          ' estado TEXT'
          ')');

      await db.execute(' CREATE TABLE DetalleComandad('
          ' idDetalle TEXT PRIMARY KEY,'
          ' idComanda TEXT,'
          ' idProducto TEXT,'
          ' nombreProducto TEXT,'
          ' fotoProducto TEXT,'
          ' cantidad TEXT,'
          ' subtotal TEXT,'
          ' totalDetalle TEXT,'
          ' observaciones TEXT,'
          ' estado TEXT,'
          ' llevar TEXT'
          ')');

      await db.execute(' CREATE TABLE DetalleComandaTemporal('
          ' id INTEGER PRIMARY KEY AUTOINCREMENT,'
          ' idMesa TEXT,'
          ' idProducto TEXT,'
          ' nombreProducto TEXT,'
          ' fotoProducto TEXT,'
          ' cantidad TEXT,'
          ' subtotal TEXT,'
          ' totalDetalle TEXT,'
          ' observaciones TEXT,'
          ' estado TEXT,'
          ' despacho TEXT'
          ')');

      // await db.execute(' CREATE TABLE DetallePedidosTemporales('
      //     ' id INTEGER PRIMARY KEY AUTOINCREMENT,'
      //     ' idMesa TEXT,'
      //     ' idProducto TEXT,'
      //     ' foto TEXT,'
      //     ' nombre TEXT,'
      //     ' cantidad TEXT,'
      //     ' subtotal TEXT,'
      //     ' observaciones TEXT,'
      //     ' estado TEXT,'
      //     ' llevar TEXT'
      //     ')');

      // await db.execute(' CREATE TABLE PedidosPorAtender('
      //     ' idPedidoDetalle TEXT PRIMARY KEY,'
      //     ' idNegocio TEXT,'
      //     ' idMesa TEXT,'
      //     ' idProducto TEXT,'
      //     ' nombreProducto TEXT,'
      //     ' mesaNombre TEXT,'
      //     ' fotoProducto TEXT,'
      //     ' cantidad TEXT,'
      //     ' fecha TEXT,'
      //     ' estado TEXT'
      //     ')');

      // await db.execute(' CREATE TABLE Ventas('
      //     ' idVenta TEXT PRIMARY KEY,'
      //     ' idNegocio TEXT,'
      //     ' idMesa TEXT,'
      //     ' idPedido TEXT,'
      //     ' envio TEXT,'
      //     ' direccion TEXT,'
      //     ' tipoDoc TEXT,'
      //     ' serie TEXT,'
      //     ' correlativo TEXT,'
      //     ' igv TEXT,'
      //     ' incluyeIGV TEXT,'
      //     ' descuento TEXT,'
      //     ' total TEXT,'
      //     ' fecha TEXT,'
      //     ' hora TEXT,'
      //     ' estado TEXT'
      //     ')');

      // await db.execute(' CREATE TABLE ReportesLineas('
      //     ' idLinea TEXT PRIMARY KEY,'
      //     ' idNegocio TEXT,'
      //     ' idCategoria TEXT,'
      //     ' nombre TEXT,'
      //     ' estado TEXT,'
      //     ' cantidad TEXT,'
      //     ' suma TEXT'
      //     ')');

      // await db.execute(' CREATE TABLE ReportesProductos('
      //     ' idProducto TEXT PRIMARY KEY,'
      //     ' idNegocio TEXT,'
      //     ' estado TEXT,'
      //     ' cantidad TEXT,'
      //     ' suma TEXT'
      //     ')');

      // await db.execute(' CREATE TABLE ReporteGeneral('
      //     ' id TEXT PRIMARY KEY,'
      //     ' cantidad TEXT,'
      //     ' sumaTotal TEXT'
      //     ')');

      // await db.execute(' CREATE TABLE ReportesUtilidadesLineas('
      //     ' idLinea TEXT PRIMARY KEY,'
      //     ' idNegocio TEXT,'
      //     ' idCategoria TEXT,'
      //     ' nombre TEXT,'
      //     ' estado TEXT,'
      //     ' cantidad TEXT,'
      //     ' suma TEXT'
      //     ')');

      // await db.execute(' CREATE TABLE Planes('
      //     ' idPlan TEXT PRIMARY KEY,'
      //     ' nombre TEXT,'
      //     ' descripcion TEXT,'
      //     ' costo TEXT,'
      //     ' estado TEXT'
      //     ')');

      // await db.execute(' CREATE TABLE PlanUser('
      //     ' idUserPlan TEXT PRIMARY KEY,'
      //     ' idUser TEXT,'
      //     ' idNegocio TEXT,'
      //     ' idPlan TEXT,'
      //     ' inicioFecha TEXT,'
      //     ' finFecha TEXT,'
      //     ' voucher TEXT,'
      //     ' estado TEXT'
      //     ')');

      // await db.execute(' CREATE TABLE MiembrosPlan('
      //     ' idMiembro TEXT PRIMARY KEY,'
      //     ' idPlan TEXT,'
      //     ' idUser TEXT,'
      //     ' nombre TEXT,'
      //     ' imagen TEXT,'
      //     ' apellidoMaterno TEXT,'
      //     ' apellidoPaterno TEXT,'
      //     ' puesto TEXT,'
      //     ' fechaCreacion TEXT,'
      //     ' estado TEXT'
      //     ')');
    });
  }
}
 */