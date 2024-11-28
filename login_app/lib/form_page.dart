import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _picker = ImagePicker();
  File? _imageFile; // Almacena la imagen seleccionada
  String? _imageUrl; // Almacena la URL de la imagen subida a Firebase Storage
  final _classroomController = TextEditingController();
  final _noteController = TextEditingController();
  bool _isLoading = false; // Indica si hay un proceso en curso

  // Función para seleccionar una imagen desde la cámara
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50, // Ajusta la calidad de la imagen
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showError('Error al seleccionar la imagen: $e');
    }
  }

  // Función para subir la imagen a Firebase Storage
 Future<void> _uploadImage() async {
  if (_imageFile == null) {
    _showSnackbar('Por favor, toma una foto primero.');
    return;
  }

  setState(() => _isLoading = true);

  try {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child('reports/$fileName');

    // Subir la imagen y esperar a que termine
    UploadTask uploadTask = ref.putFile(_imageFile!);
    await uploadTask.whenComplete(() => {});

    // Obtener la URL de descarga
    String downloadUrl = await ref.getDownloadURL();
    setState(() {
      _imageUrl = downloadUrl;
    });

    _showSnackbar('Imagen subida con éxito!');
  } catch (e) {
    _showError('Error al subir la imagen: $e');
  } finally {
    setState(() => _isLoading = false);
  }
}

  // Función para guardar el formulario en Firestore
  Future<void> _saveForm() async {
    String classroom = _classroomController.text.trim();
    String note = _noteController.text.trim();

    if (classroom.isEmpty || note.isEmpty) {
      _showSnackbar('Por favor, llena todos los campos.');
      return;
    }

    if (_imageUrl == null) {
      _showSnackbar('Por favor, sube una foto.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('forms').add({
        'classroom': classroom,
        'note': note,
        'picture': _imageUrl,
        'date': DateTime.now(),
        'timestamp': FieldValue.serverTimestamp(),
        'user': FirebaseAuth.instance.currentUser?.email,
      });

      _showSnackbar('Formulario enviado con éxito!');

      // Limpiar el formulario
      setState(() {
        _classroomController.clear();
        _noteController.clear();
        _imageFile = null;
        _imageUrl = null;
      });
    } catch (e) {
      _showError('Error al guardar el formulario: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Función para mostrar mensajes de error en consola y al usuario
  void _showError(String message) {
    print(message);
    _showSnackbar('Ocurrió un error: $message');
  }

  // Función para mostrar mensajes al usuario
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario de Reporte"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _classroomController,
                      decoration: InputDecoration(labelText: 'Salón'),
                    ),
                    TextField(
                      controller: _noteController,
                      decoration: InputDecoration(labelText: 'Nota'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Tomar Foto'),
                    ),
                    SizedBox(height: 20),
                    _imageFile != null
                        ? Image.file(_imageFile!)
                        : Text('No se ha seleccionado una imagen.'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _uploadImage,
                      child: Text('Subir Foto'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _saveForm,
                      child: Text('Enviar Formulario'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
