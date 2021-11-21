import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ventas_restobar/src/utils/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
