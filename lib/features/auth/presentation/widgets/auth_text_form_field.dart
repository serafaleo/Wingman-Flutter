import 'package:flutter/material.dart';

class AuthTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?) validator;
  final FocusNode focusNode;

  const AuthTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.isPassword,
    required this.validator,
    required this.focusNode,
  });

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  final Color? _iconsColor = Colors.grey[600];
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: !widget.isPassword ? TextInputType.emailAddress : TextInputType.visiblePassword,
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary.withAlpha(50),
        hintText: widget.hintText,
        prefixIcon: Icon(widget.isPassword ? Icons.lock : Icons.email, color: _iconsColor),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: _iconsColor,
                  ),
                )
                : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
      ),
    );
  }
}
