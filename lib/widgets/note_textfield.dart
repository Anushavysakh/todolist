import 'package:flutter/material.dart';

class NoteTextfield extends StatefulWidget {
  TextEditingController controller;
  String hint;

  NoteTextfield(this.controller, this.hint, {super.key});

  @override
  State<NoteTextfield> createState() => _NoteTextfeildState();
}

class _NoteTextfeildState extends State<NoteTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: (value) {
        widget.controller.text = value;
      },
      decoration: InputDecoration(hintText: widget.hint),
    );
  }
}
