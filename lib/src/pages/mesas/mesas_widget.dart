import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ventas_restobar/src/bloc/index_mesa_bloc.dart';
import 'package:ventas_restobar/src/bloc/provider.dart';
import 'package:ventas_restobar/src/models/mesas_model.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';
import 'package:ventas_restobar/src/utils/constants.dart';
import 'package:ventas_restobar/src/utils/responsive.dart';

class MesasWidget extends StatefulWidget {
  const MesasWidget({Key key}) : super(key: key);

  @override
  _MesasWidgetState createState() => _MesasWidgetState();
}

int cargaInicial = 0;
final _controller = Controller();

class _MesasWidgetState extends State<MesasWidget> {
  @override
  Widget build(BuildContext context) {
    final _prefs = Preferences();
    final mesasBloc = ProviderBloc.mesas(context);
    if (cargaInicial == 0) {
      mesasBloc.obtenerMesasNegocio(1);
      cargaInicial++;
      _prefs.indexSelect = 1;
    }
    final responsive = Responsive.of(context);
    final provider = Provider.of<IndexMesasBlocListener>(context, listen: false);
    return ValueListenableBuilder(
        valueListenable: provider.vista,
        builder: (BuildContext context, EnumIndex data, Widget child) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(30),
              horizontal: ScreenUtil().setWidth(24),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton(
                      padding: EdgeInsets.all(6),
                      onSelected: (value) {
                        mesasBloc.obtenerMesasNegocio(value);
                        _prefs.indexSelect = value;
                        _controller.changeSelect(value);
                        if (value == 1) {
                          _controller.changeValue('Salón principal');
                        } else {
                          _controller.changeValue('Barra');
                        }

                        mesasBloc.limpiarMesa();
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Salón principal',
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: kTitleTextColor,
                                  fontSize: ScreenUtil().setSp(24),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          value: 1,
                        ),
                        PopupMenuItem(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Barra',
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: kTitleTextColor,
                                  fontSize: ScreenUtil().setSp(24),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          value: 2,
                        ),
                      ],
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            AnimatedBuilder(
                                animation: _controller,
                                builder: (_, t) {
                                  return Text(
                                    _controller.value,
                                    style: Theme.of(context).textTheme.button.copyWith(
                                          color: kTitleTextColor,
                                          fontSize: ScreenUtil().setSp(24),
                                          fontWeight: FontWeight.w600,
                                        ),
                                  );
                                }),
                            SizedBox(
                              width: ScreenUtil().setWidth(2),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0XFFC4C8C9),
                            )
                          ],
                        ),
                      ),
                    ),
                   /*  InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(4),
                          horizontal: ScreenUtil().setWidth(10),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kOrangeColor,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Text(
                              'Unir mesas',
                              style: Theme.of(context).textTheme.button.copyWith(
                                    color: kOrangeColor,
                                    fontSize: ScreenUtil().setSp(16),
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            Container(height: ScreenUtil().setHeight(24), child: SvgPicture.asset('assets/svg/plus_orange.svg'))
                          ],
                        ),
                      ),
                    )
                   */],
                ),
                AnimatedBuilder(
                    animation: _controller,
                    builder: (context, snapshot) {
                      return Expanded(
                        child: (_controller.select == 1)
                            ? StreamBuilder(
                                stream: mesasBloc.mesasSalonStream,
                                builder: (context, AsyncSnapshot<List<MesaModel>> snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.length > 0) {
                                      var datos = snapshot.data;
                                      return GridView.builder(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: responsive.wp(1),
                                          ),
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 1,
                                            mainAxisSpacing: responsive.hp(0),
                                            crossAxisSpacing: responsive.wp(1),
                                          ),
                                          itemCount: datos.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (BuildContext context, int index) {
                                            return LayoutBuilder(builder: (context, constraints) {
                                              Color color = Color(0XFF5FC52F);
                                              Color color2 = Color(0XFF47D106);
                                              String texto = 'Disponible';
                                              if (datos[index].mesaEstadoAtencion == '1') {
                                                color = Color(0XFFFFDE2F);
                                                color2 = Color(0XFFFFD233);
                                                texto = 'Ocupado';
                                              }
                                              if (datos[index].mesaEstadoAtencion == '2') {
                                                color = Color(0XFFFF1F1F);
                                                color2 = Color(0XFFFB5757);
                                                texto = 'Limpiar';
                                              }

                                              if (datos[index].mesaEstadoAtencion == '5') {
                                                color = Color(0XFF48BDFF);
                                                color2 = Color(0XFF9EDCFF);
                                                texto = 'Reservado';
                                              }

                                              return InkWell(
                                                onTap: () {
                                                  print('Tap');
                                                  mesasBloc.obtenerDetalleMesa(datos[index].idMesa);
                                                  _prefs.idMesa = datos[index].idMesa;
                                                },
                                                child: Container(
                                                  width: constraints.maxWidth,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: constraints.maxWidth * 0.12,
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  color: color,
                                                                  borderRadius: BorderRadius.circular(5),
                                                                ),
                                                                height: constraints.maxHeight * 0.12,
                                                                width: constraints.maxWidth * 0.2,
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  color: color,
                                                                  borderRadius: BorderRadius.circular(5),
                                                                ),
                                                                height: constraints.maxHeight * 0.12,
                                                                width: constraints.maxWidth * 0.2,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: responsive.wp(.5),
                                                      ),
                                                      Container(
                                                        height: constraints.maxHeight * 0.6,
                                                        width: constraints.maxWidth * 0.75 - responsive.wp(2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          gradient: LinearGradient(
                                                            begin: Alignment.bottomLeft,
                                                            end: Alignment.topRight,
                                                            colors: [
                                                              color2,
                                                              color,
                                                            ],
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                            horizontal: responsive.wp(.5),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Spacer(),
                                                              Center(
                                                                child: (datos[index].idMesa == '0')
                                                                    ? Container(
                                                                        height: ScreenUtil().setHeight(72),
                                                                        width: ScreenUtil().setWidth(72),
                                                                        child: SvgPicture.asset('assets/svg/delivery.svg'),
                                                                      )
                                                                    : Text(
                                                                        '${datos[index].mesaNombre}',
                                                                        style: TextStyle(
                                                                          fontSize: ScreenUtil().setSp(32),
                                                                          color: Colors.white,
                                                                          fontWeight: FontWeight.w600,
                                                                        ),
                                                                      ),
                                                              ),
                                                              Spacer(),
                                                              Center(
                                                                child: Text(
                                                                  texto,
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: ScreenUtil().setSp(16)),
                                                                ),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: responsive.wp(.5),
                                                      ),
                                                      Container(
                                                        width: constraints.maxWidth * 0.12,
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  color: color,
                                                                  borderRadius: BorderRadius.circular(5),
                                                                ),
                                                                height: constraints.maxHeight * 0.12,
                                                                width: constraints.maxWidth * 0.2,
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  color: color,
                                                                  borderRadius: BorderRadius.circular(5),
                                                                ),
                                                                height: constraints.maxHeight * 0.12,
                                                                width: constraints.maxWidth * 0.2,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                          });
                                    } else {
                                      return Center(
                                        child: Text('Sin mesas'),
                                      );
                                    }
                                  } else {
                                    return Center(
                                      child: Text('Cargando...'),
                                    );
                                  }
                                },
                              )
                            : StreamBuilder(
                                stream: mesasBloc.mesasBarraStream,
                                builder: (context, AsyncSnapshot<List<MesaModel>> snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.length > 0) {
                                      var datos = snapshot.data;
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: ScreenUtil().setHeight(272),
                                                  width: ScreenUtil().setWidth(184),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: ScreenUtil().setHeight(272),
                                                        width: ScreenUtil().setWidth(80),
                                                        child: Column(
                                                          children: [
                                                            circles(context, datos[0]),
                                                            SizedBox(height: ScreenUtil().setHeight(64)),
                                                            circles(context, datos[1]),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: ScreenUtil().setHeight(272),
                                                        width: ScreenUtil().setWidth(80),
                                                        decoration: BoxDecoration(
                                                            color: kOrangeColor,
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(16),
                                                              topRight: Radius.circular(16),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(220),
                                                ),
                                                Container(
                                                  height: ScreenUtil().setHeight(272),
                                                  width: ScreenUtil().setWidth(184),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: ScreenUtil().setHeight(272),
                                                        width: ScreenUtil().setWidth(80),
                                                        decoration: BoxDecoration(
                                                            color: kOrangeColor,
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(16),
                                                              topRight: Radius.circular(16),
                                                            )),
                                                      ),
                                                      Container(
                                                        height: ScreenUtil().setHeight(272),
                                                        width: ScreenUtil().setWidth(80),
                                                        child: Column(
                                                          children: [
                                                            circles(context, datos[8]),
                                                            SizedBox(height: ScreenUtil().setHeight(64)),
                                                            circles(context, datos[7]),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                circles(context, datos[2]),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(24),
                                                ),
                                                Container(
                                                  height: ScreenUtil().setHeight(100),
                                                  width: ScreenUtil().setWidth(380),
                                                  decoration: BoxDecoration(
                                                      color: kOrangeColor,
                                                      borderRadius: BorderRadius.only(
                                                        bottomLeft: Radius.circular(16),
                                                        bottomRight: Radius.circular(16),
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(24),
                                                ),
                                                circles(context, datos[6]),
                                              ],
                                            ),
                                            SizedBox(height: ScreenUtil().setHeight(24)),
                                            Container(
                                              height: ScreenUtil().setHeight(80),
                                              width: ScreenUtil().setWidth(380),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  circles(context, datos[3]),
                                                  circles(context, datos[4]),
                                                  circles(context, datos[5]),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: Text('Sin mesas'),
                                      );
                                    }
                                  } else {
                                    return Center(
                                      child: Text('Cargando...'),
                                    );
                                  }
                                },
                              ),
                      );
                    }),
              ],
            ),
          );
        });
  }

  Widget circles(BuildContext context, MesaModel mesa) {
    Color color = Color(0XFF5FC52F);
    Color color2 = Color(0XFF47D106);
    String texto = 'Disponible';
    if (mesa.mesaEstadoAtencion == '1') {
      color = Color(0XFFFFDE2F);
      color2 = Color(0XFFFFD233);
      texto = 'Ocupado';
    }
    if (mesa.mesaEstadoAtencion == '2') {
      color = Color(0XFFFF1F1F);
      color2 = Color(0XFFFB5757);
      texto = 'Limpiar';
    }

    if (mesa.mesaEstadoAtencion == '5') {
      color = Color(0XFF48BDFF);
      color2 = Color(0XFF9EDCFF);
      texto = 'Reservado';
    }
    return InkWell(
      onTap: () {
        final _prefs = Preferences();
        final mesasBloc = ProviderBloc.mesas(context);
        print('Tap');
        mesasBloc.obtenerDetalleMesa(mesa.idMesa);
        _prefs.idMesa = mesa.idMesa;
      },
      child: Container(
        width: ScreenUtil().setWidth(80),
        height: ScreenUtil().setHeight(80),
        decoration: BoxDecoration(
          color: kOrangeColor,
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              color2,
              color,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mesa.mesaNombre,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              texto,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(11),
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Controller extends ChangeNotifier {
  String value = 'Salón principal';
  int select = 1;

  void changeValue(String v) {
    value = v;
    notifyListeners();
  }

  void changeSelect(int s) {
    select = s;
    notifyListeners();
  }
}
