import 'package:flutter/material.dart';
import '../../themes.dart';
import 'package:flutter/rendering.dart';

class WriterLeftMenu extends StatefulWidget {
  final bool isDarkMode;

  const WriterLeftMenu({required this.isDarkMode});

  @override
  _WriterLeftMenuState createState() => _WriterLeftMenuState();
}

class _WriterLeftMenuState extends State<WriterLeftMenu> {
  bool _isChapterExpanded = true;
  bool _isNoteExpanded = true;

  List<String> chapters = [
    'Chapter 1',
    'Chapter 2',
    'Chapter 3',
    'Chapter 4',
    'Chapter 5',
  ];

  List<String> notes = [
    'Note 1',
    'Note 2',
    'Note 3',
    'Note 4',
    'Note 5',
  ];

  Color getTextColor(bool isDarkMode) {
    return isDarkMode ? DarkTheme.textColorDark : LightTheme.textColorLight;
  }

  @override
  Widget build(BuildContext context) {
    final themeData =
        widget.isDarkMode ? DarkTheme.themeData : LightTheme.themeData;
    final textColor = getTextColor(widget.isDarkMode);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: themeData.colorScheme.secondary,
          width: 0.3,
        ),
      ),
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Row(
                children: [
                  GestureDetector(
                    child: _isChapterExpanded
                        ? Icon(Icons.keyboard_arrow_down)
                        : Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      setState(() {
                        _isChapterExpanded = !_isChapterExpanded;
                      });
                    },
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Chapters',
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    child: Icon(
                      Icons.add,
                      size: 18,
                    ),
                    onTap: () {
                      // Add your logic for adding a chapter
                    },
                  ),
                  SizedBox(width: 9.0),
                ],
              ),
            ),
            if (_isChapterExpanded)
              ReorderableListView(
                buildDefaultDragHandles: false,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  for (var i = 0; i < chapters.length; i++)
                    ReorderableDragStartListener(
                      index: i,
                      key: Key('chapter_$i'),
                      child: ListTile(
                        title: Text(chapters[i], style: TextStyle(color: textColor)),
                      ),
                    ),
                ],
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) newIndex -= 1;
                  setState(() {
                    final item = chapters.removeAt(oldIndex);
                    chapters.insert(newIndex, item);
                  });
                },
              ),
            SizedBox(height: 16),
            Container(
              width: 150,
              child: ListTile(
                title: Row(
                  children: [
                    GestureDetector(
                      child: _isNoteExpanded
                          ? Icon(Icons.keyboard_arrow_down)
                          : Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        setState(() {
                          _isNoteExpanded = !_isNoteExpanded;
                        });
                      },
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Notes',
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Icon(
                        Icons.add,
                        size: 18,
                      ),
                      onTap: () {
                        // Add your logic for adding a note
                      },
                    ),
                    SizedBox(width: 9.0),
                  ],
                ),
              ),
            ),
            if (_isNoteExpanded)
              ReorderableListView(
                buildDefaultDragHandles: false,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  for (var i = 0; i < notes.length; i++)
                    ReorderableDragStartListener(
                      index: i,
                      key: Key('note_$i'),
                      child: ListTile(
                        title: Text(notes[i], style: TextStyle(color: textColor)),
                      ),
                    ),
                ],
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) newIndex -= 1;
                  setState(() {
                    final item = notes.removeAt(oldIndex);
                    notes.insert(newIndex, item);
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
