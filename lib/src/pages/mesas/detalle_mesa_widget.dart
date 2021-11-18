import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ventas_restobar/src/utils/constants.dart';
import 'package:ventas_restobar/src/utils/responsive.dart';

class DetalleMesa extends StatelessWidget {
  const DetalleMesa({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(30),
        horizontal: ScreenUtil().setWidth(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Text(
              'Toque sobre una mesa para ver los detalles',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.button.copyWith(
                    color: kTitleTextColor,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(180),
          ),
          Center(
            child: Container(
              height: ScreenUtil().setHeight(180),
              width: ScreenUtil().setWidth(180),
              child: Row(
                children: [
                  Container(
                    width: ScreenUtil().setWidth(30),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0XFFE5E5E5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: ScreenUtil().setHeight(30),
                            width: ScreenUtil().setWidth(24),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0XFFE5E5E5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: ScreenUtil().setHeight(30),
                            width: ScreenUtil().setWidth(24),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: responsive.wp(.5),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(150),
                    width: ScreenUtil().setWidth(100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0XFFE5E5E5),
                          Color(0XFFE5E5E5),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: responsive.wp(.5),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(30),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0XFFE5E5E5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: ScreenUtil().setHeight(30),
                            width: ScreenUtil().setWidth(24),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0XFFE5E5E5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: ScreenUtil().setHeight(30),
                            width: ScreenUtil().setWidth(24),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
