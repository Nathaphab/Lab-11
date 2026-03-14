class EventModel {
  final int? id;
  final String title;
  final String description;
  final int categoryId;
  final String eventDate;
  final String startTime;
  final String endTime;
  final String status;
  final int priority;

  EventModel({
    this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.eventDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category_id': categoryId,
      'event_date': eventDate,
      'start_time': startTime,
      'end_time': endTime,
      'status': status,
      'priority': priority
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      categoryId: map['category_id'],
      eventDate: map['event_date'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      status: map['status'],
      priority: map['priority'],
    );
  }
}