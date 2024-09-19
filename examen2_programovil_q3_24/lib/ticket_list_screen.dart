import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';


class TicketListScreen extends StatelessWidget {
   TicketListScreen({super.key});
  
  final CollectionReference tickets = FirebaseFirestore.instance.collection('TicketAvion');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar( title: const Text('Tickets de Avión')),
      body: StreamBuilder(
        stream: tickets.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['nombre']),
                onTap: () {
                  // Navega a la pantalla de edición con el ID del ticket
                  context.go('/edit-ticket/${doc.id}');
                },
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/add-ticket');  // Navega a la pantalla de añadir ticket
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
