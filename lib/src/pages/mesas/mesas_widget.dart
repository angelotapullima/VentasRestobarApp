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
                        if (value == 1) {
                          _controller.changeValue('Salón principal');
                        } else {
                          _controller.changeValue('Barra');
                        }
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
                    Container(
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
                    )
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: mesasBloc.mesasStream,
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
                                    // if (index == 0) {
                                    //   color = Color(0XFF5FC52F);
                                    //   color2 = Color(0XFF47D106);
                                    //   texto = 'Disponible';
                                    // }
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
                                                            color: Colors.white, fontWeight: FontWeight.w500, fontSize: ScreenUtil().setSp(16)),
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
                      }),
                ),
              ],
            ),
          );
        });
  }
}

class Controller extends ChangeNotifier {
  String value = 'Salón principal';

  void changeValue(String v) {
    value = v;
    notifyListeners();
  }
}
