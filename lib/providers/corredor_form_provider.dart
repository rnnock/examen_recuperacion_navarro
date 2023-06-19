import 'package:examen_recuperacion_navarro/models/corredor.dart';
import 'package:flutter/material.dart';

class CorredorFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Corredor tempCorredor;
  CorredorFormProvider(this.tempCorredor);

  bool isValidForm() {
    print(tempCorredor.name);
    print(tempCorredor.id);
    print(tempCorredor.position);
    return formKey.currentState?.validate() ?? false;
  }
}
