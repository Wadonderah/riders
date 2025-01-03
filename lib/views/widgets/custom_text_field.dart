import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  TextEditingController? textEditingController;
  IconData? icon;
  String? hintString;
  bool isObscure;
  bool isEnabled;

  CustomTextField({
    super.key,
    this.textEditingController,
    this.icon,
    this.hintString,
    this.isObscure = true,
    this.isEnabled = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        enabled: widget.isEnabled,
        controller: widget.textEditingController,
        obscureText: widget.isObscure,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            widget.icon,
            color: Colors.blueAccent,
          ),
          hintText: widget.hintString,
          hintStyle: const TextStyle(color: Colors.black54),
          suffixIcon: widget.isObscure
              ? IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      widget.isObscure = !widget.isObscure;
                    });
                  },
                )
              : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
