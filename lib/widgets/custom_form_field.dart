import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
final String hintText;
final double height;
final RegExp validationRegEx;

  const CustomFormField({super.key, 
  required this.hintText,
  required this.height,
  required this.validationRegEx,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        validator: (value) {
          if(value != null && validationRegEx.hasMatch(value)) {
            return null;
          }
          return "Enter a valid ${hintText.toLowerCase()}";
        },
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
          ),
      ),
    );
  }
}