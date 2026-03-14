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

  // ⭐ 1. ตัวแปรสำหรับเก็บวันที่และเวลา (ค่าเริ่มต้นคือเวลาปัจจุบัน)
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay(
    hour: (TimeOfDay.now().hour + 1) % 24, // บังคับให้เวลาจบ บวกไป 1 ชั่วโมง
    minute: TimeOfDay.now().minute,
  );

  // ⭐ 2. ฟังก์ชันเปิดปฏิทินเลือกวันที่
  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(), // ป้องกันไม่ให้เลือกวันในอดีต
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // ⭐ 3. ฟังก์ชันเปิดนาฬิกาเลือกเวลา
  Future<void> _pickTime(bool isStart) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (pickedTime != null) {
      setState(() {
        if (isStart) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }
      });
    }
  }

  // ⭐ ฟังก์ชันช่วยแปลงเวลาให้อยู่ในรูปแบบ "HH:mm" (เช่น 09:30, 14:00) สำหรับเซฟลงฐานข้อมูล
  String _formatTime(TimeOfDay time) {
    final String hour = time.hour.toString().padLeft(2, '0');
    final String minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    // แนะนำให้ใส่ listen: false เพื่อลดปัญหาตอนกดปุ่ม Save
    final provider = Provider.of<EventProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // กล่องกรอกชื่อ Event
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Event Title",
              ),
            ),
            const SizedBox(height: 20),

            // ⭐ 4. UI สำหรับแสดงและกดเลือก วันที่/เวลา
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Date"),
              subtitle: Text(
                "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              trailing: const Icon(Icons.calendar_today, color: Colors.blueAccent),
              onTap: _pickDate, // กดเพื่อเด้งปฏิทิน
            ),
            const Divider(), // เส้นคั่น
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Start Time"),
                    subtitle: Text(
                      _startTime.format(context),
                      style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
                    ),
                    trailing: const Icon(Icons.access_time, color: Colors.blueAccent),
                    onTap: () => _pickTime(true), // กดเพื่อเด้งนาฬิกาเวลาเริ่ม
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("End Time"),
                    subtitle: Text(
                      _endTime.format(context),
                      style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
                    ),
                    trailing: const Icon(Icons.access_time, color: Colors.blueAccent),
                    onTap: () => _pickTime(false), // กดเพื่อเด้งนาฬิกาเวลาจบ
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // ปุ่ม SAVE EVENT
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white, // เพิ่มให้ตัวหนังสือเป็นสีขาวชัดเจนขึ้น
              ),
              child: const Text(
                "SAVE EVENT",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                // เช็คก่อนว่าไม่ได้ปล่อยชื่อว่างไว้
                if (titleController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter event title")),
                  );
                  return;
                }

                // ⭐ 5. ดึงค่าวันที่และเวลาที่เลือกมาบันทึก
                final event = EventModel(
                  title: titleController.text,
                  description: "",
                  categoryId: 1,
                  eventDate: _selectedDate.toString(), // ใช้วันที่ที่เลือก
                  startTime: _formatTime(_startTime),  // ใช้เวลาที่เลือก แปลงเป็น HH:mm
                  endTime: _formatTime(_endTime),      // ใช้เวลาที่เลือก แปลงเป็น HH:mm
                  status: "pending",
                  priority: 1,
                );

                await provider.addEvent(event);

                // เช็ค mounted ป้องกัน Error เวลากด Back
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}