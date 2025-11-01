import 'package:flutter/material.dart';

enum TextFieldType {
  fullName,
  email,
  password,
  phone,
  custom,
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextFieldType type;
  final String hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool autoFocus;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final Color cursorColor;
  final Color focusedBorderColor;
  final Color borderColor;
  final Color? fillColor;
  final double borderRadius;
  final String? fontFamily;
  final Widget? helper;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.type,
    this.hintText = '',
    this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.autoFocus = false,
    this.focusNode,
    this.helper,
    this.fillColor,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.cursorColor = Colors.blue,
    this.focusedBorderColor = Colors.blue,
    this.borderColor = const Color(0xFFE1E4E8),
    this.borderRadius = 8,
    this.fontFamily = 'Inter',
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: widget.cursorColor,
      keyboardType: _getKeyboardType(),
      obscureText: widget.obscureText && _isObscured,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      validator: widget.validator ?? _getDefaultValidator(),
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      autofocus: widget.autoFocus,
      focusNode: widget.focusNode,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        hintText: _getHintText(),
        fillColor: widget.fillColor,
        helper: widget.helper,
        labelText: widget.labelText,
        hintStyle: TextStyle(
          fontFamily: widget.fontFamily,
          color: Colors.grey.shade600,
        ),
        labelStyle: TextStyle(
          fontFamily: widget.fontFamily,
          color: Colors.grey.shade700,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: widget.focusedBorderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: widget.borderColor,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: widget.borderColor,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  String _getHintText() {
    if (widget.hintText.isNotEmpty) return widget.hintText;

    switch (widget.type) {
      case TextFieldType.fullName:
        return 'Enter your full name';
      case TextFieldType.email:
        return 'Enter your email';
      case TextFieldType.password:
        return 'Enter your password';
      case TextFieldType.phone:
        return 'Enter your phone number';
      case TextFieldType.custom:
        return 'Enter text';
    }
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.password:
        return TextInputType.visiblePassword;
      default:
        return widget.keyboardType;
    }
  }



  FormFieldValidator<String>? _getDefaultValidator() {
    switch (widget.type) {
      case TextFieldType.email:
        return (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        };
      case TextFieldType.password:
        return (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        };
      case TextFieldType.fullName:
        return (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your full name';
          }
          return null;
        };
      default:
        return null;
    }
  }
}