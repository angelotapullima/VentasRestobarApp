import 'package:ventas_restobar/src/models/detalle_comanda_model.dart';

class ComandaModel {
  String? idComanda;
  String? idMesa;
  String? total;
  String? fecha;
  String? estado;

  List<DetalleComandaModel>? detalleComanda;

  ComandaModel({
    this.idComanda,
    this.idMesa,
    this.total,
    this.fecha,
    this.estado,
    this.detalleComanda,
  });

  factory ComandaModel.fromJson(Map<String, dynamic> json) => ComandaModel(
        idComanda: json["idComanda"],
        idMesa: json["idMesa"],
        total: json["total"],
        fecha: json["fecha"],
        estado: json["estado"],
      );
}
