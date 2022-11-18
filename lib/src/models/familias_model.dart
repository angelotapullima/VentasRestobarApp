class FamiliasModel {
  String? idFamilia;
  String? familiaNombre;
  String? familiaEstado;

  FamiliasModel({
    this.idFamilia,
    this.familiaNombre,
    this.familiaEstado,
  });

  Map<String, dynamic> toJson() => {
        'idFamilia': idFamilia,
        'familiaNombre': familiaNombre,
        'familiaEstado': familiaEstado,
      };

  factory FamiliasModel.fromJson(Map<String?, dynamic> json) => FamiliasModel(
        idFamilia: json["idFamilia"],
        familiaNombre: json["familiaNombre"],
        familiaEstado: json["familiaEstado"],
      );
}
