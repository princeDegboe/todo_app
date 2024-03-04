import 'package:exercice_api/ui/home_page.dart';
import 'package:exercice_api/ui/user_connexion/regis_connexion.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token") ?? "";

  runApp(
    MyApp(
      token: token,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.token,
  });

  final String token;
  final MaterialColor customSwatchColor = const MaterialColor(
    0xFFF7941F,
    <int, Color>{
      50: Color(0xFFFFF4E6),
      100: Color(0xFFFFE8CC),
      200: Color(0xFFFFDBB2),
      300: Color(0xFFFFCE99),
      400: Color(0xFFFFC17F),
      500: Color(0xFFF7941F),
      600: Color(0xFFD97E1B),
      700: Color(0xFFB76817),
      800: Color(0xFF985212),
      900: Color(0xFF7A3C0E),
    },
  );

  @override
  Widget build(BuildContext context) {
    bool isValidToken = false;
    if (token.isNotEmpty) {
      isValidToken = !(jwtDecode(token).isExpired ?? false);
    }
    return MaterialApp(
      title: 'Exercice',
      theme: ThemeData(
        primarySwatch: customSwatchColor,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: isValidToken
          ? const HomePage()
          : const RegisConnexion(
              isNotConnectedYet: true,
            ),
    );
  }
}
