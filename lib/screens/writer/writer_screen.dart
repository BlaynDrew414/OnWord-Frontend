import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'writer_left_menu.dart';
import '../../themes.dart';
import 'package:flutter_quill/flutter_quill.dart';

class BookDetailScreen extends StatefulWidget {
  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  final _chapterController = TextEditingController();
  final _contentController = QuillController.basic();
  final _titleController = TextEditingController();
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
    final textColor =
        _isDarkMode ? DarkTheme.textColorDark : LightTheme.textColorLight;

    // Create custom styles for Quill Editor
    final defaultStyles = DefaultStyles(
      // Here, we set the text color based on the theme
      color: textColor,
      // You can also add other styles like heading, link, etc., as per your requirement
      // For now, we only set the text color.
    );

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 180),
              child: TextFormField(
                enabled: true,
                style: GoogleFonts.merriweather(
                  color: textColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.5,
                ),
                decoration: InputDecoration(
                  hintText: "Book Title",
                  border: InputBorder.none,
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
            actions: [
              IconButton(
                icon: Icon(
                  _isDarkMode ? Icons.brightness_high : Icons.brightness_low,
                  color: textColor,
                ),
                onPressed: _toggleDarkMode,
              ),
            ],
          ),
        ),
        body: Row(
          children: [
            if (screenWidth >= 900 && _isDrawerOpen)
              WriterLeftMenu(
                isDarkMode: _isDarkMode,
              ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  children: [
                    QuillToolbar.basic(
                      controller: _contentController,
                    ),
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
                          child: QuillEditor(
                            controller: _contentController,
                            scrollController: ScrollController(),
                            scrollable: true,
                            focusNode: FocusNode(),
                            autoFocus: false,
                            readOnly: false,
                            expands: true,
                            padding: EdgeInsets.zero,
                            customStyles: defaultStyles,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        drawer: screenWidth < 900 ? Drawer() : null,
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleDarkMode,
          child: Icon(
            _isDarkMode ? Icons.brightness_high : Icons.brightness_low,
          ),
        ),
      ),
    );
  }
}
