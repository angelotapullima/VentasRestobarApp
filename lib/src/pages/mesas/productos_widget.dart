import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ventas_restobar/src/bloc/index_mesa_bloc.dart';
import 'package:ventas_restobar/src/bloc/provider.dart';
import 'package:ventas_restobar/src/models/familias_model.dart';
import 'package:ventas_restobar/src/utils/constants.dart';

class ProductoFamilia extends StatelessWidget {
  const ProductoFamilia({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final familiasBloc = ProviderBloc.familias(context);
    familiasBloc.obtenerFamilias();
    final provider = Provider.of<IndexMesasBlocListener>(context, listen: false);
    return ValueListenableBuilder(
        valueListenable: provider.vista,
        builder: (BuildContext context, EnumIndex data, Widget child) {
          return Row(
            children: [
              Container(
                width: ScreenUtil().setWidth(328),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              provider.changeToMesas();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                            color: Color(0XFFC4C8C9),
                            iconSize: ScreenUtil().setHeight(24)),
                        Text(
                          'Categorías',
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: kTitleTextColor,
                                fontSize: ScreenUtil().setSp(24),
                                fontWeight: FontWeight.w600,
                              ),
                        )
                      ],
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: familiasBloc.familiasStream,
                        builder: (context, AsyncSnapshot<List<FamiliasModel>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length > 0) {
                              var datos = snapshot.data;
                              return ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                                  itemCount: datos.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
                                        child: Container(
                                            padding: EdgeInsets.all(14),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: (index == 0) ? Color(0XFFFFE4D0) : Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: ScreenUtil().setHeight(75),
                                                  child: SvgPicture.asset('assets/svg/fire.svg'),
                                                ),
                                                Text(
                                                  '${datos[index].familiaNombre}',
                                                  style: Theme.of(context).textTheme.button.copyWith(
                                                        color: kTitleTextColor,
                                                        fontSize: ScreenUtil().setSp(16),
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                )
                                              ],
                                            )),
                                      ),
                                    );
                                  });
                            } else {
                              return Center(
                                child: Text('Sin categorías'),
                              );
                            }
                          } else {
                            return Center(
                              child: Text('Cargando...'),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(20),
              ),
              Container(
                width: ScreenUtil().setWidth(328),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(30),
                    horizontal: ScreenUtil().setWidth(24),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Productos',
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: kTitleTextColor,
                                  fontSize: ScreenUtil().setSp(24),
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
