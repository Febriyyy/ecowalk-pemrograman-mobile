import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';

/// Kotak input kode OTP. Otomatis pindah ke kotak berikutnya saat diisi
/// dan kembali ke kotak sebelumnya saat dihapus.
class OtpInput extends StatefulWidget {
  final int length;
  final ValueChanged<String> onChanged;

  const OtpInput({super.key, this.length = 4, required this.onChanged});

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _nodes;

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.length, (_) => TextEditingController());
    _nodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _notify() => widget.onChanged(_controllers.map((c) => c.text).join());

  void _onChanged(int i, String value) {
    if (value.isNotEmpty && i < widget.length - 1) {
      _nodes[i + 1].requestFocus();
    } else if (value.isEmpty && i > 0) {
      _nodes[i - 1].requestFocus();
    }
    _notify();
  }

  KeyEventResult _onKey(int i, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[i].text.isEmpty &&
        i > 0) {
      _controllers[i - 1].clear();
      _nodes[i - 1].requestFocus();
      _notify();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.length, (i) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: i == 0 ? 0 : 16),
            child: SizedBox(
              height: 75,
              child: Focus(
                onKeyEvent: (node, event) => _onKey(i, event),
                child: TextField(
                  controller: _controllers[i],
                  focusNode: _nodes[i],
                  autofocus: i == 0,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (v) => _onChanged(i, v),
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: AppColors.fieldFill,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: AppColors.fieldBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColors.primary, width: 2),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
