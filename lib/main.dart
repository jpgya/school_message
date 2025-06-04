import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';

void main() => runApp(MyApp());

enum Role { student, parent, school }

// main.dart

final users = <String, Map<String, dynamic>>{
  '生徒': {'password': '1', 'role': Role.student},
  '保護者': {'password': '1', 'role': Role.parent},
  '学校': {'password': '1', 'role': Role.school},
};



List<Map<String, String>> messages = [];
List<Map<String, String>> absences = [];

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _loggedInUser;
  Role? _role;

  void _login(String username) {
    setState(() {
      _loggedInUser = username;
      _role = users[username]!['role'] as Role;
    });
  }

  void _logout() {
    setState(() {
      _loggedInUser = null;
      _role = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'スクールメッセージ',
      home: Scaffold(
        appBar: AppBar(
          title: Text('スクールメッセージ'),
          actions: _loggedInUser != null
              ? [IconButton(onPressed: _logout, icon: Icon(Icons.logout))]
              : null,
        ),
        body: _loggedInUser == null
            ? LoginScreen(onLogin: _login)
            : HomeScreen(role: _role!, username: _loggedInUser!),
      ),
    );
  }
}