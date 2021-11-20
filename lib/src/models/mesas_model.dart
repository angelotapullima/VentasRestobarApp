class MesaModel {
  String idMesa;
  String idNegocio;
  String mesaNombre;
  String mesaEstado;
  String mesaCapacidad;
  String mesaEstadoAtencion;

  MesaModel({
    this.idMesa,
    this.idNegocio,
    this.mesaNombre,
    this.mesaEstado,
    this.mesaCapacidad,
    this.mesaEstadoAtencion,
  });

  factory MesaModel.fromJson(Map<String, dynamic> json) => MesaModel(
        idMesa: json["idMesa"],
        idNegocio: json["idNegocio"],
        mesaNombre: json["mesaNombre"],
        mesaEstado: json["mesaEstado"],
        mesaCapacidad: json["mesaCapacidad"],
        mesaEstadoAtencion: json["mesaEstadoAtencion"],
      );
}
