import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ventas_restobar/src/bloc/index_bloc.dart';
import 'package:ventas_restobar/src/pages/tablet/logout.dart';
import 'package:ventas_restobar/src/utils/constants.dart';
import 'package:ventas_restobar/src/widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IndexBlocListener>(context, listen: false);
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(64),
      padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      child: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: provider.page,
          builder: (BuildContext context, EnumIndex data, Widget child) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(64),
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: kDefaultPadding),
                          Spacer(),
                          Container(
                            child: Center(
                                child: SideMenuItem(
                              press: () {
                                provider.changeToMesa(context);
                              },
                              showBorder: (data == EnumIndex.mesas) ? true : false,
                              color: Colors.transparent,
                              title: "Mesas",
                              isActive: (data == EnumIndex.mesas) ? true : false,
                            )),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(56)),
                          Container(
                            child: Center(
                                child: SideMenuItem(
                              press: () {
                                provider.changeToPedidos();
                              },
                              color: Colors.transparent,
                              title: "Historial de pedidos",
                              showBorder: (data == EnumIndex.pedidos) ? true : false,
                              isActive: (data == EnumIndex.pedidos) ? true : false,
                            )),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(56)),
                          Container(
                            child: Center(
                                child: SideMenuItem(
                              press: () {
                                provider.changeToAsistencia();
                              },
                              color: Colors.transparent,
                              title: "Asistencia",
                              showBorder: (data == EnumIndex.asistencia) ? true : false,
                              isActive: (data == EnumIndex.asistencia) ? true : false,
                            )),
                          ),
                          SizedBox(width: kDefaultPadding * 8.4),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(60),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: kDefaultPadding),
                      Spacer(),
                      Container(
                        child: Center(
                            child: SideMenuItem(
                          press: () {
                            provider.changeToMesa(context);
                          },
                          color: (data == EnumIndex.mesas) ? kTitleTextColor : kTextInactiveColor,
                          title: "Mesas",
                          isActive: (data == EnumIndex.mesas) ? true : false,
                        )),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(56)),
                      Container(
                        child: Center(
                            child: SideMenuItem(
                          press: () {
                            provider.changeToPedidos();
                          },
                          color: (data == EnumIndex.pedidos) ? kTitleTextColor : kTextInactiveColor,
                          title: "Historial de pedidos",
                          isActive: (data == EnumIndex.pedidos) ? true : false,
                        )),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(56)),
                      Container(
                        child: Center(
                            child: SideMenuItem(
                          press: () {
                            provider.changeToAsistencia();
                          },
                          color: (data == EnumIndex.asistencia) ? kTitleTextColor : kTextInactiveColor,
                          title: "Asistencia",
                          isActive: (data == EnumIndex.asistencia) ? true : false,
                        )),
                      ),
                      SizedBox(width: kDefaultPadding * 4),
                      Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return Logout();
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
                          icon: Icon(Icons.logout),
                          iconSize: ScreenUtil().setHeight(24),
                        ),
                      ),
                      SizedBox(width: kDefaultPadding * 2),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
