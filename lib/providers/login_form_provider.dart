import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String pass = '';
  bool remindMe = false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print('Valor del formulario: ${formKey.currentState?.validate()}');
    print('$email - $pass');
    return formKey.currentState?.validate() ?? false;
  }
}
