import 'package:flutter/material.dart';
import 'package:ventas_restobar/src/api/login_api.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // /* final tiendadBloc = ProviderBloc.tiendas(context);
      // tiendadBloc.obtenerTiendas(); */

      final preferences = Preferences();

      // if (preferences.url == null || preferences.url.isEmpty || preferences.url == '') {
      //   preferences.url = "$apiBaseURL";
      // }

      if (preferences.token == null || preferences.token.isEmpty) {
        final _loginApi = LoginApi();
        final res = await _loginApi.login('superadmin', '1234');
        if (res.code == 1) {
          Navigator.pushNamed(context, 'home');
        }
      } else {
        Navigator.pushNamed(context, 'home');
      }

      // if (preferences.token == null || preferences.token.isEmpty) {
      //   Navigator.pushNamed(context, 'login');
      // } else {
      //   Navigator.pushNamed(context, 'home');
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
