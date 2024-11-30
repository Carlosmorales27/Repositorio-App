import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'form_page.dart'; // Página del formulario
import 'submitted_forms_page.dart'; // Página de formularios enviados

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  cons HomePage({Key? key}) : super(key: key);

  void _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Container(
        color: Colors.grey[200], // Fondo claro
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bienvenida ajustada
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Text(
                'Bienvenido, ${_auth.currentUser?.email ?? "Usuario"}',
                style: const TextStyle(
                  fontSize: 15, // Aumenté el tamaño de la fuente
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Texto en negro
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Tarjetas con botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCard(
                  icon: Icons.add_circle,
                  color: Colors.blueAccent,
                  label: 'Nuevo Formulario',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FormPage()),
                    );
                  },
                ),
                _buildCard(
                  icon: Icons.visibility,
                  color: Colors.deepOrange,
                  label: 'Ver Formularios',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SubmittedFormsPage()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Botón de cerrar sesión
            ElevatedButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout),
              label: const Text('Cerrar Sesión'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Fondo del botón
                foregroundColor: Colors.white, // Color del texto e ícono
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para crear tarjetas estilizadas
  Widget _buildCard({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Container(
          width: 150,
          height: 150,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white, // Fondo blanco para las tarjetas
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: color),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Texto en negro
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
