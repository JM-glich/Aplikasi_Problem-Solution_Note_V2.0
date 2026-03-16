import 'package:flutter/material.dart';
import '../models/note.dart';
import 'dart:math';
import '../services/supabase_service.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final problemController = TextEditingController();
  final solutionController = TextEditingController();
  final categoryController = TextEditingController();

  final supabaseService = SupabaseService();

  String generateId() {
    return Random().nextInt(100000).toString();
  }

  Future<void> saveNote() async {

    if (_formKey.currentState!.validate()) {

      await supabaseService.addNote(
        titleController.text,
        problemController.text,
        solutionController.text,
        categoryController.text,
      );

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
        title: const Text("Tambah Catatan"),
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
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: saveNote,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Simpan"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}