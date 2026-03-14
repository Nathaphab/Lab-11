import '../db/database_helper.dart';
import '../models/event_model.dart';

class EventRepository {

  Future<int> insert(EventModel event) async {

    final db = await DatabaseHelper.instance.database;

    return await db.insert("events", event.toMap());
  }

  Future<List<EventModel>> getAll() async {

    final db = await DatabaseHelper.instance.database;

    final result = await db.query("events");

    return result.map((e) => EventModel.fromMap(e)).toList();
  }

  Future<int> update(EventModel event) async {

    final db = await DatabaseHelper.instance.database;

    return await db.update(
      "events",
      event.toMap(),
      where: "id=?",
      whereArgs: [event.id],
    );
  }

  Future<int> delete(int id) async {

    final db = await DatabaseHelper.instance.database;

    return await db.delete(
      "events",
      where: "id=?",
      whereArgs: [id],
    );
  }
}