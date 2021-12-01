import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';
import 'package:ventas_restobar/src/utils/constants.dart';
import 'package:ventas_restobar/src/utils/utils.dart';

class ChangeUrlPage extends StatefulWidget {
  const ChangeUrlPage({Key key}) : super(key: key);

  @override
  _ChangeUrlPageState createState() => _ChangeUrlPageState();
}

class _ChangeUrlPageState extends State<ChangeUrlPage> {
  final TextEditingController _urlController = TextEditingController();
  final _controller = Controller();
  @override
  Widget build(BuildContext context) {
    final _preferences = Preferences();
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
              vertical: ScreenUtil().setHeight(130),
              horizontal: ScreenUtil().setWidth(150),
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
              vertical: ScreenUtil().setHeight(170),
              horizontal: ScreenUtil().setWidth(190),
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
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Atualizar url',
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
                    Text(
                      'url actual = ${_preferences.url}',
                      style: TextStyle(
                        color: Color(0XFF585858),
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(16),
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(50),
                      width: ScreenUtil().setWidth(300),
                      child: TextField(
                        controller: _urlController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Nueva url',
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
                      height: ScreenUtil().setHeight(16),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(300),
                      child: MaterialButton(
                        height: ScreenUtil().setHeight(32),
                        color: kOrangeTitleTextColor,
                        textColor: Colors.white,
                        elevation: 0,
                        onPressed: () async {
                          _controller.changeCargando(true);
                          if (_urlController.text.length > 0) {
                            _preferences.url = _urlController.text;
                            showToast2('Url actualizado', Colors.black);

                            Navigator.pop(context);
                          } else {
                            showToast2('Debe ingresar una url', Colors.black);
                          }

                          _controller.changeCargando(false);
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Actualizar URL',
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(320),
                    ),
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
                      color: Color.fromRGBO(0, 0, 0, 0.5),
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

class Controller extends ChangeNotifier {
  bool cargando = false;
  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }
}
