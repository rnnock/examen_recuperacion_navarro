import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  //Ponemos late porque coge valor más tarde (no podemos inicializarlo en esta línea)
  static late SharedPreferences _prefs;

  //Creamos las variables que queremos almacenar
  static String _email = '';
  static String _pass = '';
  static bool _remindMe = false;

  //Instancia de un SharedPreferences (creamos o recuperamos la instancia creada)
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //Setters y getters
  static String get email {
    return _prefs.getString('email') ??
        _email; //Si es null, devuelve el que tiene por defecto
  }

  static set email(String value) {
    _email = value; //Cambiamos el valor de nuestra variable privada
    _prefs.setString('email', value); //Cambiamos el valor en Preferences
  }

  static String get pass {
    return _prefs.getString('pass') ??
        _pass; //Si es null, devuelve el que tiene por defecto
  }

  static set pass(String value) {
    _pass = value; //Cambiamos el valor de nuestra variable privada
    _prefs.setString('pass', value); //Cambiamos el valor en Preferences
  }

  static bool get remindMe {
    return _prefs.getBool('remindme') ??
        _remindMe; //Si es null, devuelve el que tiene por defecto
  }

  static set remindMe(bool value) {
    _remindMe = value; //Cambiamos el valor de nuestra variable privada
    _prefs.setBool('remindme', value); //Cambiamos el valor en Preferences
  }
}
