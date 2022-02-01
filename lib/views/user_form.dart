import 'package:cadastro_provider/models/user.dart';
import 'package:cadastro_provider/provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  bool _isLoading = false;

  final Map<String, String> _formData = {};

  void _loadFormData(User user){
  _formData['id']= user.id!;
  _formData['name']= user.name!;
  _formData['email']= user.email!;
  _formData['avatarUrl']= user.avatarUrl!;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Usuario'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<UsersProvider>(context, listen: false).put(
                  User(
                      id: _formData['id'],
                      name: _formData['name'],
                      email: _formData['email'],
                      avatarUrl: _formData['avatarUrl']),
                );
                setState(() {
                  _isLoading = false;
                });
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _formData['name'] ,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Campo Nome em branco!';
                        }
                        if (value.trim().length < 4) {
                          return 'Nome inferior a 5 letras!';
                        }
                        return null;
                      },
                      onSaved: (value) => _formData['name'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['email'] ,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'campo Email em Branco!';
                        }
                        if (value.trim().length < 4) {
                          return 'Nome inferior a 4 letras';
                        }
                        return null;
                      },
                      onSaved: (value) => _formData['email'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['AvatarUrl'] ,
                      decoration: InputDecoration(
                        labelText: 'Avatar',
                      ),
                      onSaved: (value) => _formData['avatarUrl'] = value!,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
