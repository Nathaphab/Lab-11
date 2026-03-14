import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/state/event_provider.dart';
import 'ui/state/category_provider.dart';
import 'ui/screens/home_screen.dart';

void main() {
  runApp(const EventApp());
}

class EventApp extends StatelessWidget {
  const EventApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Event Reminder",
        // ⭐ เริ่มแก้ Theme ตรงนี้ ⭐
        theme: ThemeData(
          fontFamily: "Roboto",
          
          // 1. เปลี่ยนพื้นหลังแอปให้เป็นสีขาว/เทาอ่อน
          scaffoldBackgroundColor: Colors.grey[50], 
          
          // 2. ตั้งค่าชุดสีหลัก (เช่น ปุ่ม, สัญลักษณ์ต่างๆ) ตอนนี้ตั้งเป็นโทนสีน้ำเงิน
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent, 
            primary: Colors.blueAccent,
          ),

          // 3. กำหนดสีของแถบ AppBar ด้านบน
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blueAccent, // สีพื้น AppBar
            foregroundColor: Colors.white,      // สีตัวหนังสือและไอคอนบน AppBar
            elevation: 2,
            centerTitle: true,
          ),

          // 4. กำหนดสีปุ่มกด (ปุ่ม SAVE EVENT)
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        // ⭐ จบการแก้ Theme ⭐
        home: const HomeScreen(),
      ),
    );
  }
}