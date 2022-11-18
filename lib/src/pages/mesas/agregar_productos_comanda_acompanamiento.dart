// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:ventas_restobar/src/api/comanda_api.dart';
// import 'package:ventas_restobar/src/api/comanda_temporal_api.dart';
// import 'package:ventas_restobar/src/bloc/provider.dart';
// import 'package:ventas_restobar/src/database/detalle_acomp_database.dart';
// import 'package:ventas_restobar/src/models/acompanamiento_model.dart';
// import 'package:ventas_restobar/src/models/detalle_acomp_model.dart';
// import 'package:ventas_restobar/src/models/productos_familia_model.dart';
// import 'package:ventas_restobar/src/preferences/preferences.dart';
// import 'package:ventas_restobar/src/utils/constants.dart';
// import 'package:ventas_restobar/src/utils/utils.dart';
// import 'package:ventas_restobar/src/widgets/producto_image.dart';

// class AgregarProductoComandaAcompanamiento extends StatefulWidget {
//   const AgregarProductoComandaAcompanamiento({Key? key, required this.producto, required this.nombreCategoria}) : super(key: key);
//   final ProductosFamiliaModel producto;
//   final String nombreCategoria;

//   @override
//   _AgregarProductoComandaAcompanamientoState createState() => _AgregarProductoComandaAcompanamientoState();
// }

// class _AgregarProductoComandaAcompanamientoState extends State<AgregarProductoComandaAcompanamiento> {
//   final _controller = ChangeController();
//   final TextEditingController _observacionController = TextEditingController();
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       _controller.changeCantidadPrecio(0, widget.producto.productoPrecio.toString());

//       await DetalleAcompDatabase().updateResetCheck();
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _productoBloc = ProviderBloc.productos(context);
//     _productoBloc.obtenerProductoByIdProducto(widget.producto.idProducto.toString(), true);
//     return Material(
//       color: Colors.black.withOpacity(.5),
//       child: Stack(
//         children: [
//           InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Container(
//               height: double.infinity,
//               width: double.infinity,
//               color: Color.fromRGBO(50, 50, 50, 0.9),
//             ),
//           ),
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             margin: EdgeInsets.symmetric(
//               vertical: ScreenUtil().setHeight(30),
//               horizontal: ScreenUtil().setWidth(24),
//             ),
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   child: Container(
//                       height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   child: Container(
//                       height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
//                 ),
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: Container(
//                       height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: Container(
//                       height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             margin: EdgeInsets.symmetric(
//               vertical: ScreenUtil().setHeight(70),
//               horizontal: ScreenUtil().setWidth(70),
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 vertical: ScreenUtil().setHeight(30),
//                 horizontal: ScreenUtil().setWidth(32),
//               ),
//               child: StreamBuilder<List<ProductosFamiliaModel>>(
//                   stream: _productoBloc.productoStream,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       if (snapshot.data!.isNotEmpty) {
//                         var product = snapshot.data![0];
//                         return SingleChildScrollView(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       '${widget.nombreCategoria}',
//                                       textAlign: TextAlign.center,
//                                       style: Theme.of(context).textTheme.button!.copyWith(
//                                             color: kTitleTextColor,
//                                             fontSize: ScreenUtil().setSp(20),
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     icon: Icon(Icons.close),
//                                     iconSize: ScreenUtil().setHeight(30),
//                                     padding: EdgeInsets.all(0),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   ProductoImage(
//                                     himage: 50,
//                                     hmax: 100,
//                                     wmax: 100,
//                                     hmin: 75,
//                                     wmin: 75,
//                                     image: 'cubiertos',
//                                   ),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           '${product.productoNombre}',
//                                           style: Theme.of(context).textTheme.button!.copyWith(
//                                                 color: kTitleTextColor,
//                                                 fontSize: ScreenUtil().setSp(18),
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                         ),
//                                         AnimatedBuilder(
//                                             animation: _controller,
//                                             builder: (_, p) {
//                                               return Text(
//                                                 'S/${_controller.precioMuestra}',
//                                                 style: Theme.of(context).textTheme.button!.copyWith(
//                                                       color: kTextColor,
//                                                       fontSize: ScreenUtil().setSp(18),
//                                                       fontWeight: FontWeight.w600,
//                                                     ),
//                                               );
//                                             }),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: ScreenUtil().setWidth(90),
//                                   ),
//                                   AnimatedBuilder(
//                                     animation: _controller,
//                                     builder: (_, s) {
//                                       return Row(
//                                         children: [
//                                           InkWell(
//                                             onTap: () {
//                                               _controller.changeCantidadPrecio(-1, widget.producto.productoPrecio.toString());
//                                             },
//                                             child: Container(
//                                               height: ScreenUtil().setHeight(40),
//                                               child: SvgPicture.asset('assets/svg/minus.svg'),
//                                             ),
//                                           ),
//                                           Container(
//                                             margin: EdgeInsets.symmetric(
//                                               horizontal: ScreenUtil().setWidth(24),
//                                             ),
//                                             child: Text(
//                                               '${_controller.cantidad}',
//                                               style: Theme.of(context).textTheme.button!.copyWith(
//                                                     color: kTitleTextColor,
//                                                     fontSize: ScreenUtil().setSp(20),
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                             ),
//                                           ),
//                                           InkWell(
//                                             onTap: () {
//                                               _controller.changeCantidadPrecio(1, widget.producto.productoPrecio.toString());
//                                             },
//                                             child: Container(
//                                               height: ScreenUtil().setHeight(40),
//                                               child: SvgPicture.asset('assets/svg/add.svg'),
//                                             ),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               (product.acompList!.isNotEmpty)
//                                   ? ExpansionTile(
//                                       maintainState: true,
//                                       initiallyExpanded: true,
//                                       title: Text(
//                                         'Acompañamientos',
//                                         textAlign: TextAlign.center,
//                                         style: Theme.of(context).textTheme.button!.copyWith(
//                                               color: kTitleTextColor,
//                                               fontSize: ScreenUtil().setSp(15),
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                       ),
//                                       children: [
//                                         Wrap(
//                                           spacing: 8.0,
//                                           runSpacing: 4.0,
//                                           children: product.acompList!.map((item) => crearAcompanamiento(context, item)).toList(),
//                                         )
//                                       ],
//                                     )
//                                   : Container(),
//                               SizedBox(
//                                 height: ScreenUtil().setHeight(30),
//                               ),
//                               Container(
//                                 height: ScreenUtil().setHeight(90),
//                                 width: ScreenUtil().setWidth(520),
//                                 child: TextField(
//                                   controller: _observacionController,
//                                   keyboardType: TextInputType.text,
//                                   maxLines: 4,
//                                   decoration: InputDecoration(
//                                     labelText: 'Observaciones',
//                                     labelStyle: Theme.of(context).textTheme.button!.copyWith(
//                                           color: kTitleTextColor,
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: ScreenUtil().setSp(16),
//                                           letterSpacing: 0.16,
//                                         ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                       borderSide: BorderSide(color: kOrangeTitleTextColor, width: ScreenUtil().setWidth(2)),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                       borderSide: BorderSide(color: kOrangeTitleTextColor, width: ScreenUtil().setWidth(2)),
//                                     ),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                       borderSide: BorderSide(color: kOrangeTitleTextColor, width: ScreenUtil().setWidth(2)),
//                                     ),
//                                   ),
//                                   style: Theme.of(context).textTheme.button!.copyWith(
//                                         color: kTitleTextColor,
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: ScreenUtil().setSp(18),
//                                       ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: ScreenUtil().setHeight(50),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   AnimatedBuilder(
//                                     animation: _controller,
//                                     builder: (_, t) {
//                                       return InkWell(
//                                         onTap: () {
//                                           _controller.changeLLevar(!_controller.llevar);
//                                         },
//                                         child: (_controller.llevar)
//                                             ? Container(
//                                                 height: ScreenUtil().setHeight(30),
//                                                 child: SvgPicture.asset('assets/svg/check.svg'),
//                                               )
//                                             : Container(
//                                                 height: ScreenUtil().setHeight(30),
//                                                 width: ScreenUtil().setWidth(23),
//                                                 decoration: BoxDecoration(
//                                                   color: Color(0XFFD8D8D8),
//                                                   borderRadius: BorderRadius.circular(8),
//                                                 ),
//                                               ),
//                                       );
//                                     },
//                                   ),
//                                   SizedBox(
//                                     width: ScreenUtil().setWidth(16),
//                                   ),
//                                   Text(
//                                     'Para llevar',
//                                     style: Theme.of(context).textTheme.button!.copyWith(
//                                           color: kTitleTextColor,
//                                           fontSize: ScreenUtil().setSp(20),
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                   ),
//                                   SizedBox(
//                                     width: ScreenUtil().setWidth(16),
//                                   ),
//                                   Container(
//                                     height: ScreenUtil().setHeight(30),
//                                     child: SvgPicture.asset('assets/svg/llevar.svg'),
//                                   ),
//                                   SizedBox(
//                                     width: ScreenUtil().setWidth(100),
//                                   ),
//                                   SizedBox(
//                                     width: ScreenUtil().setWidth(230),
//                                     child: MaterialButton(
//                                       color: kOrangeTitleTextColor,
//                                       textColor: Colors.white,
//                                       elevation: 0,
//                                       onPressed: () async {
//                                         _controller.changeCargando(true);
//                                         String observaciones = '';
//                                         for (var i = 0; i < _controller.acomps.length; i++) {
//                                           if (i == _controller.acomps.length - 1) {
//                                             if (_observacionController.text.isNotEmpty) {
//                                               observaciones += '${_controller.acomps[i]} // ';
//                                             } else {
//                                               observaciones += '${_controller.acomps[i]}';
//                                             }
//                                           } else {
//                                             observaciones += '${_controller.acomps[i]} // ';
//                                           }
//                                         }

//                                         observaciones += _observacionController.text;
//                                         print('Observaciones a enviar $observaciones');
//                                         final _preferences = Preferences();
//                                         if (_preferences.esComanda) {
//                                           final comandaApi = ComandaApi();
//                                           final res = await comandaApi.agregarProductoAComanda(product, _controller.cantidad,
//                                               _controller.precioMuestra, (_controller.llevar) ? 'PARA LLEVAR' : 'SALON', observaciones);
//                                           if (res.code == 1) {
//                                             final mesasBloc = ProviderBloc.mesas(context);
//                                             await mesasBloc.updateMesas(_preferences.indexSelect);
//                                             final comandaBloc = ProviderBloc.comanda(context);
//                                             comandaBloc.obtenerComandaPorMesa(_preferences.idMesa);
//                                             Navigator.pop(context);
//                                           } else {
//                                             showToast2(res.message.toString(), Colors.red);
//                                           }
//                                         } else {
//                                           final temporal = ComandaTemporalApi();
//                                           final res = await temporal.guardarDetalleTemporal(product, _controller.cantidad, _controller.precioMuestra,
//                                               (_controller.llevar) ? 'PARA LLEVAR' : 'SALON', observaciones);
//                                           if (res.code == 1) {
//                                             final comandaBloc = ProviderBloc.comanda(context);
//                                             comandaBloc.obtenerComandaTemporal(_preferences.idEnviarEnComanda);
//                                             Navigator.pop(context);
//                                           } else {
//                                             showToast2(res.message.toString(), Colors.red);
//                                           }
//                                         }
//                                         _controller.changeCargando(false);
//                                       },
//                                       shape: const RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(8.0),
//                                         ),
//                                       ),
//                                       child: Text(
//                                         'Guardar',
//                                         style: Theme.of(context).textTheme.button!.copyWith(
//                                               color: Colors.white,
//                                               fontSize: ScreenUtil().setSp(18),
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: ScreenUtil().setHeight(320),
//                               ),
//                             ],
//                           ),
//                         );
//                       } else {
//                         return Center(
//                           child: Text('Sin información disponible'),
//                         );
//                       }
//                     } else {
//                       return Center(
//                         child: CupertinoActivityIndicator(),
//                       );
//                     }
//                   }),
//             ),
//           ),
//           AnimatedBuilder(
//             animation: _controller,
//             builder: (_, f) {
//               return (_controller.cargando)
//                   ? Container(
//                       height: double.infinity,
//                       width: double.infinity,
//                       color: Color.fromRGBO(0, 0, 0, 0.1),
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           color: kOrangeTitleTextColor,
//                         ),
//                       ),
//                     )
//                   : Container();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget crearAcompanamiento(BuildContext context, AcompanamientoModel acomp) {
//     return Container(
//       width: ScreenUtil().setWidth(200),
//       child: ExpansionTile(
//         maintainState: true,
//         initiallyExpanded: true,
//         title: Text(
//           acomp.texto ?? '',
//           style: TextStyle(
//             color: Colors.blueGrey,
//             fontSize: ScreenUtil().setSp(14),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         children: acomp.detalles?.map((detail) => crearItemDetalle(context, detail)).toList() ?? [],
//       ),
//     );
//   }

//   Widget crearItemDetalle(BuildContext context, DetalleAcompModel item) {
//     return InkWell(
//       onTap: () async {
//         if (item.valueCheck == '0') {
//           await DetalleAcompDatabase().updateHabilitarCheck(item.id.toString(), '1');
//           _controller.addAcomps(item.texto ?? '');
//         } else {
//           await DetalleAcompDatabase().updateHabilitarCheck(item.id.toString(), '0');
//           _controller.removeAcomp(item.texto ?? '');
//         }

//         final _productoBloc = ProviderBloc.productos(context);
//         _productoBloc.obtenerProductoByIdProducto(widget.producto.idProducto.toString(), false);
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(
//           horizontal: ScreenUtil().setWidth(16),
//           vertical: ScreenUtil().setHeight(8),
//         ),
//         padding: const EdgeInsets.all(8.0),
//         decoration: BoxDecoration(
//           color: Colors.transparent,
//           border: Border.all(color: Colors.blueGrey),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(
//                 item.texto ?? '',
//                 style: TextStyle(
//                   fontSize: ScreenUtil().setSp(13),
//                 ),
//               ),
//             ),
//             check(
//               context,
//               (item.valueCheck == '1') ? Icons.check_circle : Icons.circle_outlined,
//               (item.valueCheck == '1') ? Colors.green : Colors.blueGrey,
//               '1',
//               item,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget check(BuildContext context, IconData icon, Color color, String value, DetalleAcompModel item) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//         border: Border.all(color: color),
//       ),
//       child: Icon(
//         icon,
//         color: color,
//       ),
//     );
//   }
// }

// class ChangeController extends ChangeNotifier {
//   bool cargando = false;
//   String text = '';
//   bool boton = false;
//   bool llevar = false;

//   int cantidad = 1;

//   double precio = 0;
//   String precioMuestra = '';

//   List<String> acomps = [];

//   void addAcomps(String text) {
//     acomps.add(text);
//     notifyListeners();
//   }

//   void removeAcomp(String text) {
//     acomps.removeWhere((element) => element == text);
//     notifyListeners();
//   }

//   void changeCantidadPrecio(int c, String p) {
//     if (c > 0) {
//       cantidad = cantidad + c;
//     } else {
//       if (cantidad > 1) {
//         cantidad = cantidad + c;
//       }
//     }

//     var pre = double.parse(p);
//     precio = cantidad * pre;

//     precioMuestra = precio.toStringAsFixed(2);

//     notifyListeners();
//   }

//   void changeBoton(bool b) {
//     boton = b;
//     notifyListeners();
//   }

//   void changeCargando(bool c) {
//     cargando = c;
//     notifyListeners();
//   }

//   void changeText(String t) {
//     text = t;
//     notifyListeners();
//   }

//   void changeLLevar(bool l) {
//     llevar = l;
//     notifyListeners();
//   }
// }
