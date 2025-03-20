import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  List<Map<String, dynamic>> listTugas = [];

 void addData() {
    if (_key.currentState!.validate()) {
      setState(() {
        listTugas.add({
          'task': _taskController.text,
          'deadline': _dateController.text,
          'done': false,
        });
        _taskController.clear();
        _dateController.clear();
      });

      // Tampilkan Snackbar setelah task berhasil ditambahkan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task berhasil ditambahkan!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

