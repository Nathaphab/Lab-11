import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/event_model.dart';
import '../state/event_provider.dart';

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {

  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Event"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Event Title",
              ),
            ),

            const SizedBox(height: 20),
ElevatedButton(
  style: ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    backgroundColor: Colors.blueAccent,
  ),
  child: const Text(
    "SAVE EVENT",
    style: TextStyle(fontSize: 16),
  ),
  onPressed: () async {

    final event = EventModel(
      title: titleController.text,
      description: "",
      categoryId: 1,
      eventDate: DateTime.now().toString(),
      startTime: "10:00",
      endTime: "11:00",
      status: "pending",
      priority: 1,
    );

    await provider.addEvent(event);

    Navigator.pop(context);
  },
)

          ],
        ),
      ),
    );
  }
}