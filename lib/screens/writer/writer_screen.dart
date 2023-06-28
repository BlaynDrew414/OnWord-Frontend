import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes.dart';

class BookDetailScreen extends StatefulWidget {
  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  //final _titleController = TextEditingController();
  //final _authorController = TextEditingController();
  final _chapterController = TextEditingController();
  bool _isDrawerOpen = true;
  bool _isDarkMode = false;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final themeData = _isDarkMode ? DarkTheme.themeData : LightTheme.themeData;
    final textColor = _isDarkMode ? DarkTheme.textColorDark : LightTheme.textColorLight;

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 180),
              child: Text(
                'Book Title',
                style: GoogleFonts.merriweather(
                  color: textColor,
                  fontSize: 36,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            backgroundColor: themeData.primaryColor,
            bottom: PreferredSize(
              child: Container(
                color: textColor,
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
            if (screenWidth >= 900 && _isDrawerOpen) Expanded(child: Container()), // Replace with WriterLeftMenu
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        enabled: true,
                        textAlign: TextAlign.center,
                        controller: _chapterController,
                        style: GoogleFonts.merriweather(
                          color: textColor,
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
                        color: textColor,
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
                              enabled: true,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: GoogleFonts.merriweather(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: textColor,
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
        drawer: screenWidth < 900 ? Drawer() : null, // Replace with WriterLeftMenu
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleDarkMode,
          child: Icon(_isDarkMode ? Icons.brightness_high : Icons.brightness_low),
        ),
      ),
    );
  }
}
