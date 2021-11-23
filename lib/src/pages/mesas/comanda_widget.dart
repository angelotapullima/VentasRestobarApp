import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ventas_restobar/src/bloc/index_mesa_bloc.dart';
import 'package:ventas_restobar/src/bloc/provider.dart';
import 'package:ventas_restobar/src/models/comanda_model.dart';
import 'package:ventas_restobar/src/utils/constants.dart';
import 'package:ventas_restobar/src/widgets/producto_image.dart';

class ComandaWidget extends StatelessWidget {
  const ComandaWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  var datos = snapshot.data;

                  return (datos[0].detalleComanda.length > 0)
                      ? Expanded(
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
                                                  color: kTitleTextColor,
                                                  fontSize: ScreenUtil().setSp(16),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Container();
                } else {
                  return Expanded(
                    child: Stack(
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
                          bottom: 0,
                          left: 0,
                          right: 0,
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
                                } else {
                                  provider.changeToMesas();
                                  final detalleMesaBloc = ProviderBloc.mesas(context);
                                  detalleMesaBloc.limpiarMesa();
                                }
                              },
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              child: (data == EnumIndex.mesas)
                                  ? Row(
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
                                    )
                                  : Text(
                                      'Volver',
                                      style: Theme.of(context).textTheme.button.copyWith(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(16),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                            ),
                          ),
                        ),
                      ],
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
