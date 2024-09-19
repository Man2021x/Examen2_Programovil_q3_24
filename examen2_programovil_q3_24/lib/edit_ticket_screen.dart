import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditTicketScreen extends StatefulWidget {
    
   final String ticketId;
 const EditTicketScreen({super.key, required this.ticketId});
 // const EditTicketScreen({super.key, required this.ticketId});

  @override
  _EditTicketScreenState createState() => _EditTicketScreenState();
}

class _EditTicketScreenState extends State<EditTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _aerolineaController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _aerolineaController = TextEditingController();
    _loadTicketData();
  }

  // Cargar los datos del ticket desde Firestore
  Future<void> _loadTicketData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('TicketAvion')
        .doc(widget.ticketId)
        .get();

    if (doc.exists) {
      setState(() {
        _nombreController.text = doc['nombre'];
        _aerolineaController.text = doc['aerolinea'];
      });
    }
  }

  // Actualizar los datos en Firestore
  Future<void> _updateTicket() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection('TicketAvion')
          .doc(widget.ticketId)
          .update({
        'nombre': _nombreController.text,
        'aerolinea': _aerolineaController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Ticket actualizado con éxito'),
      ));
      Navigator.pop(context); // Vuelve a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Ticket')),
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
                onPressed: _updateTicket,
                child: const Text('Guardar cambios'),
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
