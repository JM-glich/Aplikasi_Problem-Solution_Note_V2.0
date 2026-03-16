import 'package:flutter/material.dart';
import '../models/note.dart';
import 'add_note_screen.dart';
import 'detail_note_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';


class HomeScreen extends StatefulWidget {

  final VoidCallback toggleTheme;

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final SupabaseService supabaseService = SupabaseService();

  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {

  final data = await supabaseService.getNotes();
  setState(() {
    notes = data;
  });

}

  void addNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  Future<void> deleteNote(String id) async {

    await supabaseService.deleteNote(id);

    loadNotes();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Note deleted"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Problem & Solution Note"),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: notes.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.note_alt_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Belum ada catatan",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Tekan tombol + untuk menambahkan",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailNoteScreen(note: note),
                        ),
                      );
                      if (result == true) {
                        loadNotes();
                      }
                    },
                    title: Text(
                        note.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(note.problemDescription),
                        const SizedBox(height: 4),
                        Text(
                          "Category: ${note.category}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Hapus Note"),
                            content: const Text("Yakin ingin menghapus note ini?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Batal"),
                              ),
                              TextButton(
                                onPressed: () {
                                  deleteNote(note.id);
                                  Navigator.pop(context);
                                },
                                child: const Text("Hapus"),
                              ),
                            ],
                          ),
                        );
                      } 
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {

          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNoteScreen(),
            ),
          );

          if (result == true) {
            loadNotes();
          }

        },
        icon: const Icon(Icons.add),
        label: const Text("Add Note"),
      )
    );
  }
}