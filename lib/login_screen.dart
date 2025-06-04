import 'package:flutter/material.dart';
import 'main.dart'; // users や Role を使うために必要

class LoginScreen extends StatefulWidget {
  final void Function(String username) onLogin;

  const LoginScreen({required this.onLogin, super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  Role _selectedRole = Role.student;

  void _tryLogin(BuildContext context) {
    final user = _usernameController.text.trim();
    final pass = _passwordController.text;

    if (users.containsKey(user) && users[user]!['password'] == pass) {
      widget.onLogin(user);
    } else {
      _showDialog(context, 'ログイン失敗', 'ユーザー名またはパスワードが間違っています。');
    }
  }

  void _tryRegister(BuildContext context) {
    final user = _usernameController.text.trim();
    final pass = _passwordController.text;

    if (user.isEmpty || pass.isEmpty) {
      _showDialog(context, 'エラー', 'ユーザー名とパスワードを入力してください。');
      return;
    }

    if (users.containsKey(user)) {
      _showDialog(context, 'エラー', 'そのユーザー名は既に使われています。');
    } else {
      users[user] = {
        'password': pass,
        'role': _selectedRole,
      };
      _showDialog(context, '登録成功', 'ユーザー "$user" を登録しました。ログインできます。');
    }
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(tabs: [
            Tab(text: 'ログイン'),
            Tab(text: '新規登録'),
          ]),
          Expanded(
            child: TabBarView(
              children: [
                // ログインタブ
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(labelText: 'ユーザー名'),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'パスワード'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _tryLogin(context),
                        child: const Text('ログイン'),
                      ),
                    ],
                  ),
                ),

                // 新規登録タブ
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(labelText: 'ユーザー名'),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'パスワード'),
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<Role>(
                        value: _selectedRole,
                        items: Role.values.map((role) {
                          final name = role.toString().split('.').last;
                          return DropdownMenuItem<Role>(
                            value: role,
                            child: Text(name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedRole = value);
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _tryRegister(context),
                        child: const Text('登録'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}