import 'package:flutter/cupertino.dart';
import 'package:todo_list/model/my_user.dart';

class AuthUserProvider extends ChangeNotifier{
  // data
  MyUser? currentUser;

  void updateUser(MyUser newUser){
    currentUser = newUser;
    notifyListeners();
  }
}