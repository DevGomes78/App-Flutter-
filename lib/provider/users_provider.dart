import 'dart:convert';
import 'package:cadastro_provider/data/dummy_users.dart';
import 'package:cadastro_provider/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UsersProvider with ChangeNotifier {
  final url = Uri.parse('https://shopgomes-764b4-default-rtdb.firebaseio.com/');
  final Map<String, User> _items = {...Dummy_Users};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User ByIndex(int index) {
    return _items.values.elementAt(index);
  }

  Future<void> put(User user) async {
    if (user == null) {
      return;
    }
    if (user.id != null &&
        user.id!.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      await http.patch(
        Uri.parse("$url/users${user.id}.json"),
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl,
        }),
      );

      _items.update(user.id.toString(), (_) => user);
    } else {
      final response = await http.post(
        Uri.parse("$url/users.json"),
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl,
        }),
      );
      final id = json.decode(response.body)['name'];

      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }
    notifyListeners();
  }

  void remove(User user) {
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
