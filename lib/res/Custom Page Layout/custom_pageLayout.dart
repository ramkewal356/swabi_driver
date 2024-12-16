import 'package:flutter/material.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:go_router/go_router.dart';

class CustomPagelayout extends StatelessWidget {
  final String appBarTitle;
  final void Function()? onTap;
  final Widget child;
  final Widget? actionIcon;
  const CustomPagelayout(
      {super.key,
      required this.appBarTitle,
      this.onTap,
      required this.child,
      this.actionIcon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBarbgcolor,
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          leading: GestureDetector(
            onTap: onTap ??
                () {
                  context.pop();
                },
            child: Padding(
              padding: const EdgeInsets.only(left: 28, top: 28, bottom: 25),
              child: Container(
                height: 20,
                width: 24,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: background),
                    borderRadius: BorderRadius.circular(5)),
                child: const Center(
                    child: Icon(
                  Icons.arrow_back,
                  color: background,
                )),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(20),
                //   child: Image.asset(
                //     backArrowIcon,
                //     color: Colors.white,
                //     fit: BoxFit.contain,
                //   ),
                // ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            appBarTitle,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          actions: [actionIcon ?? SizedBox.shrink()],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: background,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: child,
          ),
        ));
  }
}
