class ComandaModel {
  String idComanda;
  String idMesa;
  String total;
  String fecha;
  String estado;

  ComandaModel({
    this.idComanda,
    this.idMesa,
    this.total,
    this.fecha,
    this.estado,
  });

  factory ComandaModel.fromJson(Map<String, dynamic> json) => ComandaModel(
        idComanda: json["idComanda"],
        idMesa: json["idMesa"],
        total: json["total"],
        fecha: json["fecha"],
        estado: json["estado"],
      );
}
