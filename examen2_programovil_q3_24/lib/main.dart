import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'ticket_list_screen.dart';
import 'add_ticket_screen.dart';  // Pantalla para añadir tickets
import 'edit_ticket_screen.dart'; // Pantalla para editar un ticket

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    MyApp({super.key});
  // Definir rutas usando GoRouter
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => TicketListScreen(),
      ),
      GoRoute(
        path: '/add-ticket',
        builder: (context, state) => const AddTicketScreen(),
      ),
      GoRoute(
        path: '/edit-ticket/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return EditTicketScreen(ticketId: id);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
    );
  }
}


