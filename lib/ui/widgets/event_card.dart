import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // ⭐ 1. เพิ่ม import สำหรับ Provider

import '../../data/models/event_model.dart';
import '../state/event_provider.dart'; // ⭐ 2. เพิ่ม import เพื่อเรียกใช้ EventProvider

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
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
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
        // ⭐ 3. เปลี่ยนแปลง trailing ตรงนี้เป็น Row เพื่อให้ใส่ปุ่มลบต่อท้าย Chip ได้
        trailing: Row(
          mainAxisSize: MainAxisSize.min, // สำคัญมาก เพื่อไม่ให้ Row กินพื้นที่ล้นหน้าจอ
          children: [
            Chip(
              label: Text(
                event.status,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: statusColor(),
            ),
            // ปุ่มถังขยะ
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                // เด้ง Dialog ถามความแน่ใจก่อนลบ
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Delete Event"),
                    content: const Text("Are you sure you want to delete this event?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx), // กด Cancel เพื่อปิดหน้าต่าง
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          // ⭐ เรียกใช้คำสั่งลบจาก EventProvider
                          Provider.of<EventProvider>(context, listen: false).deleteEvent(event.id!);
                          
                          Navigator.pop(ctx); // ลบเสร็จให้ปิด Dialog
                        },
                        child: const Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}