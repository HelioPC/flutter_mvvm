import 'package:flutter/material.dart';
import 'package:flutter_mvvm/users_list/models/user_error.dart';
import 'package:flutter_mvvm/users_list/models/users_list_model.dart';
import 'package:flutter_mvvm/users_list/repo/api_status.dart';
import 'package:flutter_mvvm/users_list/repo/user_services.dart';

class UsersViewModel extends ChangeNotifier {
  bool _loading = false;
  List<UserModel> _userListModel = [];
  UserModel? _selectedUser;
  UserError? _userError;

  bool get loading => _loading;
  List<UserModel> get userListModel => _userListModel;
  UserModel? get selectedUser => _selectedUser;
  UserError? get userError => _userError;

  UsersViewModel() {
    getUsers();
  }

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setUserListModel(List<UserModel> list) {
    _userListModel = list;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setSelectedUser(UserModel userModel) {
    _selectedUser = userModel;
    notifyListeners();
  }

  addUser(UserModel userModel) async {
    _userListModel.add(userModel);
  }

  getUsers() async {
    setLoading(true);
    var response = await UserServices.getUsers();

    if (response is Success) {
      setUserListModel(response.response as List<UserModel>);
    }

    if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.errorResponse,
      );
      setUserError(userError);
    }
    setLoading(false);
  }
}
