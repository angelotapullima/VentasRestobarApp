import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ventas_restobar/src/api/comanda_api.dart';
import 'package:ventas_restobar/src/api/comanda_temporal_api.dart';
import 'package:ventas_restobar/src/bloc/index_mesa_bloc.dart';
import 'package:ventas_restobar/src/bloc/provider.dart';
import 'package:ventas_restobar/src/models/comanda_model.dart';
import 'package:ventas_restobar/src/models/detalle_comanda_temporal_model.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';
import 'package:ventas_restobar/src/utils/constants.dart';
import 'package:ventas_restobar/src/utils/utils.dart';
import 'package:ventas_restobar/src/widgets/producto_image.dart';

class ComandaWidget extends StatefulWidget {
  final String idMesa;
  const ComandaWidget({Key key, @required this.idMesa}) : super(key: key);

  @override
  _ComandaWidgetState createState() => _ComandaWidgetState();
}

class _ComandaWidgetState extends State<ComandaWidget> {
  final _controller = Controller();
  @override
  Widget build(BuildContext context) {
    final _prefs = Preferences();
    final comandaBloc = ProviderBloc.comanda(context);
    final provider = Provider.of<IndexMesasBlocListener>(context, listen: false);
    return ValueListenableBuilder(
      valueListenable: provider.vista,
      builder: (BuildContext context, EnumIndex data, Widget child) {
        return StreamBuilder(
            stream: comandaBloc.comandaPorMesaStream,
            builder: (context, AsyncSnapshot<List<ComandaModel>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  double total = 0.00;
                  var datos = snapshot.data;
                  _prefs.idEnviarEnComanda = datos[0].idComanda;
                  _prefs.esComanda = true;
                  for (var i = 0; i < datos[0].detalleComanda.length; i++) {
                    total = total + double.parse(datos[0].detalleComanda[i].totalDetalle);
                  }
                  return (datos[0].detalleComanda.length > 0)
                      ? Expanded(
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(16),
                                  right: ScreenUtil().setWidth(16),
                                  bottom: ScreenUtil().setHeight(120),
                                ),
                                child: ListView.builder(
                                  itemCount: datos[0].detalleComanda.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ProductoImage(
                                                himage: 20,
                                                hmax: 40,
                                                wmax: 40,
                                                hmin: 30,
                                                wmin: 30,
                                                image: (datos[0].detalleComanda[index].llevar == 'PARA LLEVAR') ? 'llevar' : 'cubiertos',
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(105),
                                                child: Text(
                                                  '${datos[0].detalleComanda[index].nombreProducto}',
                                                  style: Theme.of(context).textTheme.button.copyWith(
                                                        color: kTitleTextColor,
                                                        fontSize: ScreenUtil().setSp(16),
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                ),
                                              ),
                                              Text(
                                                'X ${datos[0].detalleComanda[index].cantidad}',
                                                style: Theme.of(context).textTheme.button.copyWith(
                                                      color: kTitleTextColor,
                                                      fontSize: ScreenUtil().setSp(16),
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                              ),
                                              Text(
                                                'S/${datos[0].detalleComanda[index].totalDetalle}',
                                                style: Theme.of(context).textTheme.button.copyWith(
                                                      color: kTextColor,
                                                      fontSize: ScreenUtil().setSp(14),
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  width: double.infinity,
                                  height: ScreenUtil().setWidth(120),
                                  decoration: BoxDecoration(
                                    color: Color(0XFF48BDFF),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setHeight(15),
                                      horizontal: ScreenUtil().setWidth(16),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Total',
                                              style: Theme.of(context).textTheme.button.copyWith(
                                                    color: Colors.white,
                                                    fontSize: ScreenUtil().setSp(16),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setWidth(16),
                                            ),
                                            Text(
                                              'S/ ${total.toStringAsFixed(2)}',
                                              style: Theme.of(context).textTheme.button.copyWith(
                                                    color: Colors.white,
                                                    fontSize: ScreenUtil().setSp(16),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          child: MaterialButton(
                                            height: ScreenUtil().setHeight(36),
                                            color: kOrangeColor,
                                            textColor: Colors.white,
                                            elevation: 0,
                                            onPressed: () {
                                              if (data == EnumIndex.mesas) {
                                                provider.changeToProductos();
                                              }
                                            },
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: ScreenUtil().setHeight(24),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(10),
                                                ),
                                                Text(
                                                  'Agregar productos',
                                                  style: Theme.of(context).textTheme.button.copyWith(
                                                        color: Colors.white,
                                                        fontSize: ScreenUtil().setSp(16),
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container();
                } else {
                  _prefs.idEnviarEnComanda = widget.idMesa;
                  _prefs.esComanda = false;
                  comandaBloc.obtenerComandaTemporal(widget.idMesa);
                  return Expanded(
                    child: StreamBuilder(
                      stream: comandaBloc.comandaTemporalStream,
                      builder: (context, AsyncSnapshot<List<DetalleComandaTemporalModel>> snapshot2) {
                        if (snapshot2.hasData) {
                          if (snapshot2.data.length > 0) {
                            var datitos = snapshot2.data;
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(16),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      bottom: ScreenUtil().setHeight(90),
                                    ),
                                    child: ListView.builder(
                                      itemCount: datitos.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  ProductoImage(
                                                    himage: 20,
                                                    hmax: 40,
                                                    wmax: 40,
                                                    hmin: 30,
                                                    wmin: 30,
                                                    image: (datitos[index].despacho == 'PARA LLEVAR') ? 'llevar' : 'cubiertos',
                                                  ),
                                                  Container(
                                                    width: ScreenUtil().setWidth(80),
                                                    child: Text(
                                                      '${datitos[index].nombreProducto}',
                                                      style: Theme.of(context).textTheme.button.copyWith(
                                                            color: kTitleTextColor,
                                                            fontSize: ScreenUtil().setSp(16),
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              final apiTemporal = ComandaTemporalApi();

                                                              final res = await apiTemporal.updateDetalle(datitos[index], -1);

                                                              if (res.code == 1) {
                                                                comandaBloc.obtenerComandaTemporal(widget.idMesa);
                                                              } else {
                                                                showToast2('Ocurrió un error', Colors.red);
                                                              }
                                                            },
                                                            child: Container(
                                                              height: ScreenUtil().setHeight(24),
                                                              child: SvgPicture.asset('assets/svg/minus_on.svg'),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.symmetric(
                                                              horizontal: ScreenUtil().setWidth(8),
                                                            ),
                                                            child: Text(
                                                              '${datitos[index].cantidad}',
                                                              textAlign: TextAlign.center,
                                                              style: Theme.of(context).textTheme.button.copyWith(
                                                                    color: kTitleTextColor,
                                                                    fontSize: ScreenUtil().setSp(14),
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              final apiTemporal = ComandaTemporalApi();

                                                              final res = await apiTemporal.updateDetalle(datitos[index], 1);

                                                              if (res.code == 1) {
                                                                comandaBloc.obtenerComandaTemporal(widget.idMesa);
                                                              } else {
                                                                showToast2('Ocurrió un error', Colors.red);
                                                              }
                                                            },
                                                            child: Container(
                                                              height: ScreenUtil().setHeight(24),
                                                              child: SvgPicture.asset('assets/svg/add.svg'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: ScreenUtil().setHeight(8),
                                                      ),
                                                      Text(
                                                        'S/${datitos[index].totalDetalle}',
                                                        style: Theme.of(context).textTheme.button.copyWith(
                                                              color: kTextColor,
                                                              fontSize: ScreenUtil().setSp(14),
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                      )
                                                    ],
                                                  ),
                                                  // Text(
                                                  //   'X ${datitos[index].cantidad}',
                                                  //   style: Theme.of(context).textTheme.button.copyWith(
                                                  //         color: kTitleTextColor,
                                                  //         fontSize: ScreenUtil().setSp(16),
                                                  //         fontWeight: FontWeight.w400,
                                                  //       ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: MaterialButton(
                                            height: ScreenUtil().setHeight(36),
                                            color: kOrangeColor,
                                            textColor: Colors.white,
                                            elevation: 0,
                                            onPressed: () async {
                                              _controller.changeCargando(true);
                                              final comandaApi = ComandaApi();
                                              final res = await comandaApi.generarComanda(widget.idMesa);
                                              if (res.code == 1) {
                                                // final apiMesas = MesasApi();
                                                // await apiMesas.obtenerMesasPorNegocio();
                                                final _prefs = Preferences();
                                                final mesasBloc = ProviderBloc.mesas(context);
                                                await mesasBloc.updateMesas(_prefs.indexSelect);
                                                comandaBloc.obtenerComandaPorMesa(widget.idMesa);
                                              } else {
                                                showToast2(res.message, Colors.red);
                                              }
                                              _controller.changeCargando(false);
                                            },
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                            ),
                                            child: Text(
                                              'Generar comanda',
                                              style: Theme.of(context).textTheme.button.copyWith(
                                                    color: Colors.white,
                                                    fontSize: ScreenUtil().setSp(16),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        (data == EnumIndex.mesas)
                                            ? SizedBox(
                                                width: double.infinity,
                                                child: MaterialButton(
                                                  height: ScreenUtil().setHeight(36),
                                                  color: kOrangeColor,
                                                  textColor: Colors.white,
                                                  elevation: 0,
                                                  onPressed: () {
                                                    if (data == EnumIndex.mesas) {
                                                      provider.changeToProductos();
                                                    }
                                                  },
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(8.0),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: ScreenUtil().setHeight(24),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenUtil().setWidth(10),
                                                      ),
                                                      Text(
                                                        'Agregar productos',
                                                        style: Theme.of(context).textTheme.button.copyWith(
                                                              color: Colors.white,
                                                              fontSize: ScreenUtil().setSp(16),
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  AnimatedBuilder(
                                    animation: _controller,
                                    builder: (_, f) {
                                      return (_controller.cargando)
                                          ? Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              color: Color.fromRGBO(0, 0, 0, 0.1),
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  color: kOrangeTitleTextColor,
                                                ),
                                              ),
                                            )
                                          : Container();
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ProductoImage(
                                        himage: 50,
                                        hmax: 100,
                                        wmax: 100,
                                        hmin: 75,
                                        wmin: 75,
                                        image: 'cubiertos',
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setWidth(24),
                                      ),
                                      Text(
                                        'Agregue productos a la mesa',
                                        style: Theme.of(context).textTheme.button.copyWith(
                                              color: kTitleTextColor,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  left: 16,
                                  right: 16,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: MaterialButton(
                                      height: ScreenUtil().setHeight(36),
                                      color: kOrangeColor,
                                      textColor: Colors.white,
                                      elevation: 0,
                                      onPressed: () {
                                        if (data == EnumIndex.mesas) {
                                          provider.changeToProductos();
                                        }
                                      },
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: ScreenUtil().setHeight(24),
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(10),
                                          ),
                                          Text(
                                            'Agregar productos',
                                            style: Theme.of(context).textTheme.button.copyWith(
                                                  color: Colors.white,
                                                  fontSize: ScreenUtil().setSp(16),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        } else {
                          return Center(
                            child: Text(
                              'Cargando...',
                              style: Theme.of(context).textTheme.button.copyWith(
                                    color: kTitleTextColor,
                                    fontSize: ScreenUtil().setSp(16),
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }
              } else {
                return Expanded(
                  child: Center(
                    child: Text(
                      'Cargando...',
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: kTitleTextColor,
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                );
              }
            });
      },
    );
  }
}

class Controller extends ChangeNotifier {
  bool cargando = false;
  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }
}
