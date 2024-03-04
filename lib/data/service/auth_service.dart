import 'package:dio/dio.dart';
import 'package:exercice_api/data/modeles/user.dart';
import 'package:exercice_api/data/service/api.dart';

class AuthService {
  Dio dio = Api.api();

  Future<User> login(Map<String, dynamic> userData) async {
    try {
      final response = await dio.post(
        '/authentication',
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
