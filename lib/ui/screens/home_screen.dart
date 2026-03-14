import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/event_provider.dart';
import '../widgets/event_card.dart';
import 'event_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() =>
        Provider.of<EventProvider>(context, listen: false).loadEvents());
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Reminder"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),

      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0f2027), Color(0xff203a43), Color(0xff2c5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: provider.events.isEmpty
            ? const Center(
                child: Text(
                  "No Events Yet",
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: provider.events.length,
                itemBuilder: (context, index) {

                  final event = provider.events[index];

                  return EventCard(event: event);
                },
              ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const EventFormScreen(),
            ),
          );
        },
      ),
    );
  }
}