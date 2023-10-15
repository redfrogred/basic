import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'classes/Config.dart';
import 'classes/Utils.dart';
import 'providers/Controller.dart';
import './pages/_AllPages.dart';

void main() {
runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Controller()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // (this page) variables
  static const String _filename = 'main.dart';  

  @override
  Widget build(BuildContext context) {
    Utils.log( _filename,'== init "${ Config.app_name }" version ${ Config.app_version } ==');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle( color: Config.main_font_color, fontSize: Config.main_font_size ),
        ), 
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF232323),
          foregroundColor: Color(0xFFffffff),
          iconTheme: IconThemeData(color: Color(0xFFffffff)),
          titleTextStyle: TextStyle(
            height: 1,
            fontSize: 18,
          ),
        ),
        cardTheme: const CardTheme(
          color: Color(0xFF222222),
        ), 
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                MaterialStateProperty.all<Color>( Config.button_background_color ),
              padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(10,10,10,10)),
            ),
          ),
      ),      
      initialRoute: 'Start_Page',
      routes: {
        //  start and end pages
        'Start_Page': (context) => const Start_Page(),
        'End_Page': (context) => const End_Page(),
        //  other pages (none yet)
      },
    );
  }
}