import 'package:exercice_api/data/db/sqlite/todo_provider.dart';
import 'package:exercice_api/data/modeles/todo.dart';
import 'package:exercice_api/ui/todos/detail_tache.dart';
import 'package:flutter/material.dart';

class AllLocalTodo extends StatefulWidget {
  const AllLocalTodo({super.key});

  @override
  State<AllLocalTodo> createState() => _AllLocalTodoState();
}

class _AllLocalTodoState extends State<AllLocalTodo> {
  final _descriptionController = TextEditingController();

  final _titleController = TextEditingController();
  final _todoProvider = TodoProvider();

  List<Todo>? _todos;

  @override
  void initState() {
    super.initState();
    _loadLocalTodos();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Center(
          child: Text(
            "Local Todos",
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _todos == null ? 0 : _todos!.length,
              itemBuilder: (context, index) {
                final todo = _todos![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return DetailTache(
                            todo: todo,
                          );
                        },
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.fromLTRB(
                          10,
                          (index == 0) ? 30 : 3,
                          10,
                          (index == 9) ? 80 : 6,
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x22000000),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(1, 1),
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                _showEditingTodo(width);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Color(0xFFF7941F),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    todo.title,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF146CC2),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    todo.description,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.visibility,
                                color: Color(0xFF146CC2),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Color(0xFF00AA00),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.check_circle_outline,
                                color: Color(0xFFAA0000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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

  void _showEditingTodo(double width) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0x88FFFFFF),
          insetAnimationDuration: const Duration(
            seconds: 2,
          ),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.all(width / 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Color(0xAAFFFFFF),
                    ),
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 2),
                    child: TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        hintText: 'Titre',
                        hintStyle: TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
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
                      color: Color(0xAAFFFFFF),
                    ),
                    margin: const EdgeInsets.fromLTRB(10, 4, 10, 2),
                    child: TextFormField(
                      maxLines: 5,
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        hintText: 'Description ... (50 caractères au maximun)',
                        hintStyle: TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                          //fontSize: 20,
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
                  SizedBox(height: width / 30),
                  ElevatedButton(
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
                    onPressed: () {},
                    child: Text(
                      "Valider",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: width / 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future _loadLocalTodos() async {
    _todos = await _todoProvider.getTodos();
    setState(() {});
  }
}
