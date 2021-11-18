import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ventas_restobar/src/pages/mesas/detalle_mesa_widget.dart';
import 'package:ventas_restobar/src/pages/mesas/mesas_widget.dart';

class MesasPage extends StatelessWidget {
  const MesasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFE9EEF6),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: ScreenUtil().setWidth(769),
                child: Stack(
                  children: [
                    Positioned(
                      top: -5,
                      left: -20,
                      child: Container(
                          height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
                    ),
                    Positioned(
                      bottom: -5,
                      left: -20,
                      child: Container(
                          height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
                    ),
                    Positioned(
                      bottom: -5,
                      right: 0,
                      child: Container(
                          height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
                    ),
                    Positioned(
                      top: -5,
                      right: 0,
                      child: Container(
                          height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(254),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: -5,
                      right: -10,
                      child: Container(
                          height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
                    ),
                    Positioned(
                      top: -5,
                      right: -10,
                      child: Container(
                          height: ScreenUtil().setHeight(100), width: ScreenUtil().setWidth(100), child: SvgPicture.asset('assets/svg/circles.svg')),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: ScreenUtil().setWidth(728),
                child: Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(32),
                    right: ScreenUtil().setWidth(20),
                    bottom: ScreenUtil().setHeight(32),
                    left: ScreenUtil().setWidth(20),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: MesasWidget(),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(296),
                child: Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(32),
                    right: ScreenUtil().setWidth(32),
                    bottom: ScreenUtil().setHeight(32),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DetalleMesa(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
