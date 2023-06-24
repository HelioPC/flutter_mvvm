import 'package:flutter/material.dart';
import 'package:flutter_mvvm/users_list/view_models/users_view_model.dart';
import 'package:provider/provider.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UsersViewModel>().selectedUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  'Hello, ${user.name}',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(height: 40),
              Text(user.email),
              Text(user.phone),
            ],
          ),
        ),
      ),
    );
  }
}
