import 'package:flutter/material.dart';
import 'package:flutter_driver/model/driver_profile_model.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/custom_list_tile.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_driver/view_model/driver_rental_booking_view_model.dart';
import 'package:flutter_driver/view_model/driverProfile_view_model.dart';
import 'package:flutter_driver/view_model/driver_package_view_model.dart';
import 'package:flutter_driver/view_model/notification_view_model.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuList extends StatefulWidget {
  final String userId;
  const MenuList({super.key, required this.userId});

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getNotification();
    });
  }

  Future<void> _loadNotiValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      noti = prefs.getBool('noti') ?? false;
    });
  }

  // Future<void> _saveNotiValue(bool value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('noti', value);
  // }

  void getNotification() {
    Provider.of<NotificationViewModel>(context, listen: false)
        .getAllNotificationList(
            context: context,
            userId: widget.userId,
            pageNumber: 0,
            pageSize: 100,
            readStatus: 'FALSE');
  }

  int isSelectedindex = 0;
  @override
  Widget build(BuildContext context) {
    debugPrint("${noti}Value Data");
    debugPrint('${widget.userId} menu user id');
    DriverProfileData? driverData =
        context.watch<DriverProfileViewModel>().DataList.data?.data;
   
    return SafeArea(
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
                  'Last sync : ${driverData?.lastLogin.replaceAll(RegExp(r':\d{2} [A-Z]{3}$'), '') ?? ''}',
                  style: textTextStyle,
                )
              ],
            ),
          ),
        
          const SizedBox(height: 20),
         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Custom_ListTile(
              img: profile,
              iconColor: btnColor,
              heading: "Profile",
              onTap: () {
               
                context.push("/profilePage", extra: {"userId": widget.userId});
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Custom_ListTile(
                img: rentalBooking,
                iconColor: btnColor,
                heading: "Rental Management",
                onTap: () {
                  context.push("/historyManagement",
                      extra: {"myID": widget.userId}).then((value) {
                    Provider.of<DriverGetBookingListViewModel>(context,
                            listen: false)
                        .fetchDriverGetBookingListViewModel({
                      "driverId": widget.userId,
                      "pageNumber": "0",
                      "pageSize": "5",
                      "bookingStatus": "BOOKED"
                    }, context);
                    Provider.of<DriverPackageViewModel>(context, listen: false)
                        .getPackageBookingList(context: context);
                  });
                  Navigator.pop(context);
                  // context.push("/booking")
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Custom_ListTile(
              img: package,
              iconColor: btnColor,
              heading: "Package Management",
              onTap: () {
             
                context.push('/packageBookingManagement').then((value) {
                  Provider.of<DriverGetBookingListViewModel>(context,
                          listen: false)
                      .fetchDriverGetBookingListViewModel({
                    "driverId": widget.userId,
                    "pageNumber": "0",
                    "pageSize": "5",
                    "bookingStatus": "BOOKED"
                  }, context);
                  Provider.of<DriverPackageViewModel>(context, listen: false)
                      .getPackageBookingList(context: context);
                });
                Navigator.pop(context);
              },
              // context.push("/booking")
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Custom_ListTile(
                img: helpSupport,
                iconColor: btnColor,
                heading: "Help & Support",
                onTap: () {
                  context.push("/help&support");
                  context.pop();
                }),
          ),
       
          const Spacer(),
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
