import 'package:dio/dio.dart';
import 'package:exercice_api/data/modeles/authenticated_user.dart';
import 'package:exercice_api/data/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Dio api = Api.api();

  Future<User> login(Map<String, dynamic> userData) async {
    try {
      final response = await api.post(
        'authentication',
        data: userData,
      );
      if (response.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        final token = response.data["accessToken"];
        prefs.setString('token', token);
        return User.fromJson(
          response.data["user"],
        );
      } else {
        throw Exception(
          'Échec de la connexion',
        );
      }
    } catch (error) {
      throw Exception(
        'Erreur de connexion: $error',
      );
    }
  }

  Future<User> create(Map<String, dynamic> userData) async {
    try {
      final response = await api.post(
        'users',
        data: userData,
      );
      if (response.statusCode == 200) {
        return User.fromJson(
          response.data,
        );
      } else {
        throw Exception(
          'Échec de la connexion',
        );
      }
    } catch (error) {
      throw Exception(
        'Erreur de connexion: $error',
      );
    }
  }
}
