import 'package:flutter/material.dart';
import 'package:flutter_mvvm/users_list/view_models/users_view_model.dart';
import 'package:flutter_mvvm/users_list/views/user_detail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UsersViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users list'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _ui(userViewModel),
      ),
    );
  }

  Widget _ui(UsersViewModel usersViewModel) {
    if (usersViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (usersViewModel.userError != null) {
      return Center(
        child: Text(usersViewModel.userError!.message as String),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              final user = usersViewModel.userListModel[index];
              return ListTile(
                onTap: () {
                  usersViewModel.setSelectedUser(user);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const UserDetailScreen();
                      },
                    ),
                  );
                },
                leading: const Icon(Icons.person),
                title: Text(user.name),
                subtitle: Text(user.email),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: usersViewModel.userListModel.length,
          ),
        ),
      ],
    );
  }
}
