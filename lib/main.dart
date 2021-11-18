import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ventas_restobar/src/bloc/index_bloc.dart';
import 'package:ventas_restobar/src/bloc/provider.dart';
import 'package:ventas_restobar/src/pages/home_page.dart';
import 'package:ventas_restobar/src/pages/splah.dart';
import 'package:ventas_restobar/src/preferences/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new Preferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderBloc(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<IndexBlocListener>(
            create: (_) => IndexBlocListener(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: Size(1024, 768),
          builder: () => MaterialApp(
            title: 'Ventas restobar app',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(),
              primarySwatch: Colors.blue,
            ),
            initialRoute: 'splash',
            routes: {
              "splash": (BuildContext context) => Splash(),
              "home": (BuildContext context) => HomePage(),
              //"login": (BuildContext context) => LoginPage(),
            },
          ),
        ),
      ),
    );
  }
}
