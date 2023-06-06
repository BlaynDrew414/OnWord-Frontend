import 'package:flutter/material.dart';
import 'package:frontend/themes.dart';
import 'package:google_fonts/google_fonts.dart';


class BookWritingScreen extends StatefulWidget {
  final BookInfo book; 
  BookWritingScreen({required.this.book});

  @override _BookWritingScreenState createState() => BookWritingScreenState();
}

class _BookWritingScreenState extends State<BookWritingScreen> {
    final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _chapterController = TextEditingController();
  final Color _textColor = DarkTheme.textColorDark;
  bool _isDrawerOpen = true;

 