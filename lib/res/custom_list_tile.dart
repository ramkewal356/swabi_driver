import 'package:flutter/material.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:flutter_driver/utils/text_styles.dart';

class Custom_ListTile extends StatelessWidget {
  final String img;
  final Color? iconColor;
  final bool disableColor;
  final String headingTitle;
  final bool headingTitleReq;
  final VoidCallback onTap;
  final String heading;
  const Custom_ListTile(
      {this.img = "",
      this.iconColor,
      this.disableColor = false,
      this.headingTitle = "",
      this.headingTitleReq = false,
      this.heading = "",
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingTitleReq
            ? Text(headingTitle, style: loginTextStyle)
            : const SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 5),
          child: Material(
            color:
                disableColor ? naturalGreyColor.withOpacity(0.2) : background,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onTap,
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                    color: disableColor
                        ? naturalGreyColor.withOpacity(0.2)
                        : background,
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: naturalGreyColor.withOpacity(0.3))),
                width: AppDimension.getWidth(context) * .9,
                child: Row(
                  children: [
                    Image.asset(
                      img,
                      height: 20,
                      color: iconColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        heading,
                        style: custom_ListTileTextStyle,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// class Custom_ListTileSwitch extends StatelessWidget {
//   const Custom_ListTileSwitch({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     bool notification = false;
//     return Container(
//       height: 50,
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: naturalGreyColor)
//       ),
//       width: AppDimension.getWidth(context)*.9,
//       child: Row(
//         children: [
//           Image.asset(profile,height: 20,),
//           Padding(padding:EdgeInsets.symmetric(horizontal: 15),
//             child: Text("Profile",style: custom_ListTileTextStyle,),
//           ),
//           Spacer(),
//           Switch(value: notification, onChanged: (value) {
//             notification = value;
//           },)
//
//         ],
//       ),
//     );
//   }
// }

class Custom_ListTileSwitch extends StatefulWidget {
  final String img;
  final String heading;
  final Widget notification;
  final VoidCallback? onTap;
  const Custom_ListTileSwitch(
      {required this.notification,
      required this.img,
      this.onTap,
      required this.heading,
      super.key});

  @override
  State<Custom_ListTileSwitch> createState() => _Custom_ListTileSwitchState();
}

class _Custom_ListTileSwitchState extends State<Custom_ListTileSwitch> {
  bool noti = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: background,
        elevation: 0,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: widget.onTap,
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: naturalGreyColor.withOpacity(0.3))),
            width: AppDimension.getWidth(context) * .9,
            child: Row(
              children: [
                Image.asset(
                  widget.img,
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    widget.heading,
                    style: custom_ListTileTextStyle,
                  ),
                ),
                const Spacer(),
                widget.notification
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListtile extends StatefulWidget {
  final String userIcon;
  final String title;
  final bool selected;
  final VoidCallback onTap;
  const CustomListtile(
      {super.key,
      required this.userIcon,
      required this.title,
      this.selected = false,
      required this.onTap});

  @override
  State<CustomListtile> createState() => _CustomListtileState();
}

class _CustomListtileState extends State<CustomListtile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(8),
        color: background,
        child: ListTile(
            selected: widget.selected,
            selectedColor: widget.selected ? background : Colors.black,
            selectedTileColor: widget.selected ? btnColor : background,
            leading: Image.asset(
              widget.userIcon,
              height: 20,
              color: widget.selected ? background : btnColor,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: greyColor1)),
            title: Text(widget.title),
            trailing: Icon(
              Icons.keyboard_arrow_right_outlined,
              color: widget.selected ? background : Colors.black,
            ),
            onTap: widget.onTap),
      ),
    );
  }
}
