import 'package:exercice_api/data/modeles/todo.dart';
import 'package:exercice_api/data/service/todo_service.dart';
import 'package:exercice_api/ui/animations/wave_animation.dart';
import 'package:exercice_api/ui/app_drawer.dart';
import 'package:exercice_api/ui/todos/all_todo_page.dart';
import 'package:exercice_api/ui/todos/create_todo_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _todoService = TodoService();
  List<Todo> todos = [];
  List<Todo> todosStarted = [];
  List<Todo> todosNoStarted = [];
  List<Todo> todosEnded = [];

  final _startedTaskText = GlobalKey();
  final _noStartedTaskText = GlobalKey();
  final _endedTaskText = GlobalKey();
  List<GlobalKey>? _textKeys;

  void scrollToTaskType(int index) {
    Scrollable.ensureVisible(
      _textKeys![index].currentContext!,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void initState() {
    super.initState();
    _textKeys = [
      _startedTaskText,
      _noStartedTaskText,
      _endedTaskText,
    ];
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Center(
          child: Text(
            'Todo List',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const CreateTodoScreen();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.add_task,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
        iconTheme: const IconThemeData(
          size: 30.0,
          color: Colors.white,
        ),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: (todos.isEmpty)
                ? const WaveAnimation(
                    color: Color(0xFFF7941F),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          if (todosStarted.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tâches en cours",
                                  key: _startedTaskText,
                                  style: TextStyle(
                                    color: const Color(0xFF146CC2),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: width / 18,
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  margin: EdgeInsets.fromLTRB(
                                      0, 0, 3 * width / 4, 10),
                                  color: const Color(0xFF146CC2),
                                ),
                                Column(
                                  children: List.generate(
                                    todosStarted.length,
                                    (index) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            tileColor: const Color(0xDDDFDFDF),
                                            title: Text(
                                              todosStarted[index].title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.white,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (todosNoStarted.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tâches non-commencées",
                                  key: _noStartedTaskText,
                                  style: TextStyle(
                                    color: const Color(0xFF146CC2),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: width / 18,
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  margin:
                                      EdgeInsets.fromLTRB(0, 0, width / 2, 10),
                                  color: const Color(0xFF146CC2),
                                ),
                                Column(
                                  children: List.generate(
                                    todosNoStarted.length,
                                    (index) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            tileColor: const Color(0xDDDFDFDF),
                                            title: Text(
                                              todosNoStarted[index].title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.white,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (todosEnded.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tâches finies",
                                  key: _endedTaskText,
                                  style: TextStyle(
                                    color: const Color(0xFF146CC2),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: width / 18,
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  margin: EdgeInsets.fromLTRB(
                                      0, 0, 3 * width / 4, 10),
                                  color: const Color(0xFF146CC2),
                                ),
                                Column(
                                  children: List.generate(
                                    todosEnded.length,
                                    (index) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            tileColor: const Color(0xDDDFDFDF),
                                            title: Text(
                                              todosEnded[index].title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.white,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          Material(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: todos.isEmpty
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return AllTodoPage(
                                      todos: todos,
                                    );
                                  },
                                ),
                              );
                            },
                      child: _buildStatCard(
                        'Total de tâches',
                        todos.length,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: todosNoStarted.isNotEmpty
                          ? () => scrollToTaskType(1)
                          : null,
                      child: _buildStatCard(
                        'Tâches non commencées',
                        todosNoStarted.length,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: todosStarted.isNotEmpty
                          ? () => scrollToTaskType(0)
                          : null,
                      child: _buildStatCard(
                        'Tâches en cours',
                        todosStarted.length,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: todosEnded.isNotEmpty
                          ? () => scrollToTaskType(2)
                          : null,
                      child: _buildStatCard(
                        'Tâches finies',
                        todosEnded.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

/*
  ListView todoCategories() {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
          title: Text(
            todo.title,
          ),
          subtitle: const Text(
            "En cours",
          ),
        );
      },
    );
  }
*/
  Widget _buildStatCard(String title, int value) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF146CC2),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _loadTodos() async {
    todos = await _todoService.getAll();
    for (Todo todo in todos) {
      if (todo.deadlineAt.isBefore(DateTime.now())) {
        todosEnded.add(todo);
      } else if (todo.beginedAt != null && todo.finishedAt == null) {
        todosStarted.add(todo);
      } else if (todo.beginedAt == null && todo.finishedAt == null) {
        todosNoStarted.add(todo);
      }
    }

    setState(() {});
  }
}
