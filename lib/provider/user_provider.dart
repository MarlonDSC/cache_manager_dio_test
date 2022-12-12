import 'dart:convert';
import 'dart:developer';

import 'package:cache_manager_dio_test/classes/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../flutter_cache_manager_dio.dart';

class UserProvider with ChangeNotifier {
  String url = 'https://jsonplaceholder.typicode.com/users';
  List<UserModel> users = <UserModel>[];

  void fetchUsers() async {
    var dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: false));
    // DioCacheManager.initialize(dio);
    String url = 'https://jsonplaceholder.typicode.com/users';
    var file = await DioCacheManager.instance.getSingleFile(url);
    print(file.basename);
    print(' ${file.absolute}');
    print('❤️❤️ dirname ${file.dirname}');
        // print('Valid till 😂😂😂 ${xd.validTill}');

    print('\n 🛣️🛣️🛣️🛣️' + file.path);
    final contents = await file.readAsString();
    users.clear();


    // print('🗃️🗃️🗃️ $contents');
    // final file = await _localFile;
    // final contents = await file.readAsString();

    // log('read from ✅ $contents');

    List<Map<String, dynamic>> userMap = jsonDecode(contents);
    List<UserModel> usersEmpty = [];

    for(Map<String, dynamic> a in userMap){
      usersEmpty.add(UserModel.fromJson(a));
      print(a);
    }

    users = List.from(usersEmpty);
    // UserModel user = UserModel.fromJson();
    
    // print('XD ${user.name}');

    // print(file.rename('KLK'));
  }

  void addUser(UserModel newUser) {
    users.add(newUser);
    notifyListeners();
  }

  List<UserModel> get readUsers {
    return users;
  }

  void updateUser(int index, UserModel updatedUser) {
    users.removeAt(index);
    users.insert(index, updatedUser);
    notifyListeners();
  }

  void removeUser(int index) {
    users.removeAt(index);
    notifyListeners();
  }
}
