import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/supabase_service.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;

  const EditNoteScreen({super.key, required this.note});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController problemController;
  late TextEditingController solutionController;
  late TextEditingController categoryController;

  final supabaseService = SupabaseService();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    problemController =
        TextEditingController(text: widget.note.problemDescription);
    solutionController =
        TextEditingController(text: widget.note.solution);
    categoryController =
        TextEditingController(text: widget.note.category);
  }

  Future<void> updateNote() async {

    if (_formKey.currentState!.validate()) {

      final updatedNote = Note(
        id: widget.note.id,
        title: titleController.text,
        problemDescription: problemController.text,
        solution: solutionController.text,
        category: categoryController.text,
      );

      await supabaseService.updateNote(updatedNote);
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    problemController.dispose();
    solutionController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Catatan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Judul Masalah",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Judul tidak boleh kosong" : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: problemController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Deskripsi Masalah",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Masalah tidak boleh kosong" : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: solutionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Solusi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Solusi tidak boleh kosong" : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: updateNote,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Update"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}