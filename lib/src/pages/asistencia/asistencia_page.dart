import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ventas_restobar/src/utils/constants.dart';
import 'package:ventas_restobar/src/utils/utils.dart';

class AsistenciaPage extends StatelessWidget {
  const AsistenciaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFE9EEF6),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -5,
            left: -20,
            child:
                Container(height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
          ),
          Positioned(
            bottom: -5,
            left: -20,
            child:
                Container(height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
          ),
          Positioned(
            bottom: -5,
            right: 0,
            child:
                Container(height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
          ),
          Positioned(
            top: -5,
            right: 0,
            child:
                Container(height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(32),
              vertical: ScreenUtil().setHeight(32),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
                vertical: ScreenUtil().setHeight(35),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: ScreenUtil().setHeight(36),
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(14),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0XFFC4C8C9),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Fecha:  ${obtenerFechaActualApi()}',
                              style: Theme.of(context).textTheme.button.copyWith(
                                    color: kTitleTextColor,
                                    fontSize: ScreenUtil().setSp(16),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(24),
                            ),
                            Text(
                              'Hora:  ${obtenerHoraActualApi()}',
                              style: Theme.of(context).textTheme.button.copyWith(
                                    color: kTitleTextColor,
                                    fontSize: ScreenUtil().setSp(16),
                                    fontWeight: FontWeight.w500,
                                  ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(32),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(230),
                        child: MaterialButton(
                          height: ScreenUtil().setHeight(32),
                          color: kOrangeTitleTextColor.withOpacity(0.5),
                          textColor: Colors.white,
                          elevation: 0,
                          onPressed: () async {
                            // _controller.changeCargando(true);

                            // _controller.changeCargando(false);
                          },
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Marcar asistencia',
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
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fecha',
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: kTitleTextColor,
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        'Estado',
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: kTitleTextColor,
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        'Hora',
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: kTitleTextColor,
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        'Observaciones',
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: kTitleTextColor,
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w500,
                            ),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: kOrangeColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
