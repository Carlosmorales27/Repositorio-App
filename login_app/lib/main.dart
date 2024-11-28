import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'signup_page.dart';
import 'form_page.dart';  // Asegúrate de importar las nuevas páginas
import 'submitted_forms_page.dart'; // Asegúrate de importar las nuevas páginas

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Cambiado de bodyText1 a bodyLarge
          bodyMedium: TextStyle(color: Colors.black), // Cambiado de bodyText2 a bodyMedium
          titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Cambiado de headline6 a titleLarge
        ),
      ),
      initialRoute: '/', // Página inicial
      routes: {
        '/': (context) => LoginPage(), // Ruta para LoginPage
        '/home': (context) => HomePage(), // Ruta para HomePage
        '/signup': (context) => SignupPage(), // Ruta para SignupPage
        '/form': (context) => FormPage(), // Ruta para FormPage
        '/submittedForms': (context) => SubmittedFormsPage(), // Ruta para SubmittedFormsPage
      },
    );
  }
}
