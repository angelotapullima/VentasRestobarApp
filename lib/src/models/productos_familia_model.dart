class ProductosFamiliaModel {
  String idProducto;
  String idFamilia;
  String idReceta;
  String productoNombre;
  String productoDescripcion;
  String productoFoto;
  String productoPrecio;
  String productoEstado;

  ProductosFamiliaModel({
    this.idProducto,
    this.idFamilia,
    this.idReceta,
    this.productoNombre,
    this.productoDescripcion,
    this.productoFoto,
    this.productoPrecio,
    this.productoEstado,
  });

  factory ProductosFamiliaModel.fromJson(Map<String, dynamic> json) => ProductosFamiliaModel(
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
