import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ventas_restobar/src/bloc/index_mesa_bloc.dart';
import 'package:ventas_restobar/src/bloc/provider.dart';
import 'package:ventas_restobar/src/models/mesas_model.dart';
import 'package:ventas_restobar/src/pages/mesas/comanda_widget.dart';
import 'package:ventas_restobar/src/pages/mesas/mover_mesa_page.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';
import 'package:ventas_restobar/src/utils/constants.dart';

class DetalleMesa extends StatefulWidget {
  const DetalleMesa({Key key}) : super(key: key);

  @override
  _DetalleMesaState createState() => _DetalleMesaState();
}

class _DetalleMesaState extends State<DetalleMesa> {
  @override
  Widget build(BuildContext context) {
    final detalleMesaBloc = ProviderBloc.mesas(context);
    final comandaBloc = ProviderBloc.comanda(context);
    final provider = Provider.of<IndexMesasBlocListener>(context, listen: false);
    return StreamBuilder(
      stream: detalleMesaBloc.mesDetalleStream,
      builder: (context, AsyncSnapshot<List<MesaModel>> snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          var mesa = snapshot.data;
          comandaBloc.obtenerComandaPorMesa(mesa[0].idMesa);
          return Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(16),
                ),
                height: ScreenUtil().setHeight(40),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '${mesa[0].mesaNombre}',
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: Colors.transparent,
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: kOrangeColor,
                                  decorationThickness: 4,
                                ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${mesa[0].mesaNombre}',
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: kTitleTextColor,
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    (mesa[0].mesaEstadoAtencion == '1')
                        ? InkWell(
                            onTap: () {
                              detalleMesaBloc.obtenerMesasDisponibles();
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return MoverMesaPage(
                                      mesa: mesa[0],
                                    );
                                  },
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    var begin = Offset(0.0, 1.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end).chain(
                                      CurveTween(curve: curve),
                                    );

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Mover mesa',
                              style: Theme.of(context).textTheme.button.copyWith(
                                    color: kOrangeColor,
                                    fontSize: ScreenUtil().setSp(10),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          )
                        : Container(),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        provider.changeToMesas();
                        final detalleMesaBloc = ProviderBloc.mesas(context);

                        detalleMesaBloc.limpiarMesa();
                      },
                      icon: Icon(Icons.close),
                      iconSize: ScreenUtil().setHeight(30),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(16),
              ),
              ComandaWidget(
                idMesa: mesa[0].idMesa,
                estadoAtencion: mesa[0].mesaEstadoAtencion,
              ),
            ],
          );
        } else {
          final _prefs = Preferences();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Center(
                child: Text(
                  (_prefs.indexSelect == 1) ? 'Toque sobre una mesa para ver los detalles' : 'Toque sobre una banca para ver los detalles',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: kTitleTextColor,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(300),
                child: Stack(
                  children: [
                    (_prefs.indexSelect == 1)
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: ScreenUtil().setHeight(150),
                              //width: ScreenUtil().setWidth(300),
                              child: SvgPicture.asset('assets/svg/mesa_disable.svg'),
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: ScreenUtil().setHeight(100),
                              width: ScreenUtil().setWidth(100),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0XFFC4C4C4),
                              ),
                            ),
                          ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: ScreenUtil().setHeight(270),
                        child: Image.asset('assets/img/hand.png'),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          );
        }
      },
    );
  }
}
