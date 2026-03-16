import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/note.dart';

class SupabaseService {

  final supabase = Supabase.instance.client;

  // READ
  Future<List<Note>> getNotes() async {
    final data = await supabase.from('notes').select();

    return (data as List)
        .map((note) => Note.fromJson(note))
        .toList();
  }

  // CREATE
  Future<void> addNote(
    String title,
    String problem,
    String solution,
    String category,
  ) async {

    await supabase.from('notes').insert({
      'title': title,
      'problem': problem,
      'solution': solution,
      'category': category,
    });

  }

  // UPDATE
  Future<void> updateNote(Note note) async {
    await supabase
        .from('notes')
        .update(note.toJson())
        .eq('id', note.id);
  }

  // DELETE
  Future<void> deleteNote(String id) async {
    await supabase
        .from('notes')
        .delete()
        .eq('id', id);
  }

}