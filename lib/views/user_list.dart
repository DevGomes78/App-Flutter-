import 'package:cadastro_provider/components/user_tile.dart';
import 'package:cadastro_provider/provider/users_provider.dart';
import 'package:cadastro_provider/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final UsersProvider users = Provider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cadastro de Usuarios'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (context, index) => UserTile(
          users.ByIndex(index),
        ),
      ),
    );
  }
}
