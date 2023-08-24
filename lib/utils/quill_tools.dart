import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class QuillEditorWithToolbar extends StatelessWidget {
  final QuillController controller;

  QuillEditorWithToolbar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuillToolbar.basic(controller: controller), // Toolbar
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20), // Adjust as needed
              child: QuillEditor.basic(
                controller: controller,
                autoFocus: false,
                readOnly: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
