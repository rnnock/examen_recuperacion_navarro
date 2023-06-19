import 'package:examen_recuperacion_navarro/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'preferences/preferences.dart';

//Hacemos el main async para ejecutar nuestras preferencias y así
//se inicializan cuando arranque la App
void main() async {
  //En flutter, cuando ejecutamos una tarea async antes de ejecutar el runApp, necesitamos
  //hacer llamadas a instrucciones nativas en una capa de bajo nivel, por eso necesitamos
  //utilizar el WidgetsFlutterBinding para asegurar que se han establecido unos canales
  //para poder comunicarnos con una capa inferior de código nativo y poder ejecutar el método async
  //sin ningún problema antes de ejecutar el runApp().
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {},
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productes App',
      initialRoute: 'home',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => HomeScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
      ),
    );
  }
}
