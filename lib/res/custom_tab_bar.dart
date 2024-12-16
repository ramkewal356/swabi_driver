import 'package:flutter/material.dart';

import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/utils/color.dart';

class Customtabbar extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> viewchildren;
  final TabController? controller;
  final void Function(int)? onTap;
  const Customtabbar(
      {super.key,
      required this.tabs,
      required this.viewchildren,
      this.controller,
      this.onTap});

  @override
  State<Customtabbar> createState() => _CustomtabbarState();
}

class _CustomtabbarState extends State<Customtabbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
              // width: AppDimension.getWidth(context) * .9,
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: background,
                  border: Border.all(color: naturalGreyColor.withOpacity(0.3))),
              child: TabBar(
                // isScrollable: true,
                controller: widget.controller,
                onTap: widget.onTap,
                // indicator: const BoxDecoration(
                //     color: Colors.transparent,
                //     border:
                //         Border(bottom: BorderSide(width: 5, color: btnColor)),
                //     borderRadius: BorderRadius.only(
                //         bottomLeft: Radius.circular(15),
                //         bottomRight: Radius.circular(15))),
                splashBorderRadius: BorderRadius.circular(20),
                unselectedLabelColor: Colors.black87,
                labelColor: Colors.black,
                indicatorColor: buttonColor,
                dividerColor: Colors.transparent,
                indicatorWeight: 2.5,
                indicatorPadding: const EdgeInsets.only(left: 5, right: 5),
                labelPadding: const EdgeInsets.symmetric(vertical: 0),
                tabAlignment: TabAlignment.fill,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: List.generate(widget.tabs.length, (index) {
                  return Tab(
                    child: Text(
                      widget.tabs[index].toString(),
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  );
                }),
              )),
          SizedBox(height: 10),
          Expanded(
              child: TabBarView(
                  controller: widget.controller, children: widget.viewchildren))
        ],
      ),
    );
  }
}
