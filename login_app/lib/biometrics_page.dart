import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricsPage extends StatefulWidget {
  const BiometricsPage({Key? key}) : super(key: key);

  @override
  _BiometricsPageState createState() => _BiometricsPageState();
}

class _BiometricsPageState extends State<BiometricsPage> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isBiometricAvailable = false;
  bool _isAuthenticated = false;
  String _statusMessage = 'No autenticado';

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    setState(() {
      _isBiometricAvailable = canCheckBiometrics;
    });
  }

  Future<void> _authenticate() async {
    try {
      final isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Por favor autentícate para activar esta función.',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      setState(() {
        _isAuthenticated = isAuthenticated;
        _statusMessage = isAuthenticated ? 'Autenticación exitosa' : 'Autenticación fallida';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error en la autenticación: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración Biométrica'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isBiometricAvailable
                  ? 'Biometría disponible en este dispositivo.'
                  : 'La biometría no está disponible en este dispositivo.',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _isBiometricAvailable ? _authenticate : null,
              icon: const Icon(Icons.fingerprint),
              label: const Text('Activar Biometría'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _statusMessage,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context); // Regresa al menú principal
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver al menú'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
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
}
