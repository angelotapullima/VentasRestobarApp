import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductoImage extends StatelessWidget {
  const ProductoImage({
    Key key,
    @required this.hmax,
    @required this.wmax,
    @required this.wmin,
    @required this.hmin,
    @required this.himage,
  }) : super(key: key);

  final double hmax, wmax, hmin, wmin, himage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(hmax),
      width: ScreenUtil().setWidth(wmax),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0XFF808080).withOpacity(0.25),
            blurRadius: 0.4,
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              height: ScreenUtil().setHeight(hmin),
              width: ScreenUtil().setWidth(wmin),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0XFF808080).withOpacity(0.25),
                    blurRadius: 0.4,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              height: ScreenUtil().setHeight(himage),
              child: SvgPicture.asset('assets/svg/cubiertos.svg'),
            ),
          )
        ],
      ),
    );
  }
}
