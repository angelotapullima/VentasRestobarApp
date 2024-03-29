import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ventas_restobar/src/bloc/index_mesa_bloc.dart';
import 'package:ventas_restobar/src/bloc/provider.dart';
import 'package:ventas_restobar/src/models/familias_model.dart';
import 'package:ventas_restobar/src/models/productos_familia_model.dart';
import 'package:ventas_restobar/src/pages/mesas/agregar_productos_comanda_acompanamiento.dart';
import 'package:ventas_restobar/src/pages/mesas/agregrar_producto_comanda.dart';
//import 'package:ventas_restobar/src/pages/mesas/agregrar_producto_comanda.dart';
import 'package:ventas_restobar/src/utils/constants.dart';

class ProductoFamilia2 extends StatefulWidget {
  const ProductoFamilia2({Key? key}) : super(key: key);

  @override
  _ProductoFamilia2State createState() => _ProductoFamilia2State();
}

class _ProductoFamilia2State extends State<ProductoFamilia2> {
  final _controller = IndexController();
  @override
  Widget build(BuildContext context) {
    final familiasBloc = ProviderBloc.familias(context);
    familiasBloc.obtenerFamilias();
    final provider = Provider.of<IndexMesasBlocListener>(context, listen: false);
    final productosFamiliaBloc = ProviderBloc.productos(context);
    return ValueListenableBuilder(
        valueListenable: provider.vista,
        builder: (BuildContext context, EnumIndex data, Widget? child) {
          return Row(
            children: [
              Container(
                width: ScreenUtil().setWidth(328),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: ScreenUtil().setHeight(24),
                        ),
                        Text(
                          'Categorías',
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: kTitleTextColor,
                                fontSize: ScreenUtil().setSp(24),
                                fontWeight: FontWeight.w600,
                              ),
                        )
                      ],
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: familiasBloc.familiasStream,
                        builder: (context, AsyncSnapshot<List<FamiliasModel>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.length > 0) {
                              var datos = snapshot.data;
                              if (_controller.index == 0) {
                                _controller.changeCategoria(datos![0].familiaNombre.toString());
                                productosFamiliaBloc.obtenerProductosPorIdFamilia(datos[0].idFamilia.toString());
                              }

                              return ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                                  itemCount: datos!.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        productosFamiliaBloc.obtenerProductosPorIdFamilia(datos[index].idFamilia.toString());
                                        _controller.channgeIndex(index);
                                        _controller.changeCategoria(datos[index].familiaNombre.toString());
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
                                        child: AnimatedBuilder(
                                            animation: _controller,
                                            builder: (_, s) {
                                              return Container(
                                                  padding: EdgeInsets.all(ScreenUtil().setHeight(16)),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: (_controller.index == index) ? Color(0XFFFFE4D0) : Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: ScreenUtil().setHeight(60),
                                                        child: SvgPicture.asset('assets/svg/fire.svg'),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenUtil().setWidth(24),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${datos[index].familiaNombre}',
                                                          style: Theme.of(context).textTheme.button!.copyWith(
                                                                color: kTitleTextColor,
                                                                fontSize: ScreenUtil().setSp(22),
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                        ),
                                                      )
                                                    ],
                                                  ));
                                            }),
                                      ),
                                    );
                                  });
                            } else {
                              return Center(
                                child: Text(
                                  'Sin categorías',
                                  style: Theme.of(context).textTheme.button!.copyWith(
                                        color: kTitleTextColor,
                                        fontSize: ScreenUtil().setSp(20),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              );
                            }
                          } else {
                            return Center(
                              child: Text(
                                'Cargando...',
                                style: Theme.of(context).textTheme.button!.copyWith(
                                      color: kTitleTextColor,
                                      fontSize: ScreenUtil().setSp(20),
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(10),
              ),
              Container(
                width: ScreenUtil().setWidth(328),
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(30),
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Productos',
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  color: kTitleTextColor,
                                  fontSize: ScreenUtil().setSp(24),
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(24),
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: productosFamiliaBloc.productosFamiliaStream,
                          builder: (context, AsyncSnapshot<List<ProductosFamiliaModel>> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.length > 0) {
                                var datos = snapshot.data!;
                                return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: datos.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return _productossItem(datos[index]);
                                    });
                              } else {
                                return Center(
                                  child: Text(
                                    'Sin productos para esta categoría',
                                    style: Theme.of(context).textTheme.button!.copyWith(
                                          color: kTitleTextColor,
                                          fontSize: ScreenUtil().setSp(20),
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                );
                              }
                            } else {
                              return Center(
                                child: Text(
                                  'Cargando...',
                                  style: Theme.of(context).textTheme.button!.copyWith(
                                        color: kTitleTextColor,
                                        fontSize: ScreenUtil().setSp(20),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _productossItem(ProductosFamiliaModel item) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
        child: Container(
          margin: EdgeInsets.all(8),
          width: double.infinity,
          //height: ScreenUtil().setHeight(150),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: ScreenUtil().setHeight(100),
                width: ScreenUtil().setWidth(100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0XFF808080).withOpacity(0.25),
                      blurRadius: 0.4,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: ScreenUtil().setHeight(75),
                        width: ScreenUtil().setWidth(75),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0XFF808080).withOpacity(0.25),
                              blurRadius: 0.4,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: ScreenUtil().setHeight(50),
                        child: SvgPicture.asset('assets/svg/cubiertos.svg'),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.productoNombre}',
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: kTitleTextColor,
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'S/${item.productoPrecio}',
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: kTextColor,
                                fontSize: ScreenUtil().setSp(20),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        //SizedBox(width: ScreenUtil().setWidth(10)),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            //TODO NO FITZCA
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return AgregarProductoComanda(
                                    producto: item,
                                    nombreCategoria: _controller.categoria,
                                  );
                                },
                              ),
                            );

                            //**************** TODO Fizcarraldo *********************//
                            // Navigator.push(
                            //   context,
                            //   PageRouteBuilder(
                            //     opaque: false,
                            //     pageBuilder: (context, animation, secondaryAnimation) {
                            //       return AgregarProductoComandaAcompanamiento(
                            //         producto: item,
                            //         nombreCategoria: _controller.categoria,
                            //       );
                            //     },
                            //   ),
                            // );
                            //****************/////////////*********************//
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(40),
                            height: ScreenUtil().setHeight(40),
                            child: SvgPicture.asset('assets/svg/add.svg'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IndexController extends ChangeNotifier {
  int index = 0;
  String categoria = 'Productos';
  void channgeIndex(int i) {
    index = i;
    notifyListeners();
  }

  void changeCategoria(String c) {
    categoria = c;
    notifyListeners();
  }
}
