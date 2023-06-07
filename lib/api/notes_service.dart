import 'dart:convert';
import 'package:http/http.dart' as http;

class NoteService {
  static const String baseUrl = 'http://localhost:3000';

  Future<Note> createNote(Note note) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(note.toJson()),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final createdNote = Note.fromJson(data['data']);
      return createdNote;
    } else {
      throw Exception('Failed to create note');
    }
  }

  Future<Note> getNoteById(String noteId) async {
    final response = await http.get(Uri.parse('$baseUrl/notes/$noteId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final note = Note.fromJson(data);
      return note;
    } else {
      throw Exception('Failed to fetch note');
    }
  }

  Future<List<Note>> getAllNotes() async {
    final response = await http.get(Uri.parse('$baseUrl/notes'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final notes = data.map((item) => Note.fromJson(item)).toList();
      return notes;
    } else {
      throw Exception('Failed to fetch notes');
    }
  }

  Future<Note> updateNoteById(String noteId, Note note) async {
    final response = await http.put(
      Uri.parse('$baseUrl/notes/$noteId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(note.toJson()),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final updatedNote = Note.fromJson(data['data']);
      return updatedNote;
    } else {
      throw Exception('Failed to update note');
    }
  }

  Future<void> deleteNoteById(String noteId) async {
    final response = await http.delete(Uri.parse('$baseUrl/notes/$noteId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete note');
    }
  }
}

class Note {
  final String id;
  final String title;
  final String text;

  Note({
    required this.id,
    required this.title,
    required this.text,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'] as String,
      title: json['title'] as String,
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'text': text,
    };
  }
}
