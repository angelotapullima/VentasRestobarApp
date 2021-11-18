import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ventas_restobar/src/utils/constants.dart';
import 'package:ventas_restobar/src/utils/responsive.dart';

class MesasWidget extends StatelessWidget {
  const MesasWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(30),
        horizontal: ScreenUtil().setWidth(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Salón principal',
                style: Theme.of(context).textTheme.button.copyWith(
                      color: kTitleTextColor,
                      fontSize: ScreenUtil().setSp(24),
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(4),
                  horizontal: ScreenUtil().setWidth(10),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: kOrangeColor,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Text(
                      'Unir mesas',
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: kOrangeColor,
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    Container(height: ScreenUtil().setHeight(24), child: SvgPicture.asset('assets/svg/plus_orange.svg'))
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.wp(1),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: responsive.hp(0),
                  crossAxisSpacing: responsive.wp(2),
                ),
                itemCount: 9,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return LayoutBuilder(builder: (context, constraints) {
                    Color color = Color(0XFF5FC52F);
                    Color color2 = Color(0XFF47D106);
                    String texto = 'Disponible';
                    if (index % 2 == 0) {
                      color = Color(0XFFFFDE2F);
                      color2 = Color(0XFFFFD233);
                      texto = 'Ocupado';
                    }
                    if (index % 3 == 0) {
                      color = Color(0XFFFF1F1F);
                      color2 = Color(0XFFFB5757);
                      texto = 'Limpiar';
                    }
                    if (index == 0) {
                      color = Color(0XFF5FC52F);
                      color2 = Color(0XFF47D106);
                      texto = 'Disponible';
                    }
                    return InkWell(
                      child: Container(
                        width: constraints.maxWidth,
                        child: Row(
                          children: [
                            Container(
                              width: constraints.maxWidth * 0.12,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: constraints.maxHeight * 0.12,
                                      width: constraints.maxWidth * 0.2,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: constraints.maxHeight * 0.12,
                                      width: constraints.maxWidth * 0.2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: responsive.wp(.5),
                            ),
                            Container(
                              height: constraints.maxHeight * 0.6,
                              width: constraints.maxWidth * 0.75 - responsive.wp(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    color2,
                                    color,
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: responsive.wp(.5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    Center(
                                      child: (index == 0)
                                          ? Container(
                                              height: ScreenUtil().setHeight(72),
                                              width: ScreenUtil().setWidth(72),
                                              child: SvgPicture.asset('assets/svg/delivery.svg'),
                                            )
                                          : Text(
                                              '$index',
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(32),
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                    ),
                                    Spacer(),
                                    Center(
                                      child: Text(
                                        texto,
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: ScreenUtil().setSp(16)),
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: responsive.wp(.5),
                            ),
                            Container(
                              width: constraints.maxWidth * 0.12,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: constraints.maxHeight * 0.12,
                                      width: constraints.maxWidth * 0.2,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: constraints.maxHeight * 0.12,
                                      width: constraints.maxWidth * 0.2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                }),
          ),
        ],
      ),
    );
  }
}
