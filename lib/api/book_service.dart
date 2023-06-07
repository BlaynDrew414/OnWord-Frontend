import 'dart:convert';
import 'package:http/http.dart' as http;

class BookService {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<Book>> getAllBooks(String authToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/getAllBooks'),
      headers: {'Authorization': 'Bearer $authToken'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final books = data.map((item) => Book.fromJson(item)).toList();
      return books;
    } else {
      throw Exception('Failed to fetch books');
    }
  }

  Future<Book> getSingleBook(String bookId, String authToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/getBook/$bookId'),
      headers: {'Authorization': 'Bearer $authToken'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final book = Book.fromJson(data);
      return book;
    } else {
      throw Exception('Failed to fetch book');
    }
  }

  Future<Book> createBook(Book book, String authToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/createBook'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(book.toJson()),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final createdBook = Book.fromJson(data['data']);
      return createdBook;
    } else {
      throw Exception('Failed to create book');
    }
  }

  Future<Book> updateBook(String bookId, Book book, String authToken) async {
    final response = await http.put(
      Uri.parse('$baseUrl/updateBook/$bookId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(book.toJson()),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final updatedBook = Book.fromJson(data['data']);
      return updatedBook;
    } else {
      throw Exception('Failed to update book');
    }
  }

  Future<void> deleteBook(String bookId, String authToken) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/deleteBook/$bookId'),
      headers: {'Authorization': 'Bearer $authToken'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete book');
    }
  }
}

class Book {
  final String id;
  final String title;
  final String author;
  // Add other properties as needed

  Book({
    required this.id,
    required this.title,
    required this.author,
    // Initialize other properties
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      // Parse and assign other properties
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'author': author,
      // Add other properties
    };
  }
}


