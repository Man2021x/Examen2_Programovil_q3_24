import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'services/ticket_provider.dart';

class TicketListScreen extends StatelessWidget {
   const TicketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Tickets de Avión')),
      body: FutureBuilder(
        future: ticketProvider.fetchTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (ticketProvider.tickets.isEmpty) {
            return const Center(child: Text('No hay tickets disponibles'));
          }

          return ListView.builder(
            itemCount: ticketProvider.tickets.length,
            itemBuilder: (context, index) {
              var ticket = ticketProvider.tickets[index];
              return ListTile(
                title: Text(ticket['nombre']),
                subtitle: Text('Aerolínea: ${ticket['aerolinea']}'),
                onTap: () {
                  // Navega a la pantalla de edición con el ID del ticket
                  context.go('/edit-ticket/${ticket.id}');
                },
              );
            },
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
