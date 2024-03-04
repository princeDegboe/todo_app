import 'package:exercice_api/ui/user_connexion/registration_page.dart';
import 'package:exercice_api/ui/user_connexion/sign_page.dart';
import 'package:flutter/material.dart';

class RegisConnexion extends StatefulWidget {
  const RegisConnexion({
    super.key,
    this.isNotConnectedYet,
  });
  final bool? isNotConnectedYet;
  @override
  State<RegisConnexion> createState() => _RegisConnexionState();
}

class _RegisConnexionState extends State<RegisConnexion> {
  bool onTapConnexion = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Material(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                width / 20,
                width / 5,
                width / 20,
                width / 20,
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Color(0xFFD0D0D0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            onTapConnexion = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: !onTapConnexion
                                ? const Color(0xFFFFFFFF)
                                : const Color(0xFFD0D0D0),
                            boxShadow: !onTapConnexion
                                ? const [
                                    BoxShadow(
                                      color: Color(0x22000000),
                                      offset: Offset(0, 1),
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Text(
                            "Inscrivez-vous",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: !onTapConnexion
                                  ? const Color(0xFF146CC2)
                                  : const Color(0xFF212121),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            onTapConnexion = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: onTapConnexion
                                ? const Color(0xFFFFFFFF)
                                : const Color(0xFFD0D0D0),
                            boxShadow: onTapConnexion
                                ? const [
                                    BoxShadow(
                                      color: Color(0x22000000),
                                      offset: Offset(0, 1),
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Text(
                            "Connectez-vous",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: onTapConnexion
                                  ? const Color(0xFF146CC2)
                                  : const Color(0xFF212121),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                onTapConnexion
                    ? const UserConnexion()
                    : const UserRegistration(),
                SizedBox(
                  height: width / 5,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: widget.isNotConnectedYet ?? false
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_left,
                size: 40,
                color: Colors.white,
              ),
            ),
      floatingActionButtonLocation: widget.isNotConnectedYet ?? false
          ? null
          : FloatingActionButtonLocation.startFloat,
    );
  }
}
