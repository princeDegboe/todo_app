import 'package:dio/dio.dart';
import 'package:exercice_api/data/db/sqlite/todo_provider.dart';
import 'package:exercice_api/data/modeles/todo.dart';
import 'package:exercice_api/data/service/todo_service.dart';
import 'package:exercice_api/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Priority { medium, low, high }

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key});

  @override
  State<CreateTodoScreen> createState() {
    return _CreateTodoScreenState();
  }
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _todoService = TodoService();

  final _todoProvider = TodoProvider();

  DateTime? _selectedDate;

  Priority selectedPriority = Priority.medium;

  bool isLoading = false;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final lastDate = DateTime(
      now.year + 2,
      now.month,
      now.day,
      now.second,
    );
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  Future _submitTodoData() async {
    if (_titleController.text.trim().isEmpty || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Entrée invalide'),
          content: const Text(
            'Assurez vous que les informations correct sont entrées',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
      return;
    }
    try {
      await _todoProvider.insertTodo(
        Todo.fromMap(
          {
            "id": '',
            "description": _descriptionController.text,
            "title": _titleController.text,
            "begined_at": "",
            "finished_at": "",
            "deadline_at": _selectedDate.toString(),
            "priority": selectedPriority.name,
            "user_id": "",
            "created_at": DateTime.now().toString(),
            "updated_at": DateTime.now().toString(),
          },
        ),
      );
    } catch (e) {
      throw Exception("Local task add error: $e");
    }

    await create(
      {
        "title": _titleController.text,
        "description": _descriptionController.text,
        "priority": selectedPriority.name,
        "deadline_at": _selectedDate.toString(),
      },
    );
  }

  create(data) async {
    isLoading = true;
    try {
      var response = await _todoService.create(data);

      Fluttertoast.showToast(
        msg: "Tâches connectées avec succès",
        backgroundColor: const Color(0xFF146CC2),
        timeInSecForIosWeb: 4,
      );
      _titleController.text = "";
      _descriptionController.text = "";
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
      return response;
    } on DioException catch (e) {
      Fluttertoast.showToast(
        msg: "Erreur",
        backgroundColor: const Color(0xFF146CC2),
        timeInSecForIosWeb: 4,
      );
      if (e.response != null) {
        throw Exception("Error: $e");
      } else {
        throw Exception("Error: ${e.message}");
      }
    } finally {
      isLoading = false;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No date selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    DropdownButton(
                      value: selectedPriority,
                      items: Priority.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          selectedPriority = value;
                        });
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _submitTodoData,
                      child: const Text(
                        'Save Todo',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
