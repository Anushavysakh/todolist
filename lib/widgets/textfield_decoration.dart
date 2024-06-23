import 'package:flutter/material.dart';

buildInputDecoration(String hint){
  return InputDecoration(hintText: hint,border: InputBorder.none);
}
buildValidator(String value){
  if (value!.isEmpty) {
    return "Can't be empty !";
  } else {
    return null;
  }
}