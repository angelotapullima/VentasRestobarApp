import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ventas_restobar/src/bloc/index_mesa_bloc.dart';
import 'package:ventas_restobar/src/pages/mesas/detalle_mesa_widget.dart';
import 'package:ventas_restobar/src/pages/mesas/mesas_widget.dart';
import 'package:ventas_restobar/src/pages/mesas/productos_widget.dart';

class MesasPage extends StatelessWidget {
  const MesasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IndexMesasBlocListener>(context, listen: false);
    return ValueListenableBuilder(
        valueListenable: provider.vista,
        builder: (BuildContext context, EnumIndex data, Widget child) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0XFFE9EEF6),
            ),
            child: Stack(
              children: [
                //MOSTRAR FONDO Y CIRCULOS DE MESAS
                Row(
                  children: [
                    (data == EnumIndex.mesas)
                        ? Container(
                            width: ScreenUtil().setWidth(769),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: -5,
                                  left: -20,
                                  child: Container(
                                      height: ScreenUtil().setHeight(100),
                                      width: ScreenUtil().setWidth(100),
                                      child: SvgPicture.asset('assets/svg/circles.svg')),
                                ),
                                Positioned(
                                  bottom: -5,
                                  left: -20,
                                  child: Container(
                                      height: ScreenUtil().setHeight(100),
                                      width: ScreenUtil().setWidth(100),
                                      child: SvgPicture.asset('assets/svg/circles.svg')),
                                ),
                                Positioned(
                                  bottom: -5,
                                  right: 0,
                                  child: Container(
                                      height: ScreenUtil().setHeight(100),
                                      width: ScreenUtil().setWidth(100),
                                      child: SvgPicture.asset('assets/svg/circles.svg')),
                                ),
                                Positioned(
                                  top: -5,
                                  right: 0,
                                  child: Container(
                                      height: ScreenUtil().setHeight(100),
                                      width: ScreenUtil().setWidth(100),
                                      child: SvgPicture.asset('assets/svg/circles.svg')),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: ScreenUtil().setWidth(769),
                            child: Row(
                              children: [
                                Container(
                                  width: ScreenUtil().setWidth(410),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: -5,
                                        left: -20,
                                        child: Container(
                                            height: ScreenUtil().setHeight(100),
                                            width: ScreenUtil().setWidth(100),
                                            child: SvgPicture.asset('assets/svg/circles.svg')),
                                      ),
                                      Positioned(
                                        bottom: -5,
                                        left: -20,
                                        child: Container(
                                            height: ScreenUtil().setHeight(100),
                                            width: ScreenUtil().setWidth(100),
                                            child: SvgPicture.asset('assets/svg/circles.svg')),
                                      ),
                                      Positioned(
                                        bottom: -5,
                                        right: 0,
                                        child: Container(
                                            height: ScreenUtil().setHeight(100),
                                            width: ScreenUtil().setWidth(100),
                                            child: SvgPicture.asset('assets/svg/circles.svg')),
                                      ),
                                      Positioned(
                                        top: -5,
                                        right: 0,
                                        child: Container(
                                            height: ScreenUtil().setHeight(100),
                                            width: ScreenUtil().setWidth(100),
                                            child: SvgPicture.asset('assets/svg/circles.svg')),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(355),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: -5,
                                        right: 0,
                                        child: Container(
                                            height: ScreenUtil().setHeight(100),
                                            width: ScreenUtil().setWidth(100),
                                            child: SvgPicture.asset('assets/svg/circles.svg')),
                                      ),
                                      Positioned(
                                        top: -5,
                                        right: 0,
                                        child: Container(
                                            height: ScreenUtil().setHeight(100),
                                            width: ScreenUtil().setWidth(100),
                                            child: SvgPicture.asset('assets/svg/circles.svg')),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                    Container(
                      width: ScreenUtil().setWidth(254),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -5,
                            right: -10,
                            child: Container(
                                height: ScreenUtil().setHeight(100),
                                width: ScreenUtil().setWidth(100),
                                child: SvgPicture.asset('assets/svg/circles.svg')),
                          ),
                          Positioned(
                            top: -5,
                            right: -10,
                            child: Container(
                                height: ScreenUtil().setHeight(100),
                                width: ScreenUtil().setWidth(100),
                                child: SvgPicture.asset('assets/svg/circles.svg')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    //MOSTRAR LISTADO MESAS
                    (data == EnumIndex.mesas)
                        ? Container(
                            width: ScreenUtil().setWidth(700),
                            child: Container(
                              margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(32),
                                right: ScreenUtil().setWidth(10),
                                bottom: ScreenUtil().setHeight(32),
                                left: ScreenUtil().setWidth(10),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: MesasWidget(),
                            ),
                          )
                        : Container(
                            width: ScreenUtil().setWidth(700),
                            child: Container(
                              margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(32),
                                right: ScreenUtil().setWidth(10),
                                bottom: ScreenUtil().setHeight(32),
                                left: ScreenUtil().setWidth(10),
                              ),
                              child: ProductoFamilia2(),
                            ),
                          ),
                    //MOSTRAR CARD DETALLE MESA
                    Container(
                      width: ScreenUtil().setWidth(310),
                      child: Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(32),
                          right: ScreenUtil().setWidth(10),
                          bottom: ScreenUtil().setHeight(32),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DetalleMesa(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
