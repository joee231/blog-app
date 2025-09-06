import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  late final bool isobscureText;

   AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isobscureText = false,

  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      decoration: InputDecoration(
        hintText: widget.hintText,

      ),

      validator: (value)
      {
        if (value!.isEmpty) {
          return "${widget.hintText} can't be empty";
        }
        return null;
      },
      controller: widget.controller,
      obscureText: widget.isobscureText,

    );
  }
}
