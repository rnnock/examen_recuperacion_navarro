import 'package:examen_recuperacion_navarro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../preferences/preferences.dart';
import '../providers/login_form_provider.dart';
import '../ui/input_decoration.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Login',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text('Crear nueva cuenta',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  String email = '';
  String pass = '';
  bool remindMe = false;

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            initialValue: Preferences.email,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'john.doe@gmail.com',
              labelText: 'Correo electrónico',
              prefixIcon: Icons.alternate_email_outlined,
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value!)
                  ? null
                  : 'Formato de correo no válido';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            initialValue: Preferences.pass,
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecorations.authInputDecoration(
              hintText: '*****',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => loginForm.pass = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe contener un mínimo de 6 caracteres';
            },
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 20,
            child: Row(children: [
              Theme(
                data: ThemeData(unselectedWidgetColor: const Color(0xffff4E50)),
                child: Checkbox(
                  value: Preferences.remindMe,
                  checkColor: Colors.white,
                  activeColor: const Color(0xffff4E50),
                  onChanged: (value) => loginForm.remindMe = value!,
                ),
              ),
              const Text(
                'Remember me',
                style: TextStyle(
                    color: Color(0xffff4E50), fontWeight: FontWeight.normal),
              ),
            ]),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: const Color(0xccff4E50),
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    // Deshabilitamos el teclado
                    FocusScope.of(context).unfocus();
                    if (Preferences.remindMe) {
                      Preferences.email = email;
                      Preferences.pass = pass;
                      Preferences.remindMe = remindMe;
                    } else {
                      Preferences.email = '';
                      Preferences.pass = '';
                      Preferences.remindMe = false;
                    }
                    if (loginForm.isValidForm()) {
                      loginForm.isLoading = true;
                      //Simulamos una petición
                      await Future.delayed(const Duration(seconds: 2));
                      loginForm.isLoading = false;
                      Navigator.pushReplacementNamed(context, 'home');
                    }
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading ? 'Espere' : 'Iniciar sesión',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
