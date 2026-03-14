import 'package:flutter/material.dart';
import '../../data/models/event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  Color statusColor() {
    switch (event.status) {
      case "pending":
        return Colors.orange;
      case "in_progress":
        return Colors.blue;
      case "completed":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff1e3c72), Color(0xff2a5298)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: ListTile(
        title: Text(
          event.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${event.eventDate} | ${event.startTime} - ${event.endTime}",
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: Chip(
          label: Text(
            event.status,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: statusColor(),
        ),
      ),
    );
  }
}