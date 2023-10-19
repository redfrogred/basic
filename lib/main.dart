import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'classes/Config.dart';
import 'providers/Controller.dart';
import './pages/_AllPages.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Controller()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //  Force portrait only
    //  see: https://stackoverflow.com/questions/51806662/how-to-set-landscape-orientation-mode-for-flutter-app
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle( color: Config.main_font_color, fontSize: Config.main_font_size ),
        ), 
        appBarTheme: AppBarTheme(
          backgroundColor: Config.appbar_background,
          foregroundColor: Config.appbar_foreground,
          iconTheme: const IconThemeData(color: Color(0xFFffffff)),
          titleTextStyle: const TextStyle(
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