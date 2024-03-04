import 'package:exercice_api/data/modeles/todo.dart';
import 'package:flutter/material.dart';

class DetailTache extends StatefulWidget {
  const DetailTache({
    super.key,
    required this.todo,
  });
  final Todo todo;
  @override
  State<DetailTache> createState() => _DetailTacheState();
}

class _DetailTacheState extends State<DetailTache> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final todo = widget.todo;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Todo App",
            style: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: width / 15,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: width / 16,
        ),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, width / 15),
              child: Text(
                "Détail de la tâche",
                style: TextStyle(
                  color: const Color(0xFFF7941F),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: width / 15,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: width / 20,
                  ),
                  child: Text(
                    "Titre :",
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    todo.title,
                    style: TextStyle(
                      color: const Color(0xFF146CC2),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 22,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: width / 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: width / 20,
                  ),
                  child: Text(
                    "Description :",
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    todo.description,
                    style: TextStyle(
                      color: const Color(0xFF146CC2),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 22,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: width / 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: width / 20,
                  ),
                  child: Text(
                    "Priorité : ",
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    todo.priority,
                    style: TextStyle(
                      color: const Color(0xFF146CC2),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 22,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: width / 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: width / 20,
                  ),
                  child: Text(
                    "Deadline : ",
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    todo.deadlineAt.toString(),
                    style: TextStyle(
                      color: const Color(0xFF146CC2),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 22,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: width / 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: width / 20,
                  ),
                  child: Text(
                    "Date de début :",
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    todo.beginedAt.toString(),
                    style: TextStyle(
                      color: const Color(0xFF146CC2),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 22,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: width / 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: width / 20,
                  ),
                  child: Text(
                    "Date de fin : ",
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    todo.finishedAt.toString(),
                    style: TextStyle(
                      color: const Color(0xFF146CC2),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 22,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: width / 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: width / 20,
                  ),
                  child: Text(
                    "Date de création : ",
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    todo.createdAt.toString(),
                    style: TextStyle(
                      color: const Color(0xFF146CC2),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 22,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: width / 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: width / 20,
                  ),
                  child: Text(
                    "Mise-à-jour : ",
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    todo.updatedAt.toString(),
                    style: TextStyle(
                      color: const Color(0xFF146CC2),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: width / 22,
                    ),
                  ),
                ),
              ],
            ),
            /*
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                backgroundColor: const Color(0xFF146CC2),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: width / 4,
                  vertical: width / 40,
                ),
              ),
              child: Text(
                "Compris",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: width / 20,
                ),
              ),
            ),
            */
            SizedBox(
              height: width / 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_left,
          size: 40,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
