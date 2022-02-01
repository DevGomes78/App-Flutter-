import 'package:cadastro_provider/models/user.dart';
import 'package:cadastro_provider/routes/app_routes.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {

    final avatar = user.avatarUrl == null || user.avatarUrl!.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl.toString()));

    return Card(
      elevation: 5,
      child: ListTile(
        leading: avatar,
        title: Text(user.name.toString()),
        subtitle: Text(user.email.toString()),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      AppRoutes.USER_FORM
                  );
                },
                icon: Icon(Icons.edit, color: Colors.orange),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
