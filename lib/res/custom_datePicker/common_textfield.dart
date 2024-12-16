

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FormTextField extends StatelessWidget {
  final bool isEnabled;
  final String status;
  final String title;
  final String hint;
  final icon;
  final icons;
  final bool numberOnly;
  final int length;
  final controller;
  final onTap;

  const FormTextField({
    Key? key,
    this.isEnabled = true,
    this.onTap,
    this.icons,
    this.title = '',
    required this.controller,
    this.hint = '',
    this.icon,
    this.numberOnly = false,
    this.length = 0, this.status = "Status.completed",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: appbarTextStyle,
          ),
        ),
        Container(
          height: 35,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 5, bottom: 15),
          padding: const EdgeInsets.only(left: 12),
          decoration: ShapeDecoration(
            color: isEnabled ? Colors.white : naturalGreyColor,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 0.30,
              ), //color: Color(0xFFC1C0C0)
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Row(
            children: [
              icon != null
                  ? Image.asset(icon!,
                      height: 15, width: 15, color: const Color(0xFFC1C0C0))
                  : Container(),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: IntrinsicWidth(
                    child: Container(
                      constraints: BoxConstraints(
                          minWidth: AppDimension.getWidth(context) * .8),
                      child: TextFormField(
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: naturalGreyColor,
                            ),
                        enabled: isEnabled,
                        onTap: onTap,
                        maxLines: 1,
                        maxLength: length == 0 ? null : length,
                        keyboardType: numberOnly ? TextInputType.number : null,
                        inputFormatters: numberOnly
                            ? [FilteringTextInputFormatter.digitsOnly]
                            : null,
                        controller: controller,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                            prefixIcon: icons,
                            hintText: hint,
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: naturalGreyColor,
                              ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            counterText: ''),
                      ),
                    ),
                  ),
                ),
              ),
              status == "Status.loading" ? const Padding(
                padding: EdgeInsets.only(right: 10),
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: naturalGreyColor,
                    )),
              ) : Container()
            ],
          ),
        ),
      ],
    );
  }
}

class FormDatePicker extends StatefulWidget {
  final String title;
  final String hint;
  final bool enabled;
  final TextEditingController controller;

  const FormDatePicker({
    Key? key,
    required this.title,
    required this.controller,
    this.hint = '', this.enabled = true,
  }) : super(key: key);

  @override
  _FormDatePickerState createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<FormDatePicker> {
  final DateTime now = DateTime.now();
  @override
  void initState() {
    super.initState();
    widget.controller.text.isEmpty
        ? selectedDate = DateTime.now()
        : selectedDate = DateFormat('dd-MM-yyyy').parse(widget.controller.text);
  }

  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    widget.controller.text =
        DateFormat('dd-MM-yyyy').format(selectedDate!.toLocal());
    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: selectedDate ?? DateTime.now(),
      // firstDate: DateTime(DateTime.now().year),
      // lastDate: DateTime(DateTime.now().year + 1),
      initialDate: DateTime(now.year, now.month, now.day),
      firstDate: DateTime(now.year),
      lastDate: DateTime(now.year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: naturalGreyColor, // Change this to the desired color
            colorScheme: const ColorScheme.light(
              primary: naturalGreyColor, // Change this to the desired color
            ),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {

      setState(() {
        selectedDate = picked;
        widget.controller.text =
            DateFormat('dd-MM-yyyy').format(selectedDate!.toLocal());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.enabled ? () => _selectDate(context) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: appbarTextStyle,
            ),
          ),
          Container(
            height: 35,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 5, bottom: 15),
            padding: const EdgeInsets.only(left: 12),
            decoration: ShapeDecoration(
              color: widget.enabled ? Colors.white : naturalGreyColor,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0.30,
                ), //color: Color(0xFFC1C0C0)
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.calendar_month)
                  // Image.asset(
                  //   calendarIcon,
                  //   height: 15.h,
                  //   width: 15.h,
                  // ),
                ),
                Text(
                    widget.controller.text.isNotEmpty
                        ? widget.controller.text
                        : widget.hint,
                    style: widget.controller.text.isNotEmpty
                        ? appbarTextStyle
                        // TextStyle(
                        //         color: blackTextColor,
                        //         fontSize: 12.sp,
                        //         fontFamily: interRegular,
                        //         //  fontWeight: FontWeight.w400,
                        //       )
                        : appbarTextStyle
                    // TextStyle(
                    //         color: greyColor,
                    //         fontSize: 12.sp,
                    //         fontFamily: interRegular,
                    //         // fontWeight: FontWeight.w400,
                    //       ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DatePickerForm extends StatefulWidget {
  final String title;
  final String hint;
  final double? width;
  final TextEditingController controller;

  const DatePickerForm({
    Key? key,
    required this.title,
    required this.controller,
    this.hint = '',
    this.width,
  }) : super(key: key);

  @override
  _DatePickerFormState createState() => _DatePickerFormState();
}

class _DatePickerFormState extends State<DatePickerForm> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.orange, // Change this to the desired color
            colorScheme: const ColorScheme.light(
              primary: lightBrownColor, // Change this to the desired color
            ),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              color: Colors.white,
              // margin: const EdgeInsets.only(left: 14),
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(widget.title,
                  style:titleTextStyle
              )),
          const SizedBox(height: 5,),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 50,
              width: widget.width,
              // margin: const EdgeInsets.only(top: 7),
              padding: const EdgeInsets.only(left: 15),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color:curvePageColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.calendar_month,
                      color: curvePageColor,
                    ),
                  ),
                  Text(
                      widget.controller.text.isEmpty || selectedDate == null
                          ? widget.hint
                          : "${selectedDate?.toLocal()}".split(' ')[0],
                      style: GoogleFonts.lato(
                        color: widget.controller.text.isEmpty
                            ? naturalTextColor
                            : greyColor,
                        fontSize: 14,
                        // fontFamily: inter,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class TextFeildTiming extends StatefulWidget {
  final String title;
  final String hint;
  final double? width;
  final TextEditingController controller;
  const TextFeildTiming({ Key? key,
    required this.title,
    required this.controller,
    this.hint = '',
    this.width,
  }) : super(key: key);

  @override
  State<TextFeildTiming> createState() => _TextFeildTimingState();
}

class _TextFeildTimingState extends State<TextFeildTiming> {
  DateTime? selectedDate;

  TimeOfDay? timing;



  Future<void> _selectTiming(BuildContext context) async {
    final TimeOfDay? timingPick = await showTimePicker(
      context: context,
      initialTime: timing ?? TimeOfDay.now(),
      // firstDate: DateTime(1900),
      // lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: naturalGreyColor, // Change this to the desired color
            colorScheme: const ColorScheme.light(
              primary: naturalGreyColor, // Change this to the desired color
            ),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (timingPick != null && timingPick != timing) {
      setState(() {
        timing = timingPick;
        widget.controller.text = timingPick.format(context).toString().split(' ')[0];
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => _selectTiming(context),
              // _showTimePicker(),
              // _selectDate(context),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  color: Colors.white,
                  // margin: const EdgeInsets.only(left: 14),
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Text(widget.title,
                      style: titleTextStyle)),
              const SizedBox(height: 5,),
              Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5,
                child: Container(
                  height: 50,
                  width: widget.width,
                  // margin: const EdgeInsets.only(top: 7),
                  padding: const EdgeInsets.only(left: 15),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: naturalGreyColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.access_time,
                          color: naturalGreyColor,
                        ),
                      ),
                      Text(
                          widget.controller.text.isEmpty || timing == null
                              ? widget.hint
                              : timing!.format(context).toString(),
                          style: GoogleFonts.lato(
                            color: widget.controller.text.isEmpty
                                ? naturalGreyColor
                                : greyColor,
                            fontSize: 14,
                            // fontFamily: inter,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FormDropDown extends StatefulWidget {
  final String title;
  final String selectedValue;
  final List<String> dropDownValues;
  final TextEditingController controller; // Add a controller
  final VoidCallback? onTap;

  const FormDropDown({
    Key? key,
    required this.selectedValue,
    required this.dropDownValues,
    required this.title,
    required this.controller,
    this.onTap, // Initialize the controller
  }) : super(key: key);

  @override
  State<FormDropDown> createState() => _FormDropDownState();
}

class _FormDropDownState extends State<FormDropDown> {
  late String selectedValue; // Initial selected value
  late List<String> dropdownValues; // Dropdown options

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
    dropdownValues = widget.dropDownValues;
    widget.controller.text = selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 35,
          constraints: const BoxConstraints(maxWidth: 130),
          child: Text(
            widget.title,
            overflow: TextOverflow.ellipsis,
            style: infoTextStyle,
          ),
        ),
        Flexible(
          child: Container(
            height: 35,
            constraints: const BoxConstraints(minWidth: 51, maxWidth: 130),
            padding: const EdgeInsets.only(left: 7, right: 7),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.45, color: Color(0xFFDDDDDD)),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: DropdownButton2<String>(
                value: selectedValue.isNotEmpty ? selectedValue : null,
                // menuMaxHeight: 150,
                // borderRadius: BorderRadius.circular(6),
                hint: Text(
                  'Please Choose...',
                  style: infoTextStyle,
                ),
                // icon: Container(),
                // icon: Align(
                //   alignment: Alignment.centerLeft,
                //   child: Icon(Icons.arrow_drop_down, color: Colors.grey),
                // ),
                // iconSize: 24,
                // elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  widget.onTap!();
                  setState(() {
                    selectedValue = newValue!;
                    widget.controller.text =
                        selectedValue; // Update the controller
                  });
                },
                underline: Container(
                  height: 0,
                  color: Colors.transparent,
                ),
                items: dropdownValues
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: infoTextStyle),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropDownButton extends StatefulWidget {
  final String title;
  final String selectedValue;
  final List<String> dropDownValues;
  final TextEditingController controller; // Add a controller
  final VoidCallback? onTap;
  final double width;
  // final String heading;
  final String hint;
  final bool headingReq;
  const CustomDropDownButton({
    required this.width,
    required this.title,
    required this.selectedValue,
    required this.dropDownValues,
    required this.controller,
    this.onTap,
    this.hint = "",
    this.headingReq = false,
    // this.heading = "",
    super.key, });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {

  late String selectedValue; // Initial selected value
  late List<String> dropdownValues; // Dropdown options

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
    dropdownValues = widget.dropDownValues;
    widget.controller.text = selectedValue;
  }
  // String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.headingReq?Text(widget.title,style: titleTextStyle,):const SizedBox.shrink(),
        const SizedBox(height: 5),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: widget.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: curvePageColor,width: 1)
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                iconStyleData: const IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 30
                ),
                isExpanded: true,
                hint: Text(
                  widget.hint,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items:dropdownValues
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: titleTextStyle),
                  );
                }).toList(),
                // items: items
                //     .map((String item) => DropdownMenuItem<String>(
                //   value: item,
                //   child: Text(
                //     item,
                //     style: const TextStyle(
                //       fontSize: 14,
                //     ),
                //   ),
                // )).toList(),
                value: selectedValue,
                onChanged: (String? newValue) {
                  widget.onTap!();
                  setState(() {
                    selectedValue = newValue!;
                    widget.controller.text =
                        selectedValue; // Update the controller
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// class PageFormDropDown extends StatefulWidget {
//   final String selectedIndex;
//   final List<String> dropDownValues;
//   final TextEditingController textEditingController;
//   final VoidCallback onTap;
//
//   const PageFormDropDown(
//       {super.key,
//       required this.selectedIndex,
//       required this.dropDownValues,
//       required this.textEditingController,
//       required this.onTap});
//
//   @override
//   State<PageFormDropDown> createState() => _PageFormDropDownState();
// }
//
// class _PageFormDropDownState extends State<PageFormDropDown> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Text(
//           'Page',
//           style: TextStyle(
//             color: blackTextColor,
//             fontSize: 9.sp,
//             fontFamily: interRegular,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         Container(
//           width: 39.w,
//           margin: EdgeInsets.symmetric(horizontal: 7.h),
//           child: FormDropDown(
//               selectedValue: widget.selectedIndex,
//               dropDownValues: widget.dropDownValues,
//               title: '',
//               onTap: widget.onTap,
//               controller: widget.textEditingController),
//         ),
//         Text(
//           'of 10',
//           style: TextStyle(
//             color: blackTextColor,
//             fontSize: 9.sp,
//             fontFamily: interRegular,
//             fontWeight: FontWeight.w600,
//           ),
//         )
//       ],
//     );
//   }
// }
//


class FormDatePickerExpense extends StatefulWidget {
  final String title;
  final String hint;
  final double? width;
  final TextEditingController controller;

  const FormDatePickerExpense({
    Key? key,
    required this.title,
    this.width,
    required this.controller,
    this.hint = '',
  }) : super(key: key);

  @override
  _FormDatePickerExpenseState createState() => _FormDatePickerExpenseState();
}

class _FormDatePickerExpenseState extends State<FormDatePickerExpense> {
  final DateTime now = DateTime.now();
  @override
  void initState() {
    super.initState();
    widget.controller.text.isEmpty
        ? selectedDate = DateTime.now().add(const Duration(days: 1))
        : selectedDate = DateFormat('dd-MM-yyyy').parse(widget.controller.text);
  }

  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    widget.controller.text = DateFormat('dd-MM-yyyy').format(selectedDate!.toLocal());
    final DateTime? picked = await showDatePicker(
      context: context,
       initialDate: selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      // firstDate: DateTime(DateTime.now().year),
      // lastDate: DateTime(DateTime.now().year + 1),
      //initialDate: DateTime(now.year, now.month, now.day),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(now.year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: redColor, // Change this to the desired color
            colorScheme: const ColorScheme.light(
              primary: Colors.orange, // Change this to the desired color
            ),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {

      setState(() {
        selectedDate = picked;
        widget.controller.text =
            DateFormat('dd-MM-yyyy').format(selectedDate!.toLocal());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            widget.title,
            overflow: TextOverflow.ellipsis,
            style: titleTextStyle,
          ),
        ),
        const SizedBox(height: 5,),
        Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 5,
          color: background,
          child: InkWell(
            onTap: () => _selectDate(context),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 50,
              width: widget.width ?? AppDimension.getWidth(context)*.9,
              // margin: EdgeInsets.only(top: 5, bottom: 15),
              padding: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                color: background,
                border: Border.all( width: 1,color: curvePageColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(Icons.calendar_month_outlined,color: naturalGreyColor,),
                  ),
                  Text(
                      widget.controller.text.isNotEmpty
                          ? widget.controller.text
                          : widget.hint,
                      style: widget.controller.text.isNotEmpty
                          ? titleTextStyle
                          : loginTextStyle
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}




// class FilterDatePickerForm extends StatefulWidget {
//   final String title;
//   final String hint;
//   final TextEditingController controller;
//
//   const FilterDatePickerForm({
//     Key? key,
//     required this.title,
//     required this.controller,
//     this.hint = '',
//   }) : super(key: key);
//
//   @override
//   _FilterDatePickerFormState createState() => _FilterDatePickerFormState();
// }
//
// class _FilterDatePickerFormState extends State<FilterDatePickerForm> {
//   DateTime? selectedDate;
//   DateTime now = DateTime.now();
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: now.add(Duration(days: 6 * 30)),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             primaryColor: secondary, // Change this to the desired color
//             colorScheme: ColorScheme.light(
//               primary: secondary, // Change this to the desired color
//             ),
//             buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (picked != null ) {
//
//       setState(() {
//         selectedDate = picked;
//         widget.controller.text = "${picked.toLocal()}".split(' ')[0];
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       flex: 2,
//       child: InkWell(
//         onTap: () => _selectDate(context),
//         child: Stack(
//           children: [
//             Container(
//               height: 35.h,
//               width: double.infinity,
//               margin: EdgeInsets.only(top: 7.h),
//               padding: EdgeInsets.only(left: 15.w),
//               decoration: ShapeDecoration(
//                 shape: RoundedRectangleBorder(
//                   side: const BorderSide(width: 0.3, color: greyColor),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: Icon(
//                       Icons.calendar_month,
//                       color: secondary,
//                     ),
//                   ),
//                   Text(
//                       widget.controller.text.isEmpty || selectedDate == null
//                           ? widget.hint
//                           : "${selectedDate?.toLocal()}".split(' ')[0],
//                       style: TextStyle(
//                         color: widget.controller.text.isEmpty
//                             ? calendercolor
//                             : textcolor,
//                         fontSize: 10.sp,
//                         fontFamily: inter,
//                         fontWeight: FontWeight.w500,
//                       )),
//                 ],
//               ),
//             ),
//             Container(
//                 color: Colors.white,
//                 margin: EdgeInsets.only(left: 14.w),
//                 padding: EdgeInsets.symmetric(horizontal: 3.w),
//                 child: Text(widget.title,
//                     style: TextStyle(
//                       color: greyColor,
//                       fontSize: 10.sp,
//                       fontFamily: inter,
//                       fontWeight: FontWeight.w600,
//                     )))
//           ],
//         ),
//       ),
//     );
//   }
// }

//CommonTextField
class CommonTextField extends StatelessWidget {
  final bool isEnabled;
  final String status;
  final double? height;
  final EdgeInsets? padding;
  final bool title1;
  final String title;
  final String hint;
  final icon;
  final icons;
  final bool numberOnly;
  final int length;
  final controller;
  final onTap;

  const CommonTextField({
    Key? key,
    this.isEnabled = true,
    this.onTap,
    this.icons,
    this.title1 = false,
    this.title = '',
    required this.controller,
    this.hint = '',
    this.icon,
    this.numberOnly = false,
    this.length = 0, this.status = "Status.completed", this.height, this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title1 ? Container(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: appbarTextStyle,
          ),
        ) : const SizedBox.shrink(),
        Container(
          height: height ?? 22,
          margin: padding ?? EdgeInsets.zero,
          padding: const EdgeInsets.only(left: 12),
          decoration: ShapeDecoration(
            color: naturalGreyColor,
            shape: RoundedRectangleBorder(
              side: BorderSide.none, //color: Color(0xFFC1C0C0)
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Row(
            children: [
              icon != null
                  ? Image.asset(icon!,
                  height: 15, width: 15, color: const Color(0xFFC1C0C0))
                  : Container(),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: IntrinsicWidth(
                    child: Container(
                      constraints: BoxConstraints(
                          minWidth: AppDimension.getWidth(context) * .8),
                      child: TextFormField(
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: naturalGreyColor,
                            ),
                        enabled: isEnabled,
                        onTap: onTap,
                        maxLines: 1,
                        maxLength: length == 0 ? null : length,
                        keyboardType: numberOnly ? TextInputType.number : null,
                        inputFormatters: numberOnly
                            ? [FilteringTextInputFormatter.digitsOnly]
                            : null,
                        controller: controller,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                            prefixIcon: icons,
                            hintText: hint,
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: naturalGreyColor,
                                ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 0),
                            counterText: ''),
                      ),
                    ),
                  ),
                ),
              ),
              status == "Status.loading" ? const Padding(
                padding: EdgeInsets.only(right: 10),
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: naturalGreyColor,
                    )),
              ) : Container()
            ],
          ),
        ),
      ],
    );
  }
}





