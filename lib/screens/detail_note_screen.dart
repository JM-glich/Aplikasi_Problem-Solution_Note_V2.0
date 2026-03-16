import 'package:flutter/material.dart';
import '../models/note.dart';
import 'edit_note_screen.dart';

class DetailNoteScreen extends StatelessWidget {
  final Note note;

  const DetailNoteScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Catatan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Text(
                  note.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Kategori: ${note.category}",
                  style: const TextStyle(color: Colors.grey),
                ),
                const Divider(height: 30),
                const Text(
                  "Masalah:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(note.problemDescription),
                const SizedBox(height: 20),
                const Text(
                  "Solusi:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(note.solution),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () async {
          final updatedNote = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditNoteScreen(note: note),
            ),
          );
          if (updatedNote != null) {
            // ignore: use_build_context_synchronously
            Navigator.pop(context, updatedNote);
          }
        },
      ),
    );
  }
}