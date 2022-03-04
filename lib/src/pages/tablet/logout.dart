import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ventas_restobar/src/database/familia_database.dart';
import 'package:ventas_restobar/src/database/mesa_database.dart';
import 'package:ventas_restobar/src/database/productos_familia_database.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preferences = Preferences();
    return Material(
      color: Colors.black.withOpacity(.5),
      child: Stack(
        fit: StackFit.expand,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(250),
              horizontal: ScreenUtil().setWidth(300),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(50),
                ),
                Text(
                  'Desea Cerrar Sesión?',
                  style: TextStyle(fontSize: ScreenUtil().setSp(22)),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: ScreenUtil().setWidth(150),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text('No'),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(100),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(150),
                      child: MaterialButton(
                        onPressed: () async {
                          preferences.apellidoMaternos = '';
                          preferences.apellidoPaternos = '';
                          preferences.codigoUsuarioss = '';
                          preferences.idUsuarios = '';
                          preferences.locacionIds = '';
                          preferences.nombress = '';
                          preferences.llamadaLocacions = '';
                          preferences.nombresCompletoss = '';
                          preferences.tiendaIds = '';
                          preferences.tokens = '';
                          preferences.locacionIds = '';

                          //final carritoDatabase = CarritoDatabase();
                          final familiasDatabase = FamiliaDatabase();
                          //final locacionDatabase = LocacionDatabase();
                          final mesasDatabase = MesaDatabase();
                          //final pedidosUserDatabase = PedidosUserDatabase();
                          final productosDatabase = ProductosFamiliaDatabase();
                          await familiasDatabase.deleteFamilias();
                          await mesasDatabase.deleteMesas();
                          await productosDatabase.deleteCProductosFamilia();

                          Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => true);
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text('Si'),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
