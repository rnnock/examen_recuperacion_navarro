import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

//Clase que muestra la información de los corredores
class CorredoresTiles extends StatelessWidget {
  const CorredoresTiles({super.key});
  @override
  Widget build(BuildContext context) {
    final corredorListProvider = Provider.of<CorredorListProvider>(
        context); //Para acceder a la lista de scanListProvider
    final corredores = corredorListProvider
        .corredores; //Para utilizar en el ListView.builder y cuando haya algún cambio se volverá a repintar
    return ListView.builder(
        itemCount: corredores.length,
        itemBuilder: (_, index) => Dismissible(
              key: UniqueKey(), //Para obtener una clave única para el widget
              background: Container(
                color: Colors.orange,
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    //Icono de papelera que aparece al eliminar un registro arrastrando
                    child: Icon(Icons.delete),
                  ),
                ),
              ),
              onDismissed: (direccion) {
                Provider.of<CorredorListProvider>(context, listen: false)
                    //Se invoca al método deleteCorredorById y se pasa como parámetro la id a eliminar
                    .deleteCorredorById(corredores[index].id!);
              },
              child: ListTile(
                leading: Icon(
                  Icons.bike_scooter_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                //Info CorredoresTiles (Nombre y posición)
                title: Text(corredores[index].name),
                subtitle: Text(corredores[index].position),
                trailing: const Icon(
                  Icons.check,
                  color: Colors.teal,
                ),
                onTap: () {
                  //TODO: Ver detalle corredor
                },
              ),
            ));
  }
}
