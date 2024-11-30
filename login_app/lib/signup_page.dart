import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false; // Para mostrar el indicador de carga

  void _signup() async {
    setState(() {
      _isLoading = true; // Inicia el indicador de carga
    });

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      setState(() {
        _isLoading = false; // Detiene el indicador de carga
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrarse"),
        backgroundColor: Colors.transparent, // AppBar transparente para un look más limpio
        elevation: 0, // Eliminar la sombra del AppBar
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white, // Fondo blanco para un diseño más limpio
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Título central
              const Text(
                'Crea tu cuenta',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Texto oscuro para contraste
                ),
              ),
              const SizedBox(height: 40),

              // Campo de correo electrónico
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), // Bordes más suaves
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100], // Fondo claro y suave para el campo
                ),
              ),
              const SizedBox(height: 20),

              // Campo de contraseña
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), // Bordes más suaves
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100], // Fondo claro y suave para el campo
                ),
              ),
              const SizedBox(height: 40),

              // Botón de registrarse
              _isLoading
                  ? const CircularProgressIndicator() // Mostrar indicador de carga
                  : ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Un color más brillante para el botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Bordes suaves
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Color del texto en blanco para un buen contraste
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Botón para ir a la página de inicio de sesión
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text(
                  '¿Ya tienes una cuenta? Iniciar Sesión',
                  style: TextStyle(
                    color: Colors.blue, // Texto azul para el enlace
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
