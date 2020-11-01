import 'package:flutter/material.dart';

import 'package:boti_blog/ui/colors.dart';

class BotiTextFormField extends StatefulWidget {
  final ValueKey valueKey;

  final FormFieldValidator<String> validator;

  final ValueChanged<String> onChange;

  final ValueChanged<String> onFieldSubmitted;

  final FocusNode focusNode;

  final TextEditingController textEditingController;

  final TextInputAction textInputAction;

  final String label;

  final bool isPassword;

  const BotiTextFormField({
    this.valueKey,
    this.validator,
    this.onChange,
    this.onFieldSubmitted,
    this.focusNode,
    this.textEditingController,
    this.textInputAction,
    this.label,
    this.isPassword = false,
  }) : super(key: valueKey);

  @override
  _BotiTextFormFieldState createState() => _BotiTextFormFieldState();
}

class _BotiTextFormFieldState extends State<BotiTextFormField> {
  bool _obscuredText;

  @override
  Widget build(BuildContext context) {
    _obscuredText = _obscuredText ?? widget.isPassword;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: TextFormField(
        obscureText: _obscuredText,
        // key: widget.valueKey,
        autocorrect: false,
        decoration: new InputDecoration(
            labelText: widget.label,
            contentPadding: EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              right: 16.0,
              left: 16.0,
            ),
            filled: true,
            fillColor: BotiBlogColors.white,
            hintStyle: TextStyle(
              color: BotiBlogColors.mineShaft,
            ),
            border: new OutlineInputBorder(
              borderSide: new BorderSide(
                color: BotiBlogColors.boulder,
              ),
            ),
            enabledBorder: new OutlineInputBorder(
              borderSide: new BorderSide(
                color: BotiBlogColors.boulder,
              ),
            ),
            focusedBorder: new OutlineInputBorder(
              borderSide: new BorderSide(
                color: BotiBlogColors.greenHaze,
              ),
            ),
            suffixIcon: widget.isPassword
                ? FlatButton(
                    onPressed: _toggle,
                    child: Icon(
                      _obscuredText ? Icons.visibility : Icons.visibility_off,
                      color: BotiBlogColors.boulder,
                    ),
                  )
                : null),
        validator: widget.validator,
        style: new TextStyle(
          color: BotiBlogColors.mineShaft,
        ),
        onChanged: widget.onChange,
        buildCounter: (BuildContext context,
                {int currentLength, int maxLength, bool isFocused}) =>
            null,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        focusNode: widget.focusNode,
        controller: widget.textEditingController,
      ),
    );
  }

  _toggle() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }
}
