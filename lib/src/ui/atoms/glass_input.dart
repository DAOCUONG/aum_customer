import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';

/// GlassInput - A text field with glassmorphism effect
///
/// Provides a beautiful input field with:
/// - Glass background effect
/// - Subtle border
/// - Focus state with primary color ring
/// - Icon support
/// - Error state
/// - Helper text
class GlassInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? textStyle;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final Color? fillColor;
  final Color? cursorColor;
  final int? maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? Function(String?)? onSaved;

  const GlassInput({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.textStyle,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.disabledBorder,
    this.fillColor,
    this.cursorColor,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.contentPadding,
    this.autofocus = false,
    this.focusNode,
    this.onSaved,
  });

  const GlassInput.text({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.textInputAction,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.textStyle,
    this.fillColor,
    this.cursorColor,
    this.maxLength,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.contentPadding,
    this.autofocus = false,
    this.focusNode,
    this.onSaved,
  })  : obscureText = false,
        readOnly = false,
        keyboardType = TextInputType.text,
        maxLines = 1,
        enabledBorder = null,
        errorBorder = null,
        disabledBorder = null,
        focusedBorder = null;

  const GlassInput.password({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = true,
    this.enabled = true,
    this.textInputAction = TextInputAction.done,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.textStyle,
    this.fillColor,
    this.cursorColor,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.contentPadding,
    this.autofocus = false,
    this.focusNode,
    this.onSaved,
  })  : readOnly = false,
        keyboardType = TextInputType.visiblePassword,
        enabledBorder = null,
        errorBorder = null,
        disabledBorder = null,
        focusedBorder = null;

  const GlassInput.multiline({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction = TextInputAction.newline,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.textStyle,
    this.fillColor,
    this.cursorColor,
    this.maxLines = 4,
    this.maxLength,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.contentPadding,
    this.autofocus = false,
    this.focusNode,
    this.onSaved,
  })  : obscureText = false,
        readOnly = false,
        enabledBorder = null,
        errorBorder = null,
        disabledBorder = null,
        focusedBorder = null;

  @override
  State<GlassInput> createState() => _GlassInputState();
}

class _GlassInputState extends State<GlassInput> {
  late FocusNode _focusNode;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _focused = _focusNode.hasFocus);
  }

  InputBorder _getDefaultBorder(BuildContext context, bool error) {
    final theme = GlassTheme.of(context);
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: error
            ? GlassTheme.error.withOpacity(0.5)
            : theme.glassInputBorder,
        width: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: widget.labelStyle ??
                TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.textSecondary,
                  letterSpacing: 0.3,
                ),
          ),
          const SizedBox(height: 8),
        ],
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                (widget.fillColor ?? theme.glassInputBg),
                (widget.fillColor ?? theme.glassInputBg).withOpacity(0.8),
              ],
            ),
            border: Border.all(
              color: _focused
                  ? hasError
                      ? GlassTheme.error.withOpacity(0.5)
                      : theme.primaryColor.withOpacity(0.3)
                  : theme.glassInputBorder,
              width: _focused ? 2 : 1,
            ),
            boxShadow: _focused
                ? [
                    BoxShadow(
                      color: hasError
                          ? GlassTheme.error.withOpacity(0.2)
                          : theme.primaryColor.withOpacity(0.15),
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
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            obscureText: widget.obscureText,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            autofocus: widget.autofocus,
            cursorColor: widget.cursorColor ?? theme.primaryColor,
            style: widget.textStyle ??
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.textPrimary,
                ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: theme.textTertiary,
                  ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              border: InputBorder.none,
              enabledBorder: widget.enabledBorder ?? _getDefaultBorder(context, hasError),
              focusedBorder: widget.focusedBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: hasError
                          ? GlassTheme.error.withOpacity(0.5)
                          : theme.primaryColor.withOpacity(0.4),
                      width: 2,
                    ),
                  ),
              errorBorder: widget.errorBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: GlassTheme.error.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
              disabledBorder: widget.disabledBorder,
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.error_outline,
                size: 14,
                color: GlassTheme.error,
              ),
              const SizedBox(width: 4),
              Text(
                widget.errorText!,
                style: widget.errorStyle ??
                    TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: GlassTheme.error,
                    ),
              ),
            ],
          ),
        ] else if (widget.helperText != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.helperText!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: theme.textTertiary,
            ),
          ),
        ],
      ],
    );
  }
}

/// GlassInputField - Simple glass input with label and icons
class GlassInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final String? errorText;
  final int? maxLength;

  const GlassInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.errorText,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final hasError = errorText != null;

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
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: theme.glassInputBg,
            border: Border.all(
              color: hasError
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
              prefixIcon: Icon(
                icon,
                size: 20,
                color: hasError ? GlassTheme.error : theme.textTertiary,
              ),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              errorText!,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: GlassTheme.error,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
