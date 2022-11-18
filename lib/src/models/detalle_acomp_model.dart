class DetalleAcompModel {
  String? id;
  String? idAcomp;
  String? texto;
  String? estado;
  String? valueCheck;

  DetalleAcompModel({
    this.id,
    this.idAcomp,
    this.texto,
    this.estado,
    this.valueCheck,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'idAcomp': idAcomp,
        'texto': texto,
        'estado': estado,
        'valueCheck': valueCheck,
      };

  factory DetalleAcompModel.fromJson(Map<String, dynamic> json) => DetalleAcompModel(
        id: json["id"],
        idAcomp: json["idAcomp"],
        texto: json["texto"],
        estado: json["estado"],
        valueCheck: json["valueCheck"],
      );
}
