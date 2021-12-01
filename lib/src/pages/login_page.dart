import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ventas_restobar/src/api/login_api.dart';
import 'package:ventas_restobar/src/api/mesas_api.dart';
import 'package:ventas_restobar/src/pages/change_url_page.dart';
import 'package:ventas_restobar/src/utils/constants.dart';
import 'package:ventas_restobar/src/utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = Controller();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
              top: 0,
              left: -40,
              bottom: 0,
              child: Container(
                child: SvgPicture.asset('assets/svg/circle_login.svg'),
              ),
            ),
            Positioned(
              top: 0,
              right: -40,
              bottom: 0,
              child: Container(
                child: SvgPicture.asset('assets/svg/circle_login_right.svg'),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(56),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(200),
                      child: Image.asset('assets/img/logo.png'),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(32),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bienvenido de vuelta',
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: kOrangeTitleTextColor,
                                fontSize: ScreenUtil().setSp(24),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(20),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(23),
                          child: SvgPicture.asset('assets/svg/emoji.svg'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(310),
                      child: TextField(
                        maxLines: 1,
                        controller: _usuarioController,
                        onChanged: (value) {
                          if (_usuarioController.text.length > 0 && _passwdController.text.length > 0) {
                            _controller.changeBoton(true);
                          } else {
                            _controller.changeBoton(false);
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Usuario',
                          hintStyle: TextStyle(
                            color: Color(0XFF808080),
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(16),
                            fontStyle: FontStyle.normal,
                          ),
                          filled: true,
                          fillColor: Color(0XFFEEEEEE),
                          contentPadding:
                              EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0XFFEEEEEE), width: ScreenUtil().setWidth(1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0XFFEEEEEE), width: ScreenUtil().setWidth(1)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0XFFEEEEEE), width: ScreenUtil().setWidth(1)),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0XFF585858),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(310),
                      child: TextField(
                        maxLines: 1,
                        controller: _passwdController,
                        obscureText: true,
                        onChanged: (value) {
                          if (_usuarioController.text.length > 0 && _passwdController.text.length > 0) {
                            _controller.changeBoton(true);
                          } else {
                            _controller.changeBoton(false);
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          hintStyle: TextStyle(
                            color: Color(0XFF808080),
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(16),
                            fontStyle: FontStyle.normal,
                          ),
                          filled: true,
                          fillColor: Color(0XFFEEEEEE),
                          contentPadding:
                              EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0XFFEEEEEE), width: ScreenUtil().setWidth(1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0XFFEEEEEE), width: ScreenUtil().setWidth(1)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0XFFEEEEEE), width: ScreenUtil().setWidth(1)),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0XFF585858),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(310),
                      child: MaterialButton(
                        height: ScreenUtil().setHeight(56),
                        color: kOrangeTitleTextColor,
                        textColor: Colors.white,
                        elevation: 0,
                        onPressed: () async {
                          _controller.changeCargando(true);
                          if (_controller.boton) {
                            final _loginApi = LoginApi();
                            final res = await _loginApi.login(_usuarioController.text, _passwdController.text);
                            if (res.code == 1) {
                              final mesaApi = MesasApi();
                              await mesaApi.obtenerMesasPorNegocio();
                              Navigator.pushReplacementNamed(context, 'home');
                            } else {
                              showToast2(res.message, Colors.black);
                            }
                          } else {
                            showToast2('Complete todos los campos', Colors.black);
                          }
                          _controller.changeCargando(false);
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Ingresar',
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 0,
                left: 70,
                right: 70,
                child: Row(
                  children: [
                    // Text(
                    //   'url = ${_preferences.url}',
                    //   style: TextStyle(
                    //     color: Color(0XFF585858),
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: ScreenUtil().setSp(16),
                    //     fontStyle: FontStyle.normal,
                    //   ),
                    // ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return ChangeUrlPage();
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
                      icon: Icon(
                        Icons.settings,
                      ),
                      iconSize: ScreenUtil().setHeight(24),
                      color: kOrangeTitleTextColor,
                    ),
                  ],
                )),
            AnimatedBuilder(
              animation: _controller,
              builder: (_, f) {
                return (_controller.cargando)
                    ? Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Color.fromRGBO(0, 0, 0, 0.3),
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
      ),
    );
  }
}

class Controller extends ChangeNotifier {
  bool cargando = false, boton = false;

  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }

  void changeBoton(bool b) {
    boton = b;
    notifyListeners();
  }
}
