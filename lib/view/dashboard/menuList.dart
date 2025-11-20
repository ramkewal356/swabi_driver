import 'package:flutter/material.dart';
import 'package:flutter_driver/widgets/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/core/constants/assets.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/common/styles/text_styles.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuList extends StatefulWidget {
  final List<Map<String, dynamic>> menuItems;
  final String lastLogin;

  const MenuList({super.key, required this.lastLogin, required this.menuItems});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  bool noti = false;

  UserViewModel userViewModel = UserViewModel();

  @override
  void initState() {
    super.initState();
    _loadNotiValue();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   getNotification();
    // });
  }

  Future<void> _loadNotiValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      noti = prefs.getBool('noti') ?? false;
    });
  }



 

  int isSelectedindex = 0;
  @override
  Widget build(BuildContext context) {
   
   
    return Drawer(
      backgroundColor: bgGreyColor,
      elevation: 2,
      child: Column(
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          DrawerHeader(
            // decoration: BoxDecoration(color: background),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 25),
                Image.asset(
                  appLogo1,
                  height: 65,
                  width: double.infinity,
                ),
                const SizedBox(height: 15),
                Text(
                  'Last sync : ${widget.lastLogin.replaceAll(RegExp(r':\d{2} [A-Z]{3}$'), '')}',
                  style: textTextStyle,
                )
              ],
            ),
          ),
        
          const SizedBox(height: 10),

          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: widget.menuItems.length,
              itemBuilder: (context, index) {
                final item = widget.menuItems[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: ListTile(
                    horizontalTitleGap: 10,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: greyColor1),
                        borderRadius: BorderRadius.circular(10)),
                    // selected: widget.selectedIndex == index,
                    selected: isSelectedindex == index,
                    selectedTileColor: buttonColor,
                    onTap: () {
                      // widget.onItemSelected(index);
                      if (item['onTap'] != null) {
                        item['onTap']();
                        context.pop();
                      }
          
                      setState(() {
                        isSelectedindex = index;
                      });
                    },
                    leading: Icon(
                      item['imgUrl'],
                      color:
                          isSelectedindex == index ? Colors.white : buttonColor,
                    ),
                    title: Text(item['label'],
                        style: isSelectedindex == index
                            ? selectedTextStyle
                            : unSelectedTextStyle
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color:
                          isSelectedindex == index ? Colors.white : buttonColor,
                    ),
                  ),
                );
              }),
         
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: Custom_ListTile(
          //     img: profile,
          //     iconColor: btnColor,
          //     heading: "Profile",
          //     onTap: () {

          //       context.push("/profilePage", extra: {"userId": widget.userId});
          //       Navigator.pop(context);
          //     },
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: Custom_ListTile(
          //       img: rentalBooking,
          //       iconColor: btnColor,
          //       heading: "Rental Management",
          //       onTap: () {
          //         context.push("/historyManagement",
          //             extra: {"myID": widget.userId}).then((value) {
          //           Provider.of<DriverGetBookingListViewModel>(context,
          //                   listen: false)
          //               .fetchDriverGetBookingListViewModel({
          //             "driverId": widget.userId,
          //             "pageNumber": "0",
          //             "pageSize": "5",
          //             "bookingStatus": "BOOKED"
          //           }, context);
          //           Provider.of<DriverPackageViewModel>(context, listen: false)
          //               .getPackageBookingList(context: context);
          //         });
          //         Navigator.pop(context);
          //         // context.push("/booking")
          //       }),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: Custom_ListTile(
          //     img: package,
          //     iconColor: btnColor,
          //     heading: "Package Management",
          //     onTap: () {
          //       final safeContext =
          //           context; // ✅ Capture the context before navigation

          //       Navigator.pop(context); // Close the drawer

          //       Future.delayed(Duration.zero, () {
          //         context.push('/packageBookingManagement').then((value) {
          //           if (!mounted) return; // ✅ Ensure widget is still in tree

          //           // ✅ Safe API calls using captured context
          //           Provider.of<DriverGetBookingListViewModel>(safeContext,
          //                   listen: false)
          //               .fetchDriverGetBookingListViewModel({
          //             "driverId": widget.userId,
          //             "pageNumber": "0",
          //             "pageSize": "5",
          //             "bookingStatus": "BOOKED"
          //           }, safeContext);

          //           Provider.of<DriverPackageViewModel>(safeContext,
          //                   listen: false)
          //               .getPackageBookingList(context: safeContext);
          //         });
          //       });
          //     },
          //     // context.push("/booking")
          //   ),
          // ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: Custom_ListTile(
          //       img: helpSupport,
          //       iconColor: btnColor,
          //       heading: "Help & Support",
          //       onTap: () {
          //         context.push("/help&support");
          //         context.pop();
          //       }),
          // ),
       
          // const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: CustomButtonLogout(
                  img: logout,
                  btnHeading: "Logout",
                  onTap: () {
                    Navigator.pop(context);
                    _confirmLogout();

                   
                  }),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
    // );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: background,
          surfaceTintColor: background,
       
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Are you sure want to Logout ?',
                        style: titleTextStyle,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButtonSmall(
                        width: 90,
                        height: 40,
                        btnHeading: "Cancel",
                        onTap: () {
                          context.pop();
                        },
                      ),
                      CustomButtonSmall(
                        width: 90,
                        height: 40,
                        btnHeading: "Logout",
                        onTap: () {
                          userViewModel.remove(context);
                          context.go("/login");
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      
      },
    );
  }
}
