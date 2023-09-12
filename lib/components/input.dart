import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final valueText;
  final String hintText;
  final bool secureText;

  const InputText({
    super.key,
    required this.valueText,
    required this.hintText,
    required this.secureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: valueText,
        obscureText: secureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            prefixIcon: Icon(Icons.person),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText),
      ),
    );
  }
}
