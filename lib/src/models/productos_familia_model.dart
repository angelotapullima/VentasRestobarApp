import 'package:ventas_restobar/src/models/acompanamiento_model.dart';

class ProductosFamiliaModel {
  String? idProducto;
  String? idFamilia;
  String? idReceta;
  String? productoNombre;
  String? productoDescripcion;
  String? productoFoto;
  String? productoPrecio;
  String? productoEstado;

  //No en DB
  List<AcompanamientoModel>? acompList;

  ProductosFamiliaModel({
    this.idProducto,
    this.idFamilia,
    this.idReceta,
    this.productoNombre,
    this.productoDescripcion,
    this.productoFoto,
    this.productoPrecio,
    this.productoEstado,
    this.acompList,
  });

  Map<String, dynamic> toJson() => {
        'idProducto': idProducto,
        'idFamilia': idFamilia,
        'idReceta': idReceta,
        'productoNombre': productoNombre,
        'productoDescripcion': productoDescripcion,
        'productoFoto': productoFoto,
        'productoPrecio': productoPrecio,
        'productoEstado': productoEstado,
      };

  factory ProductosFamiliaModel.fromJson(Map<String?, dynamic> json) => ProductosFamiliaModel(
        idProducto: json["idProducto"],
        idFamilia: json["idFamilia"],
        idReceta: json["idReceta"],
        productoNombre: json["productoNombre"],
        productoDescripcion: json["productoDescripcion"],
        productoFoto: json["productoFoto"],
        productoPrecio: json["productoPrecio"],
        productoEstado: json["productoEstado"],
      );
}
