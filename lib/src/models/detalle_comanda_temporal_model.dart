class DetalleComandaTemporalModel {
  int? id;
  String? idMesa;
  String? idProducto;
  String? nombreProducto;
  String? fotoProducto;
  String? cantidad;
  String? subtotal;
  String? totalDetalle;
  String? observaciones;
  String? estado;
  String? despacho;

  DetalleComandaTemporalModel({
    this.id,
    this.idMesa,
    this.idProducto,
    this.nombreProducto,
    this.fotoProducto,
    this.cantidad,
    this.subtotal,
    this.totalDetalle,
    this.observaciones,
    this.estado,
    this.despacho,
  });

  Map<String, dynamic> toJson() => {
        'idMesa': idMesa,
        'idProducto': idProducto,
        'nombreProducto': nombreProducto,
        'fotoProducto': fotoProducto,
        'cantidad': cantidad,
        'subtotal': subtotal,
        'totalDetalle': totalDetalle,
        'observaciones': observaciones,
        'estado': estado,
        'despacho': despacho,
      };

  factory DetalleComandaTemporalModel.fromJson(Map<String?, dynamic> json) => DetalleComandaTemporalModel(
        id: json["id"],
        idMesa: json["idMesa"],
        idProducto: json["idProducto"],
        nombreProducto: json["nombreProducto"],
        fotoProducto: json["fotoProducto"],
        cantidad: json["cantidad"],
        subtotal: json["subtotal"],
        totalDetalle: json["totalDetalle"],
        observaciones: json["observaciones"],
        estado: json["estado"],
        despacho: json["despacho"],
      );
}
