import 'package:flutter/material.dart';
import 'package:todolist/widgets/textfield_decoration.dart';

class NoteTextfield extends StatelessWidget {
  TextEditingController? controller;
  String hint;

  NoteTextfield(this.controller, this.hint, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {
        controller?.text = value;
      },
      validator: (value) => buildValidator(value!),
      decoration: InputDecoration(hintText: hint),
    );
  }
}
