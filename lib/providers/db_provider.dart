import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/corredor.dart';

class DBProvider {
  static Database? _database;

  /* Estructura singleton, creando una misma instancia de esta misma clase para acceder
   * siempre con la misma instancia en nuestra base de datos, con el fin de no duplicar
   * las instancias cada vez.
   * 
   * Nos devuelve una instancia en la misma clase y la almacenamos en esta variable db,
   * para acceder siempre a la misma instancia de este objeto
   */
  static final DBProvider db = DBProvider._();

  DBProvider._(); //Creamos un método constructor privado

  Future<Database> get database async {
    //Método async que realiza todas las tareas de inicialización (haremos el CREATE de la BD y tablas que necesitemos)
    if (_database == null) _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    //Obtener el path o ruta donde crearemos nuestra base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    //Variable que almacena la ruta del directorio + nombre
    final path = join(documentsDirectory.path, 'Corredores.db');

    //Creación de la BBDD
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        //Aquí creamos la BBDD, con el formato requerido para las sentencias SQL
        await db.execute('''
      CREATE TABLE Corredores(
      id INTEGER PRIMARY KEY, 
      name TEXT,
      time TEXT,
      position TEXT,
      bibnumber TEXT,
      photofinish TEXT
      )
      ''');
      },
    );
  }

  //Método para insertar una tupla en la BBDD
  Future<int> insertRawCorredor(Corredor newCorredor) async {
    final id = newCorredor.id;
    final name = newCorredor.name;
    final time = newCorredor.time;
    final position = newCorredor.position;
    final bibnumber = newCorredor.bibnumber;
    final photofinish = newCorredor.photofinish;

    final db = await database;

    //Variable para almacenar el resultado (siempre funciones async cuando utilizamos BBDD)
    final res = await db.rawInsert('''
      INSERT INTO Corredores(id,name,time,position,bibnumber,photofinish)
        VALUES ($id,$name,$time,$position,$bibnumber,$photofinish) 
      ''');

    return res;
  }

//Select de toda la tabla Corredores
  Future<List<Corredor>> getAllCorredores() async {
    final db = await database;

    //Devuelve todas las tuplas de la tabla Corredores y la almacena en la variable res
    final res = await db.query('Corredores');

    //Si hay registros, se añaden al listado. En caso contrario, el array está vacío
    return res.isNotEmpty ? res.map((e) => Corredor.fromMap(e)).toList() : [];
  }

  //Select de un ID en concreto
  Future<Corredor?> getCorredorById(int id) async {
    final db = await database;
    final res = await db.query('Corredor', where: 'id = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      return Corredor.fromMap(res.first); //Devuelve el primer item
    } else {
      return null;
    }
  }

  //UPDATE (devuelve ID)
  Future<int> updateCorredor(Corredor newCorredor) async {
    final db = await database;
    final res = db.update('Corredor', newCorredor.toMap(),
        where: 'id = ?', whereArgs: [newCorredor.id]);

    return res;
  }

//DELETE
//Elimina todos los registros
  Future<int> deleteAllCorredores() async {
    final db = await database;
    final res = await db.rawDelete('''
    DELETE FROM Corredores
    '''); //también puede ser db.delete()
    return res;
  }

  //Elimina el registro del id recibido por parámetro
  Future<int> deleteCorredorById(int id) async {
    final db = await database;
    final res = await db.delete('Corredores', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
