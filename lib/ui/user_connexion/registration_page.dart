import 'package:dio/dio.dart';
import 'package:exercice_api/data/service/user_service.dart';
import 'package:exercice_api/ui/user_connexion/regis_connexion.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({
    super.key,
  });

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _userService = UserService();

  bool isLoading = false;

  signUp(data) async {
    isLoading = true;
    try {
      var response = await _userService.create(data);
      Fluttertoast.showToast(
        msg: "Utilisateur créé avec succès",
        backgroundColor: const Color(0xFF146CC2),
        timeInSecForIosWeb: 4,
      );
      _emailController.text = "";
      _usernameController.text = "";
      _passwordController.text = "";
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil<void>(
          MaterialPageRoute(
            builder: (_) => const RegisConnexion(
              isNotConnectedYet: true,
            ),
          ),
          (route) => false);
      return response;
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
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
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
                        "Renseignez vos ",
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
                        "coordonnées ",
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
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Color(0x10000000),
              ),
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "  Champs obligatoire  ";
                  }
                  return null;
                },
                controller: _usernameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  labelText: "  Nom & Prénom *",
                  hintText: "Ex: KARIM Ahossi Elodie",
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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  labelText: "  Email * ",
                  hintText: 'Ex: elo_kari@gmail.com',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "  Champs obligatoire  ";
                  }
                  return null;
                },
                controller: _passwordController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  labelText: "  Mot de passe *  ",
                  hintText: 'Ex: A||3p1@n0',
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
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  signUp({
                    "email": _emailController.text,
                    "username": _usernameController.text,
                    "password": _passwordController.text,
                  });
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
                "Valider",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: width / 20,
                ),
              ),
            ),
            SizedBox(
              height: width / 10,
            ),
          ],
        ),
      ),
    );
  }

/*
  void _showSucessConnexion(double width) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetAnimationDuration: const Duration(
            seconds: 5,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: EdgeInsets.all(width / 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lock,
                  color: Color(0xFFF7941F),
                ),
                Text(
                  "Sécurisez votre compte",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFF7941F),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: width / 20,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Au moins six(06) caractères', //
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: width / 30,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Color(0xAAFFFFFF),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      labelText: "Mot de passe",
                      hintText: '',
                      labelStyle: TextStyle(
                        color: Color(0xFF000000),
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
                    ),
                  ),
                ),
                SizedBox(height: width / 80),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _userService.create({
                        "email": _emailController.text,
                        "username": _nameController.text,
                        "password": _passwordController.text,
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 40),
                    padding: EdgeInsets.symmetric(
                      horizontal: width / 8,
                      vertical: width / 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  ),
                  child: Text(
                    "Continuer",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: width / 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
*/
}
