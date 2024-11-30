import 'package:flutter/material.dart';

class SubmittedFormsPage extends StatelessWidget {
  const SubmittedFormsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formularios Enviados"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 5, // Cambiar esto al número real de formularios guardados
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Formulario #$index'),
                subtitle: const Text('Detalles del formulario enviado'),
                onTap: () {
                  // Aquí puedes navegar a una pantalla de detalles si lo deseas
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
