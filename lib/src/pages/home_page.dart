import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ventas_restobar/src/bloc/index_bloc.dart';
import 'package:ventas_restobar/src/pages/mesas/mesas_page.dart';
import 'package:ventas_restobar/src/pages/tablet/side_menu.dart';
import 'package:ventas_restobar/src/utils/responsive.dart';
import 'package:ventas_restobar/src/utils/responsive_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final prefs = Preferences();
    // final locacionBloc = ProviderBloc.locacion(context);
    // locacionBloc.obtenerLocacionesPorIdTienda(prefs.tiendaId, context);

    // final mesasBloc = ProviderBloc.mesas(context);

    // final preferences = Preferences();

    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      body: Stack(
        children: [
          ResponsiveBuilder(
            mobile: VistaTablet(),
            tablet: VistaTablet(),
            desktop: VistaTablet(),
          ),
          // StreamBuilder(
          //   stream: mesasBloc.error401Stream,
          //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          //     if (snapshot.hasData && snapshot.data) {
          //       return Container(
          //         width: double.infinity,
          //         height: double.infinity,
          //         color: Colors.white,
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text('Su sesión expiro, por favor vuelva a iniciar sesión'),
          //             SizedBox(
          //               height: ScreenUtil().setHeight(30),
          //             ),
          //             MaterialButton(
          //               onPressed: () async {
          //                 preferences.apellidoMaterno = '';
          //                 preferences.apellidoPaterno = '';
          //                 preferences.codigoUsuario = '';
          //                 preferences.idUsuario = '';
          //                 preferences.locacionId = '';
          //                 preferences.nombres = '';
          //                 preferences.nombresCompletos = '';
          //                 preferences.tiendaId = '';
          //                 preferences.llamadaLocacion = '';
          //                 preferences.token = '';

          //                 final carritoDatabase = CarritoDatabase();
          //                 final familiasDatabase = FamiliasDatabase();
          //                 final locacionDatabase = LocacionDatabase();
          //                 final mesasDatabase = MesasDatabase();
          //                 final pedidosUserDatabase = PedidosUserDatabase();
          //                 final productosDatabase = ProductosDatabase();

          //                 await carritoDatabase.eliminarTablaCarritoMesa();
          //                 await familiasDatabase.eliminarTablaFamilias();
          //                 await locacionDatabase.eliminarTablaLocacion();
          //                 await mesasDatabase.eliminarTablaMesas();
          //                 await pedidosUserDatabase.eliminarTablaPedidoUser();
          //                 await productosDatabase.eliminarTablaProductos();

          //                 Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => true);
          //               },
          //               child: Text('Iniciar Sesión'),
          //               color: Colors.blue,
          //               textColor: Colors.white,
          //             )
          //           ],
          //         ),
          //       );
          //     } else {
          //       return Container();
          //     }
          //   },
          // ),
          // StreamBuilder(
          //   stream: locacionBloc.errorStream,
          //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          //     if (snapshot.hasData && snapshot.data) {
          //       return Container(
          //         width: double.infinity,
          //         height: double.infinity,
          //         color: Colors.white,
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text('Su sesión expiro, por favor vuelva a iniciar sesión'),
          //             SizedBox(
          //               height: ScreenUtil().setHeight(30),
          //             ),
          //             MaterialButton(
          //               onPressed: () async {
          //                 preferences.apellidoMaterno = '';
          //                 preferences.apellidoPaterno = '';
          //                 preferences.codigoUsuario = '';
          //                 preferences.idUsuario = '';
          //                 preferences.locacionId = '';
          //                 preferences.nombres = '';
          //                 preferences.llamadaLocacion = '';
          //                 preferences.nombresCompletos = '';
          //                 preferences.tiendaId = '';
          //                 preferences.token = '';

          //                 final carritoDatabase = CarritoDatabase();
          //                 final familiasDatabase = FamiliasDatabase();
          //                 final locacionDatabase = LocacionDatabase();
          //                 final mesasDatabase = MesasDatabase();
          //                 final pedidosUserDatabase = PedidosUserDatabase();
          //                 final productosDatabase = ProductosDatabase();

          //                 await carritoDatabase.eliminarTablaCarritoMesa();
          //                 await familiasDatabase.eliminarTablaFamilias();
          //                 await locacionDatabase.eliminarTablaLocacion();
          //                 await mesasDatabase.eliminarTablaMesas();
          //                 await pedidosUserDatabase.eliminarTablaPedidoUser();
          //                 await productosDatabase.eliminarTablaProductos();

          //                 Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => true);
          //               },
          //               child: Text('Iniciar Sesión'),
          //               color: Colors.blue,
          //               textColor: Colors.white,
          //             )
          //           ],
          //         ),
          //       );
          //     } else {
          //       return Container();
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}

class VistaTablet extends StatelessWidget {
  const VistaTablet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IndexBlocListener>(context, listen: false);

    //final mesasBloc = ProviderBloc.mesas(context);

    //final errroApiBloc = ProviderBloc.erApi(context);
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: provider.page,
        builder: (BuildContext context, EnumIndex data, Widget child) {
          return Column(
            children: [
              Container(
                height: ScreenUtil().setHeight(64),
                child: Container(
                  color: Color(0xfff7f7f7),
                  child: SideMenu(),
                ),
              ),
              Expanded(
                child: (data == EnumIndex.mesas)
                    ? MesasPage()
                    : Container(
                        color: Color(0XFFE9EEF6),
                      ),
              )
            ],
          );
        },
      ),
    );
  }
}
