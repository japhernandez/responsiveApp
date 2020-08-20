import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String label;
  final Function(String) validator;
  final bool isSecure;
  final TextInputType textInputType;
  final double fontSize;

  const InputText({
    Key key,
    @required this.label,
    this.validator,
    this.isSecure: false,
    this.textInputType: TextInputType.text,
    this.fontSize = 17,
  }) : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      obscureText: widget.isSecure,
      validator: widget.validator,
      decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(fontSize: widget.fontSize),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10)),
    );
  }
}
