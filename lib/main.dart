import 'package:cadastro_provider/models/user.dart';
import 'package:cadastro_provider/provider/users_provider.dart';
import 'package:cadastro_provider/routes/app_routes.dart';
import 'package:cadastro_provider/views/user_form.dart';
import 'package:cadastro_provider/views/user_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UsersProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            AppRoutes.HOME:(context)=>UserList(),
            AppRoutes.USER_FORM:(context)=>UserForm(),
          },
        ));
  }
}
