import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_input.dart';
import '../atoms/glass_icon_button.dart';

/// GlassTextField - Enhanced input field with label, icons, and validation
///
/// Combines GlassInput with label and icon support
class GlassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final Widget? suffixIcon;
  final String? helperText;
  final int? maxLength;
  final bool enabled;

  const GlassTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.errorText,
    this.suffixIcon,
    this.helperText,
    this.maxLength,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: theme.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: theme.glassInputBg,
            border: Border.all(
              color: errorText != null
                  ? GlassTheme.error.withOpacity(0.5)
                  : theme.glassInputBorder,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            maxLength: maxLength,
            enabled: enabled,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: theme.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: theme.textTertiary,
              ),
              prefixIcon: Container(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  icon,
                  size: 20,
                  color: errorText != null ? GlassTheme.error : theme.textTertiary,
                ),
              ),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const SizedBox(width: 4),
              Text(
                errorText!,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: GlassTheme.error,
                ),
              ),
            ],
          ),
        ] else if (helperText != null) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const SizedBox(width: 4),
              Text(
                helperText!,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: theme.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

/// Search bar component
class GlassSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onSubmit;
  final bool autofocus;
  final bool enabled;
  final double height;
  final EdgeInsetsGeometry? padding;

  const GlassSearchBar({
    super.key,
    required this.controller,
    this.hint = 'Search...',
    this.onChanged,
    this.onClear,
    this.onSubmit,
    this.autofocus = false,
    this.enabled = true,
    this.height = 48,
    this.padding,
  });

  @override
  State<GlassSearchBar> createState() => _GlassSearchBarState();
}

class _GlassSearchBarState extends State<GlassSearchBar> {
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() => _hasFocus = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.glassInputBg,
        border: Border.all(
          color: _hasFocus
              ? theme.primaryColor.withOpacity(0.3)
              : theme.glassInputBorder,
          width: _hasFocus ? 2 : 1,
        ),
        boxShadow: _hasFocus
            ? [
                BoxShadow(
                  color: theme.primaryColor.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Icon(
              Icons.search,
              size: 20,
              color: _hasFocus ? theme.primaryColor : theme.textTertiary,
            ),
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              onSubmitted: (_) => widget.onSubmit?.call(),
              enabled: widget.enabled,
              autofocus: widget.autofocus,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: theme.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: theme.textTertiary,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (widget.controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                widget.controller.clear();
                widget.onClear?.call();
                widget.onChanged?.call('');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: theme.textTertiary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Phone input with country code
class GlassPhoneInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String countryCode;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const GlassPhoneInput({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.countryCode = '+1',
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: theme.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: theme.glassSurface.withOpacity(0.5),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(16),
                ),
                border: Border(
                  left: BorderSide(color: theme.glassBorder),
                  top: BorderSide(color: theme.glassBorder),
                  bottom: BorderSide(color: theme.glassBorder),
                ),
              ),
              child: Text(
                countryCode,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: theme.textPrimary,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(16),
                  ),
                  color: theme.glassInputBg,
                  border: Border.all(
                    color: theme.glassInputBorder,
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  onChanged: onChanged,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: theme.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: theme.textTertiary,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
