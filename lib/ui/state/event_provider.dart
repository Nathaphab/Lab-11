import 'package:flutter/material.dart';
import '../../data/models/event_model.dart';
import '../../data/repositories/event_repository.dart';

class EventProvider extends ChangeNotifier {

  final EventRepository repo = EventRepository();

  List<EventModel> events = [];

  Future loadEvents() async {

    events = await repo.getAll();
    notifyListeners();
  }

  Future addEvent(EventModel event) async {

    await repo.insert(event);
    await loadEvents();
  }

  Future updateEvent(EventModel event) async {

    await repo.update(event);
    await loadEvents();
  }

  Future deleteEvent(int id) async {

    await repo.delete(id);
    await loadEvents();
  }
}