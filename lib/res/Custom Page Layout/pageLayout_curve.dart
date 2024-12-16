import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:go_router/go_router.dart';

class PageLayout_Curve extends StatelessWidget {
  final String appHeading;
  final String btnHeading;
  final String leadingAppImage;
  final bool saveBtn;
  final bool leadingBtn;
  final Widget child;
  final Widget? icon;
  final VoidCallback? onTap;
  final VoidCallback? leadingOnTap;
  final VoidCallback? iconOnTap;
  final String addtionalIcon;
  final EdgeInsets? padding;
  final bool addtionalIconReq;
  final Future<void> Function()? onRefresh;
  const PageLayout_Curve({
    super.key,
    required this.appHeading,
    this.btnHeading = "Save",
    this.addtionalIconReq = false,
    this.leadingAppImage = "",
    this.leadingBtn = false,
    this.addtionalIcon = "",
    this.iconOnTap,
    this.icon,
    this.leadingOnTap,
    this.saveBtn = false,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.onRefresh,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: bgGreyColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: background,
        surfaceTintColor: background,
        // toolbarHeight: 180,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: leadingOnTap ?? () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(50),
            child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: leadingBtn
                    ? Image.asset(leadingAppImage)
                    : const Icon(Icons.arrow_back)),
          ),
        ),

        // IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: Text(
          appHeading,
          style: appbarTextStyle,
        ),
        centerTitle: true,
        titleTextStyle: appbarTextStyle,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Material(
              color: background,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: addtionalIconReq
                    ? iconOnTap
                    : () => print("Icon Btn Press"),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  // padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  child: addtionalIconReq
                      ? Image.asset(addtionalIcon, height: 30, width: 30)
                      : null,
                ),
              ),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
          decoration: const BoxDecoration(
            color: bgGreyColor,
          ),

          ///jdh
          child: Column(
            children: [
              Expanded(
                  child: Container(
                child: child,
              )),
              saveBtn
                  ?
                  // CustomButtonSmall()
                  CustomButtonBig(
                      btnHeading: btnHeading,
                      onTap: onTap ?? () => print("onTap"))
                  : const SizedBox.shrink(),
              // Expanded(
              //     child: RefreshIndicator(
              //       onRefresh: onRefresh ?? () async {},
              //       child: Padding(
              //         padding: padding ?? EdgeInsets.symmetric(horizontal: 0,vertical: 0),
              //         child: child,
              //       ),
              //     )),
            ],
          ),
        ),
      ),
    ));
  }
}

class CommonPageLayout extends StatelessWidget {
  final String heading;
  final Widget child;
  final Widget? backButtonIcon;
  final Color? color;
  final bool tick;
  final bool create;
  final String onCreateTitle;
  final Color? backgroundColor;
  final ScrollPhysics physics;
  final VoidCallback? backButton;
  final VoidCallback? onTick;
  final VoidCallback? onCreate;
  final bool resizeToAvoidBottomInset;
  final bool customButton;
  final Widget? customWidget;
  final EdgeInsets padding;
  final bool floatingActionButton;
  final VoidCallback? floatingTap;
  final bool submitButton;
  final String submitTitle;
  // final LinearGradient submitColorGradient;
  final VoidCallback? onCancel;
  final VoidCallback? onSubmit;
  final Future<void> Function()? onRefresh;

  const CommonPageLayout({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(20, 0, 20, 20),
    this.floatingActionButton = false,
    this.submitButton = false,
    this.floatingTap,
    this.backButtonIcon,
    this.resizeToAvoidBottomInset = false,
    this.physics = const ScrollPhysics(),
    this.heading = "",
    this.tick = false,
    // this.submitColorGradient = primaryGradient,
    this.onTick,
    this.submitTitle = 'Submit',
    this.onCancel,
    this.onSubmit,
    this.backButton,
    this.color,
    this.create = false,
    this.onCreateTitle = '',
    this.onCreate,
    this.onRefresh,
    this.customButton = false,
    this.customWidget,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgGreyColor,
      floatingActionButton: floatingActionButton
          ? FloatingActionButton(
              onPressed: floatingTap,
              shape: const StadiumBorder(),
              backgroundColor: btnColor,
              child: const Icon(
                Icons.add,
                size: 50,
                color: Colors.white,
                weight: 4,
              ),
            )
          : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Scaffold(
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              backgroundColor: bgGreyColor,
              body: SingleChildScrollView(
                physics: physics,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: AppDimension.getHeight(context) * .9),
                    height: constraints.maxHeight,
                    color: color ?? bgGreyColor,
                    child: Column(
                      children: [
                        Expanded(
                            child: RefreshIndicator(
                          onRefresh: onRefresh ?? () async {},
                          child: Padding(
                            padding: padding,
                            child: child,
                          ),
                        )),
                        submitButton
                            ? Padding(
                                padding: padding,
                                child: CustomButtonSmall(
                                  btnHeading: submitTitle,
                                  onTap: onCancel ?? () => context.pop(),
                                  // linearGradient: submitColorGradient,
                                  // : onSubmit ?? () => print('Add a onSubmit here'),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
