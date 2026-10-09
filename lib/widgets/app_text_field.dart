import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

/// Input gaya kotak (dipakai di halaman Masuk dan Buat Akun).
class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final String? label;
  final String? hint;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    this.label,
    this.hint,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscure,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.fieldFill,
            hintText: widget.hint,
            hintStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              color: AppColors.icon,
            ),
            prefixIcon: Icon(widget.prefixIcon, color: AppColors.icon),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.icon,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: _border(AppColors.fieldBorder),
            enabledBorder: _border(AppColors.fieldBorder),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(Colors.red),
            focusedErrorBorder: _border(Colors.red),
          ),
        ),
      ],
    );
  }
}
