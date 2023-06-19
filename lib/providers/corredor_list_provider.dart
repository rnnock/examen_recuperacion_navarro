import 'package:flutter/material.dart';
import '../models/corredor.dart';
import 'providers.dart';

//Esta clase sirve de interfaz intermediaria entre la clase bd_provider y los widgets
class CorredorListProvider extends ChangeNotifier {
  List<Corredor> corredores = [];

  //Operaciones que se realizan en la BBDD

  //Insertar un nuevo registro
  Future<Corredor> newCorredor(String name, String time, String position,
      String bibnumber, String photofinish) async {
    //Se asigna el Corredor en la variable newCorredor
    final newCorredor = Corredor(
        name: name,
        time: time,
        position: position,
        bibnumber: bibnumber,
        photofinish: photofinish);
    final id = await DBProvider.db.insertRawCorredor(newCorredor);
    newCorredor.id = id;

    corredores.add(newCorredor);
    notifyListeners();

    return newCorredor;
  }

  //Método que carga todas las tuplas de la BBDD
  cargaCorredores() async {
    final corredores = await DBProvider.db.getAllCorredores();

    //Nomenclatura Spreadsheet operator (JavaScript) para añadir una lista dentro de la otra
    this.corredores = [...corredores];
    notifyListeners();
  }

  //Método que elimina todos los registros (invocado al pulsar el icono de la papelera)
  deleteAll() async {
    final corredores = await DBProvider.db.deleteAllCorredores();
    this.corredores = [];
    notifyListeners();
  }

  //Método que elimina un registro con la id recibida por parámetro
  deleteCorredorById(int id) async {
    await DBProvider.db.deleteCorredorById(id);
    corredores.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
