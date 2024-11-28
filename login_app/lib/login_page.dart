import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false; // Para mostrar el indicador de carga

  void _login() async {
    setState(() {
      _isLoading = true; // Inicia el indicador de carga
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      setState(() {
        _isLoading = false; // Detiene el indicador de carga
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
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
        title: Text("Login"),
        backgroundColor: Colors.transparent, // AppBar transparente para un look más limpio
        elevation: 0, // Eliminar la sombra del AppBar
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white, // Fondo blanco para un diseño más limpio
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Título central
              Text(
                '¡Hola, bienvenido!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Texto oscuro para contraste
                ),
              ),
              SizedBox(height: 40),

              // Campo de correo electrónico
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), // Bordes más suaves
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100], // Fondo claro y suave para el campo
                ),
              ),
              SizedBox(height: 20),

              // Campo de contraseña
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), // Bordes más suaves
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100], // Fondo claro y suave para el campo
                ),
              ),
              SizedBox(height: 40),

              // Botón de login
              _isLoading
                  ? CircularProgressIndicator() // Mostrar indicador de carga
                  : ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Un color más brillante para el botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Bordes suaves
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Color del texto en blanco para un buen contraste
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Botón para ir a la página de registro
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: Text(
                  '¿No tienes cuenta? Regístrate',
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
