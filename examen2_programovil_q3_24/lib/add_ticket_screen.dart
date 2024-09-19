import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTicketScreen extends StatefulWidget {
      const AddTicketScreen({super.key});

  @override
  _AddTicketScreenState createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _aerolineaController = TextEditingController();

  // Método para agregar un nuevo ticket a Firestore
  Future<void> _addTicket() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('TicketAvion').add({
        'nombre': _nombreController.text,
        'aerolinea': _aerolineaController.text,
        'creadoEn': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ticket añadido con éxito')),
      );

      Navigator.pop(context); // Regresa a la pantalla anterior después de añadir el ticket
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Añadir Nuevo Ticket')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre del Ticket'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del ticket';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _aerolineaController,
                decoration: const InputDecoration(labelText: 'Aerolínea'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la aerolínea';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addTicket,
                child: const Text('Guardar Ticket'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _aerolineaController.dispose();
    super.dispose();
  }
}
