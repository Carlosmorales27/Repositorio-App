import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'form_page.dart';  // Importa la página del formulario
import 'submitted_forms_page.dart'; // Importa la página de formularios enviados

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bienvenido, ${_auth.currentUser?.email}'),
            SizedBox(height: 30),
            // Añadimos los íconos para las dos secciones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_circle),
                  iconSize: 50,
                  onPressed: () {
                    // Navegar a la página de formulario
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FormPage()),
                    );
                  },
                ),
                SizedBox(width: 50), // Espacio entre los iconos
                IconButton(
                  icon: Icon(Icons.visibility),
                  iconSize: 50,
                  onPressed: () {
                    // Navegar a la página de formularios enviados
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SubmittedFormsPage()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
