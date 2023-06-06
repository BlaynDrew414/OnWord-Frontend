import 'dart:convert';
import 'package:http/http.dart' as http;

class ChapterService {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<Chapter>> getAllChapters(String bookId) async {
    final response = await http.get(Uri.parse('$baseUrl/getChapters/$bookId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final chapters = data.map((item) => Chapter.fromJson(item)).toList();
      return chapters;
    } else {
      throw Exception('Failed to fetch chapters');
    }
  }

  Future<Chapter> getSingleChapter(String chapterId) async {
    final response = await http.get(Uri.parse('$baseUrl/getChapter/$chapterId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final chapter = Chapter.fromJson(data);
      return chapter;
    } else {
      throw Exception('Failed to fetch chapter');
    }
  }

  Future<Chapter> createChapter(String bookId, Chapter chapter) async {
    final response = await http.post(
      Uri.parse('$baseUrl/createChapter/$bookId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(chapter.toJson()),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final createdChapter = Chapter.fromJson(data['data']);
      return createdChapter;
    } else {
      throw Exception('Failed to create chapter');
    }
  }

  Future<Chapter> updateChapter(String chapterId, Chapter chapter) async {
    final response = await http.put(
      Uri.parse('$baseUrl/updateChapter/$chapterId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(chapter.toJson()),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final updatedChapter = Chapter.fromJson(data['data']);
      return updatedChapter;
    } else {
      throw Exception('Failed to update chapter');
    }
  }

  Future<void> deleteChapter(String chapterId) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/deleteChapter/$chapterId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete chapter');
    }
  }
}

class Chapter {
  final String id;
  final String title;
  final String text;
  // Add other properties as needed

  Chapter({
    required this.id,
    required this.title,
    required this.text,
    // Initialize other properties
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['_id'] as String,
      title: json['title'] as String,
      text: json['text'] as String,
      // Parse and assign other properties
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'text': text,
      // Add other properties
    };
  }
}
