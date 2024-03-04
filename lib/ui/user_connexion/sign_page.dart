import 'package:dio/dio.dart';
import 'package:exercice_api/data/service/user_service.dart';
import 'package:exercice_api/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserConnexion extends StatefulWidget {
  const UserConnexion({
    super.key,
  });

  @override
  State<UserConnexion> createState() => _UserConnexionState();
}

class _UserConnexionState extends State<UserConnexion> {
  bool isPressedBack = false;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;

  final _userService = UserService();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  login(data) async {
    isLoading = true;
    try {
      var response = await _userService.login(data);
      final pref = await SharedPreferences.getInstance();
      pref.setString("token", response.accessToken!);
      final List<String> usernames =
          pref.getStringList("usernames") ?? List.empty();
      final List<String> emails = pref.getStringList("emails") ?? List.empty();
      if (emails.isEmpty || !emails.contains(response.user!.email)) {
        usernames.add(response.user!.username ?? "");
        emails.add(response.user!.email ?? "");
        pref.setStringList("usernames", usernames);
        pref.setStringList("emails", emails);
      }
      Fluttertoast.showToast(
        msg: "${response.user!.username} connecté avec succès",
        backgroundColor: const Color(0xFF146CC2),
        timeInSecForIosWeb: 4,
      );
      _emailController.text = "";
      _passwordController.text = "";
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } on DioException catch (e) {
      Fluttertoast.showToast(
        msg: "Erreur",
        backgroundColor: const Color(0xFF146CC2),
        timeInSecForIosWeb: 4,
      );
      if (e.response != null) {
        throw Exception("Error: ${e.response!.data}");
      } else {
        throw Exception("Error: ${e.message}");
      }
    } finally {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
            0,
            0,
            0,
            width / 15,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Text(
                    "Confirmer votre ",
                    style: TextStyle(
                      color: const Color(0xFF146CC2),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: width / 18,
                    ),
                  ),
                ),
                WidgetSpan(
                  child: Text(
                    "identité ",
                    style: TextStyle(
                      color: const Color(0xFFF7941F),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: width / 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Color(0x10000000),
                ),
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "  Champs obligatoire  ";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    labelText: "  Email *  ",
                    hintText: 'Ex: uldjoss56@gmail.com',
                    errorStyle: TextStyle(
                      backgroundColor: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xAAF7941F),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Color(0x10000000),
                ),
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    labelText: "Mot de passe",
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xAAF7941F),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFFF7941F),
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await login(
                {
                  "strategy": "local",
                  "email": _emailController.text,
                  "password": _passwordController.text,
                },
              );
              setState(() {});
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            backgroundColor: const Color(0xFFF7941F),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: width / 4,
              vertical: width / 30,
            ),
          ),
          child: Text(
            "Se connecter",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: width / 20,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(width / 30),
          padding: EdgeInsets.all(width / 30),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFF7941F),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Text(
            "Récupérez-votre compte ?",
            style: TextStyle(
              //color: const Color(0xFFF7941F),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: width / 30,
            ),
          ),
        ),
        SizedBox(
          height: width / 10,
        ),
      ],
    );
  }
}
