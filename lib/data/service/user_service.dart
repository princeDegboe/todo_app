
import 'package:dio/dio.dart';
import 'package:exercice_api/data/modeles/authenticated_user.dart';
import 'package:exercice_api/data/service/api.dart';

class UserService {

  Dio api = Api.api();

  Future<AuthenticatedUser> login (Map<String, dynamic> data) async{
    final response = await api.post('authentication', data: data);

    return AuthenticatedUser.fromJson(response.data);
  }

  Future<User> create (Map<String, dynamic> data) async{
    final response = await api.post('users', data: data);

    return User.fromJson(response.data);
  }

}