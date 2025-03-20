import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

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

  String? _dateError;

  void addData() {
    setState(() {
      _dateError = _dateController.text.isEmpty ? 'Harap pilih tanggal' : null;
    });

    if (_key.currentState!.validate() && _dateError == null) {
      setState(() {
        listTugas.add({
          'task': _taskController.text,
          'deadline': _dateController.text,
          'done': false,
        });
        _taskController.clear();
        _dateController.clear();
        _dateError = null; // Reset error setelah sukses
      });

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
      backgroundColor: Color.fromARGB(255, 141, 38, 205),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Form Page',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          _dateController.text.isEmpty
                                              ? Colors.grey
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                                if (_dateError != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      _dateError!,
                                      style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape:
                                  BoxShape
                                      .circle, // Membuat tombol berbentuk lingkaran
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purple,
                                  Colors.deepPurpleAccent,
                                ], // Gradasi warna
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: Offset(2, 4), // Efek bayangan
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () => _selectDate(context),
                              splashRadius: 30, // Efek klik lebih smooth
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'First Name',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _taskController,
                              decoration: InputDecoration(
                                hintText: 'Enter your first name',
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey.shade600,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                errorStyle: GoogleFonts.poppins(
                                  color: Colors.red,
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(168, 255, 255, 255),
                              ),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Please enter some text';
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                92,
                                7,
                                111,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                            ),
                            onPressed: addData,
                            child: Text(
                              'Submit',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'List Tasks',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: listTugas.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Color(0xFFD190E1),
                        elevation: 2,
                        margin: EdgeInsets.symmetric(vertical: 7),
                        child: ListTile(
                          title: Text(
                            listTugas[index]['task'],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deadline: ${listTugas[index]['deadline']}',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF004567),
                                ),
                              ),
                              Text(
                                listTugas[index]['done'] ? 'Done' : 'Not Done',
                                style: GoogleFonts.poppins(
                                  color:
                                      listTugas[index]['done']
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          trailing: Checkbox(
                            value: listTugas[index]['done'],
                            onChanged: (bool? value) {
                              setState(() {
                                listTugas[index]['done'] = value!;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
