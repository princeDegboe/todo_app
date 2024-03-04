import 'package:exercice_api/ui/about_us/about_us_page.dart';
import 'package:exercice_api/ui/todos/all_local_todo.dart';
import 'package:exercice_api/ui/user_connexion/regis_connexion.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    super.key,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<String>? _emails, _usernames;
  @override
  void initState() {
    super.initState();
    loadEmails();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0x88000000),
      child: Column(
        children: [
          const SizedBox(
            height: 80,
            //color: const Color(0xFFF7941F),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _emails == null ? 0 : _emails!.length,
                itemBuilder: (context, index) {
                  final username = _usernames![index];
                  final email = _emails![index];
                  return Column(
                    children: [
                      ListTile(
                        tileColor: const Color(0xAAFFFFFF),
                        leading: CircleAvatar(
                          child: ClipOval(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                "asset/images/xr-avatar.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          username,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          email,
                        ),
                        trailing: const Icon(
                          Icons.online_prediction,
                          color: Color(0xFF00AA00),
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        height: 1,
                      ),
                    ],
                  );
                }),
          ),
          Container(
            height: 2,
          ),
          ListTile(
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setString("token", "");
              setState(() {
                gotoHome();
              });
            },
            tileColor: const Color(0xDDFFFFFF),
            leading: const Icon(
              Icons.logout,
              color: Color(0xFFAA0000),
            ),
            title: const Text(
              "Se déconnecter",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            height: 1,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const RegisConnexion();
                  },
                ),
              );
            },
            tileColor: const Color(0xDDFFFFFF),
            leading: const Icon(
              Icons.login,
              color: Color(0xFF146CC2),
            ),
            title: const Text(
              "Se connecter à un autre compte",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF146CC2),
              ),
            ),
          ),
          Container(
            height: 10,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return const AllLocalTodo();
                  },
                ),
              );
            },
            tileColor: const Color(0xFFFFFFFF),
            leading: const Icon(
              Icons.visibility,
              color: Color(0xFF146CC2),
            ),
            title: const Text(
              "Voir les tâches en local",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF146CC2),
              ),
            ),
          ),
          Container(
            height: 1,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const AboutUsPage();
                  },
                ),
              );
            },
            tileColor: const Color(0xFFFFFFFF),
            leading: const Icon(
              Icons.info_outline,
            ),
            title: const Text(
              "À propos",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(
            height: 2,
          ),
        ],
      ),
    );
  }

  void gotoHome() {
    Navigator.of(context).pushAndRemoveUntil<void>(
        MaterialPageRoute(
          builder: (_) => const RegisConnexion(
            isNotConnectedYet: true,
          ),
        ),
        (route) => false);
  }

  Future loadEmails() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _emails = pref.getStringList("emails") ?? [];
      _usernames = pref.getStringList("usernames") ?? [];
    });
  }
}
