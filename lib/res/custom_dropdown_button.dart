import 'package:flutter/material.dart';
import 'package:flutter_driver/utils/text_styles.dart';

// ignore: must_be_immutable
class CustomDropdown extends StatefulWidget {
  String? hintText;
  final String? Function(String?)? validator;
  TextEditingController controller;
  final List<dynamic> items;
  final Color? fillColor;
  final prifixIconVisible;
  final Color? selectedBorderColor;
  final Widget? prifixIcon;
  final String? img;
  // final void Function()? onChanged;
  final ValueChanged<String> onChanged;

  CustomDropdown({
    super.key,
    required this.hintText,
    required this.items,
    this.fillColor,
    this.selectedBorderColor,
    this.validator,
    required this.controller,
    this.prifixIconVisible,
    this.prifixIcon,
    this.img,
    required this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool isOpen = false;
  // TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: TextFormField(
            controller: widget.controller,
            readOnly: true,

            decoration: InputDecoration(
                filled: true,
                prefixIcon: widget.prifixIconVisible == true
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          widget.img ?? '',
                          width: 15,
                          height: 15,
                        ),
                      )
                    : widget.prifixIcon,
                fillColor: widget.fillColor ?? Colors.transparent,
                contentPadding: const EdgeInsetsDirectional.symmetric(
                    vertical: 10, horizontal: 10),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Color(0xFFCDCDCD),
                    // width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Color(0xFFCDCDCD),
                    // width: 2.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.red)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFCDCDCD))),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFCDCDCD))),
                hintText: widget.hintText,
                enabled: true,
                hintStyle: textStyle,
                suffixIcon: isOpen
                    ? const Icon(Icons.keyboard_arrow_up)
                    : const Icon(Icons.keyboard_arrow_down)),
            // validator: widget.validator,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select Item';
              }
              print({'validator value': value});

              return null;
            },
            onChanged: widget.onChanged,
            onTap: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
          ),
        ),
        // if (isOpen)
        Visibility(
          visible: isOpen,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 250),
            decoration: BoxDecoration(
                color: widget.fillColor,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            child: ListView(
              scrollDirection: Axis.vertical,
              // physics: PageScrollPhysics(),
              primary: true,
              shrinkWrap: true,
              children: widget.items
                  .map((e) => InkWell(
                        onTap: () {
                          widget.onChanged(e);

                          setState(() {
                            // widget.selectedValue = e;
                            // print({'Selected value..': widget.selectedValue});
                            isOpen = false;
                            widget.controller.text = e;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          decoration: widget.controller.text == e
                              ? BoxDecoration(
                                  border: Border.all(
                                      color: widget.selectedBorderColor ??
                                          Colors.black),
                                  borderRadius: BorderRadius.circular(10))
                              : const BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    e,
                                    style: textStyle,
                                  ),
                                ),
                                if (widget.controller.text == e)
                                  const Icon(Icons.check)
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
