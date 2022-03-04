class DetalleComandaModel {
  String? idDetalle;
  String? idComanda;
  String? idProducto;
  String? nombreProducto;
  String? fotoProducto;
  String? cantidad;
  String? subtotal;
  String? totalDetalle;
  String? observaciones;
  String? estado;
  String? llevar;

  DetalleComandaModel({
    this.idDetalle,
    this.idComanda,
    this.idProducto,
    this.nombreProducto,
    this.fotoProducto,
    this.cantidad,
    this.subtotal,
    this.totalDetalle,
    this.observaciones,
    this.estado,
    this.llevar,
  });

  factory DetalleComandaModel.fromJson(Map<String, dynamic> json) => DetalleComandaModel(
        idDetalle: json["idDetalle"],
        idComanda: json["idComanda"],
        idProducto: json["idProducto"],
        nombreProducto: json["nombreProducto"],
        fotoProducto: json["fotoProducto"],
        cantidad: json["cantidad"],
        subtotal: json["subtotal"],
        totalDetalle: json["totalDetalle"],
        observaciones: json["observaciones"],
        estado: json["estado"],
        llevar: json["llevar"],
      );
}
