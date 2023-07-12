import 'package:flutter/material.dart';
import '../model/API/user_api.dart';
import '../model/user_model.dart';

enum DataStatus {
  loading,
  loaded,
  error,
}

class UserViewModel extends ChangeNotifier {
  List<Data> _user = [];
  List<Data> get user => _user;

  DataStatus get dataStatus => _dataStatus;
  DataStatus _dataStatus = DataStatus.loading;

  getUser({required pages, required perPages}) async {
    _dataStatus = DataStatus.loading;
    notifyListeners();

    try {
      final response = await UserAPI().getUser(
        pages: pages,
        perPages: perPages,
      );
      _user = response;
      _dataStatus = DataStatus.loaded;
    } catch (e) {
      _dataStatus = DataStatus.error;
    }
    notifyListeners();
  }
}

class SelectedUser with ChangeNotifier {
  String _firstName = 'John Doe';

  String get firstName => _firstName;

  void selectedUser(String firstName) {
    _firstName = firstName;
    notifyListeners();
  }
}