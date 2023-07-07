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

  void _onReorder(int oldIndex, int newIndex, List list) {
    if (newIndex > oldIndex) newIndex -= 1;
    setState(() {
      final item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = widget.isDarkMode ? DarkTheme.themeData : LightTheme.themeData;
    final textColor = widget.isDarkMode ? DarkTheme.textColorDark : LightTheme.textColorLight;

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
            Container(
              width: 150,
              child: Row(
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
                  SizedBox(
                    width: 10.0,
                  ),
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
                  SizedBox(width: 9.0)
                ],
              ),
            ),
            if (_isChapterExpanded)
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    key: Key('$index'),
                    title: Text('Chapter $index', style: TextStyle(color: textColor)),
                    trailing: Icon(Icons.drag_handle),
                  );
                },
                itemCount: 5, // Set the number of chapters or use a dynamic value
                onReorder: (oldIndex, newIndex) {
                  _onReorder(oldIndex, newIndex, List.generate(5, (index) => 'Chapter $index'));
                },
              ),
            SizedBox(height: 16),
            Container(
              width: 150,
              child: Row(
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
                  SizedBox(
                    width: 10.0,
                  ),
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
                  SizedBox(width: 9.0)
                ],
              ),
            ),
            if (_isNoteExpanded)
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    key: Key('$index'),
                    title: Text('Note $index', style: TextStyle(color: textColor)),
                    trailing: Icon(Icons.drag_handle),
                  );
                },
                itemCount: 5, // Set the number of notes or use a dynamic value
                onReorder: (oldIndex, newIndex) {
                  _onReorder(oldIndex, newIndex, List.generate(5, (index) => 'Note $index'));
                },
              ),
          ],
        ),
      ),
    );
  }
}
