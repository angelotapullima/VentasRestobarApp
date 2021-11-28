import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ventas_restobar/src/bloc/provider.dart';
import 'package:ventas_restobar/src/models/mesas_model.dart';
import 'package:ventas_restobar/src/utils/constants.dart';

class MoverMesaPage extends StatefulWidget {
  const MoverMesaPage({Key key, @required this.mesa}) : super(key: key);
  final MesaModel mesa;

  @override
  _MoverMesaPageState createState() => _MoverMesaPageState();
}

class _MoverMesaPageState extends State<MoverMesaPage> {
  final _controller = Controller();
  @override
  Widget build(BuildContext context) {
    final mesasBloc = ProviderBloc.mesas(context);
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
              vertical: ScreenUtil().setHeight(108),
              horizontal: ScreenUtil().setWidth(29),
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
              vertical: ScreenUtil().setHeight(158),
              horizontal: ScreenUtil().setWidth(75),
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
                            'Mover mesa',
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
                    SizedBox(
                      height: ScreenUtil().setHeight(23),
                    ),
                    Row(
                      children: [
                        Text(
                          'Seleccionar mesa:',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: kTitleTextColor,
                                fontSize: ScreenUtil().setSp(18),
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(387),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0XFFCDCDCD)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(142),
                                height: ScreenUtil().setHeight(100),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: ScreenUtil().setWidth(20),
                                          height: ScreenUtil().setHeight(24),
                                          decoration: BoxDecoration(
                                            color: Color(0XFFFFDE2F),
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(32),
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(20),
                                          height: ScreenUtil().setHeight(24),
                                          decoration: BoxDecoration(
                                            color: Color(0XFFFFDE2F),
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(12),
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(70),
                                      height: ScreenUtil().setHeight(100),
                                      decoration: BoxDecoration(
                                        color: Color(0XFFFFDE2F),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${widget.mesa.mesaNombre}',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.button.copyWith(
                                                  color: Colors.white,
                                                  fontSize: ScreenUtil().setSp(18),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(12),
                                          ),
                                          Text(
                                            'Ocupado',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.button.copyWith(
                                                  color: Colors.white,
                                                  fontSize: ScreenUtil().setSp(16),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(12),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: ScreenUtil().setWidth(20),
                                          height: ScreenUtil().setHeight(24),
                                          decoration: BoxDecoration(
                                            color: Color(0XFFFFDE2F),
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(32),
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(20),
                                          height: ScreenUtil().setHeight(24),
                                          decoration: BoxDecoration(
                                            color: Color(0XFFFFDE2F),
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(12),
                              ),
                              Text(
                                'Mesa de origen',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.button.copyWith(
                                      color: kTitleTextColor,
                                      fontSize: ScreenUtil().setSp(18),
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(30),
                        ),
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (_, s) => Container(
                            width: ScreenUtil().setWidth(387),
                            height: (_controller.activeSelect) ? ScreenUtil().setHeight(223) : null,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: (_controller.activeSelect) ? Color(0XFFFF9900) : Color(0XFFCDCDCD)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              onTap: () {
                                _controller.changeSelect(true);
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: ScreenUtil().setWidth(142),
                                        height: ScreenUtil().setHeight(100),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: ScreenUtil().setWidth(20),
                                                  height: ScreenUtil().setHeight(24),
                                                  decoration: BoxDecoration(
                                                    color: (_controller.idMesaDestinoSelec != '') ? Color(0XFF5FC52F) : Color(0XFFD8D8D8),
                                                    borderRadius: BorderRadius.circular(3),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: ScreenUtil().setHeight(32),
                                                ),
                                                Container(
                                                  width: ScreenUtil().setWidth(20),
                                                  height: ScreenUtil().setHeight(24),
                                                  decoration: BoxDecoration(
                                                    color: (_controller.idMesaDestinoSelec != '') ? Color(0XFF5FC52F) : Color(0XFFD8D8D8),
                                                    borderRadius: BorderRadius.circular(3),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setWidth(12),
                                            ),
                                            Container(
                                              width: ScreenUtil().setWidth(70),
                                              height: ScreenUtil().setHeight(100),
                                              decoration: BoxDecoration(
                                                color: (_controller.idMesaDestinoSelec != '') ? Color(0XFF5FC52F) : Color(0XFFD8D8D8),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    (_controller.idMesaDestinoSelec != '') ? '${_controller.mesaDestinoNombre}' : '',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context).textTheme.button.copyWith(
                                                          color: Colors.white,
                                                          fontSize: ScreenUtil().setSp(18),
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                  ),
                                                  SizedBox(
                                                    height: ScreenUtil().setHeight(12),
                                                  ),
                                                  Text(
                                                    (_controller.idMesaDestinoSelec != '') ? 'Disponible' : '',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context).textTheme.button.copyWith(
                                                          color: Colors.white,
                                                          fontSize: ScreenUtil().setSp(16),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setWidth(12),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: ScreenUtil().setWidth(20),
                                                  height: ScreenUtil().setHeight(24),
                                                  decoration: BoxDecoration(
                                                    color: (_controller.idMesaDestinoSelec != '') ? Color(0XFF5FC52F) : Color(0XFFD8D8D8),
                                                    borderRadius: BorderRadius.circular(3),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: ScreenUtil().setHeight(32),
                                                ),
                                                Container(
                                                  width: ScreenUtil().setWidth(20),
                                                  height: ScreenUtil().setHeight(24),
                                                  decoration: BoxDecoration(
                                                    color: (_controller.idMesaDestinoSelec != '') ? Color(0XFF5FC52F) : Color(0XFFD8D8D8),
                                                    borderRadius: BorderRadius.circular(3),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(12),
                                      ),
                                      Text(
                                        'Mesa de destino',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.button.copyWith(
                                              color: kTitleTextColor,
                                              fontSize: ScreenUtil().setSp(18),
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(30),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0XFFFF9900),
                                      )
                                    ],
                                  ),
                                  (_controller.activeSelect)
                                      ? Expanded(
                                          child: StreamBuilder(
                                              stream: mesasBloc.mesasStream,
                                              builder: (context, AsyncSnapshot<List<MesaModel>> snapshot) {
                                                if (snapshot.hasData && snapshot.data.length > 0) {
                                                  var mesas = snapshot.data;
                                                  return ListView.builder(
                                                    padding: EdgeInsets.all(0),
                                                    shrinkWrap: true,
                                                    itemCount: mesas.length,
                                                    itemBuilder: (_, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          _controller.changeSelect(false);
                                                          _controller.changeDataMesa(mesas[index].idMesa, mesas[index].mesaNombre);
                                                        },
                                                        child: Card(
                                                          child: Text(
                                                            '${mesas[index].mesaNombre}',
                                                            style: Theme.of(context).textTheme.button.copyWith(
                                                                  color: kTitleTextColor,
                                                                  fontSize: ScreenUtil().setSp(16),
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  return Center(
                                                    child: Text(
                                                      'Sin mesas disponibles',
                                                      style: Theme.of(context).textTheme.button.copyWith(
                                                            color: kTitleTextColor,
                                                            fontSize: ScreenUtil().setSp(16),
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                    ),
                                                  );
                                                }
                                              }),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(213),
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
                          'Mover',
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
  bool activeSelect = false;
  String idMesaDestinoSelec = '';
  String mesaDestinoNombre = '';
  bool boton = false;
  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }

  void changeSelect(bool s) {
    activeSelect = s;
    notifyListeners();
  }

  void changeDataMesa(String id, String mesa) {
    idMesaDestinoSelec = id;
    mesaDestinoNombre = mesa;
    notifyListeners();
  }
}
