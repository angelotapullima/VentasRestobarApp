import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ventas_restobar/src/api/comanda_api.dart';
import 'package:ventas_restobar/src/api/comanda_temporal_api.dart';
import 'package:ventas_restobar/src/bloc/provider.dart';
import 'package:ventas_restobar/src/models/productos_familia_model.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';
import 'package:ventas_restobar/src/utils/constants.dart';
import 'package:ventas_restobar/src/utils/utils.dart';
import 'package:ventas_restobar/src/widgets/producto_image.dart';

class AgregarProductoComanda extends StatefulWidget {
  const AgregarProductoComanda({Key key, @required this.producto, @required this.nombreCategoria}) : super(key: key);
  final ProductosFamiliaModel producto;
  final String nombreCategoria;

  @override
  _AgregarProductoComandaState createState() => _AgregarProductoComandaState();
}

class _AgregarProductoComandaState extends State<AgregarProductoComanda> {
  final _controller = ChangeController();
  final TextEditingController _observacionController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.changeCantidadPrecio(0, widget.producto.productoPrecio);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(.5),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Color.fromRGBO(50, 50, 50, 0.9),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(110),
              horizontal: ScreenUtil().setWidth(24),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                      height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                      height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                      height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                      height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
                ),
              ],
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(140),
              horizontal: ScreenUtil().setWidth(70),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(30),
                horizontal: ScreenUtil().setWidth(32),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${widget.nombreCategoria}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: kTitleTextColor,
                                  fontSize: ScreenUtil().setSp(18),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                          iconSize: ScreenUtil().setHeight(30),
                          padding: EdgeInsets.all(0),
                        ),
                      ],
                    ),
                    Container(
                      //padding: EdgeInsets.all(ScreenUtil().setHeight(16)),
                      height: ScreenUtil().setHeight(150),
                      child: Row(
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
                          Container(
                            width: ScreenUtil().setWidth(130),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                Text(
                                  '${widget.producto.productoNombre}',
                                  style: Theme.of(context).textTheme.button.copyWith(
                                        color: kTitleTextColor,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                Spacer(),
                                AnimatedBuilder(
                                    animation: _controller,
                                    builder: (_, p) {
                                      return Text(
                                        'S/${_controller.precioMuestra}',
                                        style: Theme.of(context).textTheme.button.copyWith(
                                              color: kTextColor,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w600,
                                            ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(90),
                          ),
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (_, s) {
                              return Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _controller.changeCantidadPrecio(-1, widget.producto.productoPrecio);
                                    },
                                    child: Container(
                                      height: ScreenUtil().setHeight(40),
                                      child: SvgPicture.asset('assets/svg/minus.svg'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(24),
                                    ),
                                    child: Text(
                                      '${_controller.cantidad}',
                                      style: Theme.of(context).textTheme.button.copyWith(
                                            color: kTitleTextColor,
                                            fontSize: ScreenUtil().setSp(18),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _controller.changeCantidadPrecio(1, widget.producto.productoPrecio);
                                    },
                                    child: Container(
                                      height: ScreenUtil().setHeight(40),
                                      child: SvgPicture.asset('assets/svg/add.svg'),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(90),
                      width: ScreenUtil().setWidth(520),
                      child: TextField(
                        controller: _observacionController,
                        keyboardType: TextInputType.text,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Observaciones',
                          labelStyle: Theme.of(context).textTheme.button.copyWith(
                                color: kTitleTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(14),
                                letterSpacing: 0.16,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: kOrangeTitleTextColor, width: ScreenUtil().setWidth(2)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: kOrangeTitleTextColor, width: ScreenUtil().setWidth(2)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: kOrangeTitleTextColor, width: ScreenUtil().setWidth(2)),
                          ),
                        ),
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: kTitleTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (_, t) {
                            return InkWell(
                              onTap: () {
                                _controller.changeLLevar(!_controller.llevar);
                              },
                              child: (_controller.llevar)
                                  ? Container(
                                      height: ScreenUtil().setHeight(30),
                                      child: SvgPicture.asset('assets/svg/check.svg'),
                                    )
                                  : Container(
                                      height: ScreenUtil().setHeight(30),
                                      width: ScreenUtil().setWidth(23),
                                      decoration: BoxDecoration(
                                        color: Color(0XFFD8D8D8),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                            );
                          },
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(16),
                        ),
                        Text(
                          'Para llevar',
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: kTitleTextColor,
                                fontSize: ScreenUtil().setSp(18),
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(16),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(30),
                          child: SvgPicture.asset('assets/svg/llevar.svg'),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(100),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(230),
                          child: MaterialButton(
                            color: kOrangeTitleTextColor,
                            textColor: Colors.white,
                            elevation: 0,
                            onPressed: () async {
                              _controller.changeCargando(true);
                              final _preferences = Preferences();
                              if (_preferences.esComanda) {
                                final comandaApi = ComandaApi();
                                final res = await comandaApi.agregarProductoAComanda(widget.producto, _controller.cantidad, _controller.precioMuestra,
                                    (_controller.llevar) ? 'PARA LLEVAR' : 'SALON', _observacionController.text);
                                if (res.code == 1) {
                                  final mesasBloc = ProviderBloc.mesas(context);
                                  await mesasBloc.updateMesas(_preferences.indexSelect);
                                  final comandaBloc = ProviderBloc.comanda(context);
                                  comandaBloc.obtenerComandaPorMesa(_preferences.idMesa);
                                  Navigator.pop(context);
                                } else {
                                  showToast2(res.message, Colors.red);
                                }
                              } else {
                                final temporal = ComandaTemporalApi();
                                final res = await temporal.guardarDetalleTemporal(widget.producto, _controller.cantidad, _controller.precioMuestra,
                                    (_controller.llevar) ? 'PARA LLEVAR' : 'SALON', _observacionController.text);
                                if (res.code == 1) {
                                  final comandaBloc = ProviderBloc.comanda(context);
                                  comandaBloc.obtenerComandaTemporal(_preferences.idEnviarEnComanda);
                                  Navigator.pop(context);
                                } else {
                                  showToast2(res.message, Colors.red);
                                }
                              }
                              _controller.changeCargando(false);
                            },
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Guardar',
                              style: Theme.of(context).textTheme.button.copyWith(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(16),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
  }
}

class ChangeController extends ChangeNotifier {
  bool cargando = false;
  String text = '';
  bool boton = false;
  bool llevar = false;

  int cantidad = 1;

  double precio = 0;
  String precioMuestra = '';

  void changeCantidadPrecio(int c, String p) {
    if (c > 0) {
      cantidad = cantidad + c;
    } else {
      if (cantidad > 1) {
        cantidad = cantidad + c;
      }
    }

    var pre = double.parse(p);
    precio = cantidad * pre;

    precioMuestra = precio.toStringAsFixed(2);

    notifyListeners();
  }

  void changeBoton(bool b) {
    boton = b;
    notifyListeners();
  }

  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }

  void changeText(String t) {
    text = t;
    notifyListeners();
  }

  void changeLLevar(bool l) {
    llevar = l;
    notifyListeners();
  }
}
