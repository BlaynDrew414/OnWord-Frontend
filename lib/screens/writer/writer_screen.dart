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

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

    @override
  void initState() {
    super.initState();
    _titleController.text = widget.book.title;
    _authorController.text = widget.book.author;
    _chapterController.text = widget.book.chapter.first.title; 
  }
  
 @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 180),
            child: Text(
              widget.book.title, 
              style: GoogleFonts.merriweather(
                color: _textColor, 
                fontSize: 36,
                fontWeight: FontWeight.w400,
                 letterSpacing: 1.5, 
              ),
            ),
          ),
          backgroundColor: DarkTheme.backgroundColorDark,
          bottom: PreferredSize(
            child: Container(
              color: DarkTheme.textColorDark,
              height: 0.3,
            ),
            preferredSize: Size.fromHeight(1),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: _toggleDrawer,
          ),
        ),
      ),
      body: Row(
        children: [
          if (screenWidth >= 900 && _isDrawerOpen)
            Expanded(
              child: WriterLeftMenu(book: widget.book),
            ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      textAlign: TextAlign.center,
                      controller: _chapterController,
                      style: GoogleFonts.merriweather(
                        color: _textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Chapter Title...',
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                    ),
                    Divider(
                      color: _textColor,
                      thickness: 1,
                      height: 40,
                      endIndent: 420,
                      indent: 420,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 80,
                            right: _isDrawerOpen ? 250 : 0,
                            left: _isDrawerOpen ? 50 : 0,
                          ),
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: GoogleFonts.merriweather(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: _textColor,
                            ),
                            decoration: InputDecoration(
                              hintText: "Start writing...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: screenWidth < 900
          ? Drawer(
              elevation: 0.0,
              child: WriterLeftMenu(book: widget.book),
            )
          : null,
    );
  }
}

