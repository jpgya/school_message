import 'package:flutter/material.dart';
import 'main.dart'; // Role, messages, absences, users を参照

class HomeScreen extends StatelessWidget {
  final Role role;
  final String username;

  HomeScreen({required this.role, required this.username});

  @override
  Widget build(BuildContext context) {
    switch (role) {
      case Role.student:
        return _studentView();
      case Role.parent:
        return _parentView(context);
      case Role.school:
        return _schoolView(context);
    }
  }

  Widget _studentView() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: messages
          .map((msg) => Card(
        child: ListTile(
          title: Text(msg['title'] ?? ''),
          subtitle: Text(msg['body'] ?? ''),
        ),
      ))
          .toList(),
    );
  }

  Widget _parentView(BuildContext context) {
    final childController = TextEditingController();
    final reasonController = TextEditingController();

    return Column(
      children: [
        Expanded(child: _studentView()),
        Divider(),
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text('欠席届送信'),
              TextField(controller: childController, decoration: InputDecoration(labelText: '子供の名前')),
              TextField(controller: reasonController, decoration: InputDecoration(labelText: '理由')),
              ElevatedButton(
                onPressed: () {
                  if (childController.text.isNotEmpty && reasonController.text.isNotEmpty) {
                    absences.add({
                      'child': childController.text,
                      'message': reasonController.text,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('送信しました')));
                    childController.clear();
                    reasonController.clear();
                  }
                },
                child: Text('送信'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _schoolView(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(tabs: [Tab(text: 'メッセージ'), Tab(text: '欠席届'), Tab(text: 'ユーザー')]),
          Expanded(
            child: TabBarView(
              children: [
                // メッセージ送信
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(controller: titleController, decoration: InputDecoration(labelText: 'タイトル')),
                      TextField(controller: bodyController, decoration: InputDecoration(labelText: '本文')),
                      ElevatedButton(
                        onPressed: () {
                          if (titleController.text.isNotEmpty && bodyController.text.isNotEmpty) {
                            messages.add({
                              'title': titleController.text,
                              'body': bodyController.text,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('送信しました')));
                            titleController.clear();
                            bodyController.clear();
                          }
                        },
                        child: Text('送信'),
                      ),
                    ],
                  ),
                ),
                // 欠席届一覧
                ListView(
                  children: absences
                      .map((a) => ListTile(
                    title: Text('${a['child']} さん'),
                    subtitle: Text(a['message'] ?? ''),
                  ))
                      .toList(),
                ),
                // ユーザー一覧
                ListView(
                  children: users.entries
                      .map((entry) => ListTile(
                    title: Text(entry.key),
                    subtitle: Text('役割: ${entry.value['role'].toString().split('.').last}'),
                  ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}