import 'package:examen_recuperacion_navarro/widgets/corredores_tiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Corredores'),
        actions: [
          //Icono de papelera que elimina todos los registros al ser pulsado
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<CorredorListProvider>(context, listen: false)
                  .deleteAll();
            },
          )
        ],
      ),
      body: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final corredorListProvider = Provider.of<CorredorListProvider>(context,
        listen: false); //Para acceder a la lista de corredorListProvider
    corredorListProvider.cargaCorredores();
    return const CorredoresTiles();
  }
}
