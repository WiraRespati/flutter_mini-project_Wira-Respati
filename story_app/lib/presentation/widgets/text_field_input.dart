import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final String? errorText;
  final Function(String)? onChange;

  final FocusNode focusNode;

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    required this.isPass,
    required this.hintText,
    required this.textInputType,
    this.errorText,
    required this.focusNode,
    this.onChange,
  });

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPass;
    widget.focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (widget.focusNode.hasFocus && widget.onChange != null) {
      widget.onChange!('');
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextField(
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        errorText: widget.focusNode.hasFocus ? widget.errorText : null,
        errorStyle: const TextStyle(color: Colors.red),
        suffixIcon: widget.isPass
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      keyboardType: widget.textInputType,
      onChanged: widget.onChange,
    );
  }
}
