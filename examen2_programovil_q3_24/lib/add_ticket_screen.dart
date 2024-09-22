import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/ticket_provider.dart';
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final ticketData = {
                      'nombre': _nombreController.text,
                      'aerolinea': _aerolineaController.text,
                      'creadoEn': Timestamp.now(),
                    };
                    Provider.of<TicketProvider>(context, listen: false)
                        .addTicket(ticketData);
                    Navigator.pop(context); // Vuelve a la pantalla anterior
                  }
                },
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
