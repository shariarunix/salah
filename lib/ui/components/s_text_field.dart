import 'package:flutter/material.dart';

class STextField extends StatelessWidget {
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final InputDecoration? decoration;
  final int? maxLength;
  final int? maxLines;
  final String? hintText;
  final double width;
  final TextInputType keyBoardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final String? errorText;
  final FocusNode? focusNode;
  final bool obscureText;
  final String obscuringCharacter;
  final String? labelText;
  final TextStyle? labelStyle;

  final TextInputAction? textInputAction;

  final VoidCallback? onTapPrefixIcon;
  final VoidCallback? onTapSuffixIcon;

  const STextField({
    super.key,
    required this.controller,
    this.style,
    this.decoration,
    this.maxLength,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.width = double.infinity,
    this.keyBoardType = TextInputType.text,
    this.prefixIcon,
    this.prefixIconColor,
    this.onTapPrefixIcon,
    this.suffixIcon,
    this.suffixIconColor,
    this.onTapSuffixIcon,
    this.errorText,
    this.focusNode,
    this.obscureText = false,
    this.obscuringCharacter = '*',
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null) ...[
            Text(
              labelText!,
              style: labelStyle ??
                  Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                      ),
            ),
            const SizedBox(height: 8),
          ],
          TextField(
            style: style ??
                Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                    ),
            controller: controller,
            focusNode: focusNode,
            scrollPhysics: const BouncingScrollPhysics(),
            decoration: decoration ??
                InputDecoration(
                  prefixIcon: GestureDetector(
                    onTap: onTapPrefixIcon,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        prefixIcon,
                        size: 22,
                        color: prefixIconColor ??
                            (errorText != null
                                ? Theme.of(context).colorScheme.error
                                : Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ),
                  suffixIcon: suffixIcon == null
                      ? null
                      : GestureDetector(
                          onTap: onTapSuffixIcon,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Icon(
                              suffixIcon,
                              size: 20,
                              color: suffixIconColor,
                            ),
                          ),
                        ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  errorText: errorText,
                  errorStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  filled: true,
                  fillColor: errorText == null
                      ? Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.05)
                      : Theme.of(context).colorScheme.error.withOpacity(0.1),
                  hintText: hintText,
                  hintStyle: hintStyle ??
                      Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: errorText == null
                                ? Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.5)
                                : Theme.of(context).colorScheme.error,
                          ),
                ),
            maxLength: maxLength,
            maxLines: maxLines,
            keyboardType: keyBoardType,
            obscureText: obscureText,
            obscuringCharacter: obscuringCharacter,
            textInputAction: textInputAction,
          ),
        ],
      ),
    );
  }
}
