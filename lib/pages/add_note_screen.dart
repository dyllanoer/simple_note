import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_note/models/note.dart';
import 'package:simple_note/services/database_services.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final DatabaseService dbService = DatabaseService();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Note",
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
              TextFormField(
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                decoration: InputDecoration(
                  hintText: "Masukan Judul",
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                ),
                controller: _titleController,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Judul wajib diisi";
                  }
                  return null;
                },
              ),
              TextFormField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Masukan Deskripsi",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                ),
                controller: _descriptionController,
                validator: (value) {
                  if (value == null || value == "") {
                    return "deskripsi wajib diisi";
                  }
                  return null;
                },
              ),
            ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (_formkey.currentState!.validate()) {
              Note tempNote = Note(
              _titleController.text, 
              _descriptionController.text, 
              DateTime.now(),
              );
              await dbService.addNote(tempNote);
              GoRouter.of(context).pop();
            }
          }, 
        label: const Text("Simpan"),
        icon: const Icon(Icons.add),
        ),
    );
  }
}