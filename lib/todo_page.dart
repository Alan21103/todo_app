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

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _dateController.text = DateFormat(
            'dd-MM-yyyy HH:mm',
          ).format(fullDateTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 136, 44, 193),
    body: SafeArea(
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA), Color(0xFFBA68C8)],
            ),
          ),
      child: Padding(
        padding: const EdgeInsets.all(16.0))
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Form Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Date:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                TextButton(
                                  onPressed: () => _selectDate(context),
                                  style: TextButton.styleFrom(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Text(
                                    _dateController.text.isEmpty
                                        ? 'Select a date'
                                        : _dateController.text,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          _dateController.text.isEmpty
                                              ? Colors.grey
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.calendar_today,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            onPressed: () => _selectDate(context),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      Text('First Name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _taskController,
                              decoration: InputDecoration(
                                hintText: 'Enter your first name',
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(color: Colors.red),
                              ),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Please enter some text';
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ), // Jarak an
                        ],
                      ),
                    ],
            ),
              ),
          ],
        ),
      ),
    ),
    );
  }
}
