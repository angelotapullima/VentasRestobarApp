import 'package:ventas_restobar/src/models/detalle_acomp_model.dart';

class AcompanamientoModel {
  String? id;
  String? idProducto;
  String? texto;
  String? estado;

  //No en DB
  List<DetalleAcompModel>? detalles;

  AcompanamientoModel({
    this.id,
    this.idProducto,
    this.texto,
    this.estado,
    this.detalles,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'idProducto': idProducto,
        'texto': texto,
        'estado': estado,
      };

  factory AcompanamientoModel.fromJson(Map<String, dynamic> json) => AcompanamientoModel(
        id: json["id"],
        idProducto: json["idProducto"],
        texto: json["texto"],
        estado: json["estado"],
      );
}
