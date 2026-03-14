# 📅 Event Reminder App

แอปพลิเคชันสำหรับจัดการกิจกรรมและการแจ้งเตือน พัฒนาด้วย **Flutter + SQLite + Provider**
สามารถเพิ่ม แก้ไข ลบ และติดตามสถานะของกิจกรรมได้ภายในแอปเดียว

---

# 🎯 วัตถุประสงค์ของโปรเจกต์

โปรเจกต์นี้จัดทำขึ้นเพื่อศึกษาการพัฒนา Mobile Application ด้วย Flutter โดยเน้นหัวข้อ

* การจัดการฐานข้อมูลด้วย **SQLite**
* การจัดการ State ด้วย **Provider**
* การพัฒนา **CRUD (Create, Read, Update, Delete)**
* การออกแบบ **User Interface (UI)**

---

# ⚙️ เทคโนโลยีที่ใช้

| เทคโนโลยี        | รายละเอียด                               |
| ---------------- | ---------------------------------------- |
| Flutter          | Framework สำหรับพัฒนา Mobile Application |
| Provider         | State Management                         |
| SQLite (sqflite) | Local Database                           |
| Dart             | ภาษาโปรแกรมที่ใช้พัฒนา Flutter           |

---

# ✨ ฟีเจอร์ของแอป

✔ เพิ่มกิจกรรม (Add Event)
✔ แก้ไขกิจกรรม (Edit Event)
✔ ลบกิจกรรม (Delete Event)
✔ จัดการประเภทกิจกรรม (Category)
✔ แสดงสถานะกิจกรรม

สถานะกิจกรรมที่รองรับ

* Pending
* In Progress
* Completed
* Cancelled

✔ ระบบการตั้งแจ้งเตือนกิจกรรม

---

# 🗂 โครงสร้างโปรเจกต์

```
lib
│
├── data
│   ├── db
│   │   └── database_helper.dart
│   │
│   ├── models
│   │   ├── event_model.dart
│   │   ├── category_model.dart
│   │   └── reminder_model.dart
│   │
│   └── repositories
│       ├── event_repository.dart
│       ├── category_repository.dart
│       └── reminder_repository.dart
│
├── ui
│   ├── screens
│   │   ├── home_screen.dart
│   │   ├── event_form_screen.dart
│   │   ├── event_detail_screen.dart
│   │   └── category_screen.dart
│   │
│   ├── state
│   │   ├── event_provider.dart
│   │   └── category_provider.dart
│   │
│   └── widgets
│       └── event_card.dart
│
└── main.dart
```

---

# 🗄 โครงสร้างฐานข้อมูล

### ตาราง categories

| Field     | Description |
| --------- | ----------- |
| id        | รหัสประเภท  |
| name      | ชื่อประเภท  |
| color_hex | สีของประเภท |
| icon_key  | ไอคอน       |

### ตาราง events

| Field       | Description    |
| ----------- | -------------- |
| id          | รหัสกิจกรรม    |
| title       | ชื่อกิจกรรม    |
| description | รายละเอียด     |
| category_id | ประเภทกิจกรรม  |
| event_date  | วันที่         |
| start_time  | เวลาเริ่ม      |
| end_time    | เวลาสิ้นสุด    |
| status      | สถานะ          |
| priority    | ระดับความสำคัญ |

### ตาราง reminders

| Field          | Description          |
| -------------- | -------------------- |
| id             | รหัสแจ้งเตือน        |
| event_id       | กิจกรรม              |
| minutes_before | แจ้งเตือนก่อนกี่นาที |
| remind_at      | เวลาแจ้งเตือน        |
| is_enabled     | เปิด/ปิด             |

---

# 📷 ตัวอย่างหน้าจอแอป

## หน้า Home (รายการกิจกรรม)

<img width="654" height="925" alt="image" src="https://github.com/user-attachments/assets/f74cedcb-496f-4e03-b11d-751460a81470" />


---

## หน้าเพิ่มกิจกรรม
<img width="443" height="1014" alt="Image" src="https://github.com/user-attachments/assets/e2d99141-5bc2-412c-9ce3-d96f4ac7a634" />

---

# ▶ วิธีรันโปรเจกต์

ติดตั้ง dependencies

```
flutter pub get
```

รันแอป

```
flutter run
```

---

# 👨‍💻 ผู้พัฒนา
Kittaphon Laemthai
พัฒนาเพื่อการศึกษาในรายวิชา Mobile Application Development
