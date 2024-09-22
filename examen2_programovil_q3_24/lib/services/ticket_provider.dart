import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketProvider extends ChangeNotifier {
  final CollectionReference _ticketsCollection =
      FirebaseFirestore.instance.collection('TicketAvion');

  List<DocumentSnapshot> _tickets = [];
  List<DocumentSnapshot> get tickets => _tickets;

  // Método para obtener todos los tickets
  Future<void> fetchTickets() async {
    try {
      QuerySnapshot snapshot = await _ticketsCollection.get();
      _tickets = snapshot.docs;
      notifyListeners();
    } catch (e) {
      // Manejo de errores
      print("Error fetching tickets: $e");
    }
  }

  // Método para añadir un nuevo ticket
  Future<void> addTicket(Map<String, dynamic> ticketData) async {
    try {
      await _ticketsCollection.add(ticketData);
      fetchTickets(); // Actualiza la lista de tickets después de añadir
    } catch (e) {
      print("Error adding ticket: $e");
    }
  }

  // Método para editar un ticket existente
  Future<void> editTicket(String ticketId, Map<String, dynamic> updatedData) async {
    try {
      await _ticketsCollection.doc(ticketId).update(updatedData);
      fetchTickets(); // Actualiza la lista de tickets después de editar
    } catch (e) {
      print("Error editing ticket: $e");
    }
  }

  // Método para eliminar un ticket
  Future<void> deleteTicket(String ticketId) async {
    try {
      await _ticketsCollection.doc(ticketId).delete();
      fetchTickets(); // Actualiza la lista de tickets después de eliminar
    } catch (e) {
      print("Error deleting ticket: $e");
    }
  }
}
