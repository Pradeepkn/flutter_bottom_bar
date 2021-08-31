import 'package:bottom_navigation_bar/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserRepository _repository = UserRepository();

  UserContainer usercontainer = UserContainer();

  UserProvider(String userId) {
    fetchUserName();
  }

  void changeValue(String newValue) {
    usercontainer.username = newValue;
    notifyListeners();
  }

  fetchUserName() {
    usercontainer.username = _repository.getUserName();
    notifyListeners();
  }

  fetchPassword() {
    usercontainer.password = _repository.getPassword();
    notifyListeners();
  }
}

class UserContainer {
  String username = 'User name';
  String password = 'Password';
}
