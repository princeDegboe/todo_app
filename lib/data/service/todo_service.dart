import 'package:dio/dio.dart';
import 'package:exercice_api/data/modeles/todo.dart';
import 'package:exercice_api/data/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoService {
  Dio api = Api.api();

  Future<Todo> create(Map<String, dynamic> data) async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = token;
    }

    final response = await api.post(
      'todos',
      data: data,
    );
    //Mobile Development
//A Sweeeet course.  Don't miss it.
    return Todo.fromMap(response.data);
  }

  Future<Todo> get(String id) async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = token;
    }

    final response = await api.get('todos/$id');

    return Todo.fromMap(response.data);
  }

  Future<List<Todo>> getAll() async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    if (token != "") {
      api.options.headers['AUTHORIZATION'] = token;
    }
    final response = await api.get('todos');

    return (response.data as List).map(
      (e) {
        return Todo.fromMap(e);
      },
    ).toList();
  }
}
