import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/text_styles.dart';

class Customtextformfield extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool? prefixiconvisible;
  final Widget? prefixIcon;
  final String? img;
  final bool? obscureText;
  final int? maxLines;
  final int? minLines;
  final int? textLength;
  final String? obscuringCharacter;
  final TextInputType? keyboardType;
  final TextAlignVertical? textAlignVertical;
  final bool? enableInteractiveSelection;
  final bool? enabled;
  final Widget? suffixIcons;
  final Color? fillColor;
  final FocusNode? focusNode;
  final String? errorText;
  final double? width;
  final double? hieght;
  const Customtextformfield(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator,
      this.obscureText,
      this.maxLines,
      this.minLines = 1,
      this.textLength,
      this.obscuringCharacter,
      this.textAlignVertical,
      this.enableInteractiveSelection,
      this.keyboardType,
      this.suffixIcons,
      this.fillColor,
      this.onChanged,
      this.prefixIcon,
      this.prefixiconvisible,
      this.img,
      this.enabled,
      this.focusNode,
      this.errorText,
      this.width,
      this.hieght});

  @override
  State<Customtextformfield> createState() => _CustomtextformfieldState();
}

class _CustomtextformfieldState extends State<Customtextformfield> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.hieght,
      width: widget.width,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: widget.focusNode,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        obscureText: widget.obscureText ?? false,
        obscuringCharacter: widget.obscuringCharacter ?? '•',
        controller: widget.controller,
        textAlignVertical: widget.textAlignVertical,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.textLength),
          FilteringTextInputFormatter.allow(
            RegExp(r'^[\u0000-\u007F]*$'),
          ),
        ],
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines,
        keyboardType: widget.keyboardType,
        enabled: widget.enabled,
        decoration: InputDecoration(
            errorText: widget.errorText,
            errorMaxLines: 2,
            suffixIcon: widget.suffixIcons,
            fillColor: widget.fillColor,
            filled: widget.fillColor != null,
            prefixIcon: widget.prefixiconvisible == true
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      widget.img ?? '',
                      width: 15,
                      height: 15,
                    ),
                  )
                : widget.prefixIcon,
            hintText: widget.hintText,
            hintStyle: hintTextStyle,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            // border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Color(0xFFCDCDCD),
                // width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Color(0xFFCDCDCD),
                // width: 2.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Color(0xFFCDCDCD),
                // width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Color(0xFFCDCDCD),
                // width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: redColor,
                // width: 2.0,
              ),
            )

            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(12),
            //     borderSide: BorderSide(color: Color(0xFFCDCDCD))),
            ),
        validator: widget.validator,
        onChanged: widget.onChanged,
      ),
    );
  }
}
