import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_driver/model/user_model.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_driver/view/dashboard/menuList.dart';
import 'package:flutter_driver/view/dashboard/package/custom_package_view_screen.dart';
import 'package:flutter_driver/view/dashboard/rental/history/all_booking_container.dart';
import 'package:flutter_driver/view_model/driver_rental_booking_view_model.dart';
import 'package:flutter_driver/view_model/driverProfile_view_model.dart';
import 'package:flutter_driver/view_model/driver_package_view_model.dart';
import 'package:flutter_driver/view_model/notification_view_model.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class home_screen extends StatefulWidget {
  // final String timeZone;
  const home_screen({
    super.key,
    // required this.timeZone
  });

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  UserViewModel userViewModel = UserViewModel();
  final isFilteredList = ValueNotifier<bool>(true);
  int selectedIndex = -1;
  int indexValue = -1;
  String? uId;
  UserModel? userModel;
  int unReadItem = 0;
  // final _focusScopeNode = FocusScopeNode();
  final _globalKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _rentalKey = GlobalKey();
  final GlobalKey _packageKey = GlobalKey();
  List<Map<String, dynamic>> images = [
    {'image': carImage1},
    {'image': carImage2},
    {'image': carImage3},
    {'image': carImage4},
    {'image': carImage5},
    {'image': carImage6},
    {'image': carImage7},
    {'image': carImage8},
    {'image': carImage9},
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userViewModel.getUserId().then((value) async {
      setState(() {
        if (value.userId != null && value.userId != '') {
          uId = value.userId.toString();
          userModel = value;
        }
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getUser();
      getNotification();
    });
  }

  getUser() async {
    await Future.delayed(const Duration(seconds: 2), () {
      Provider.of<DriverProfileViewModel>(context, listen: false)
          .fetchDriverDetailViewModelApi(
              context, {"driverId": uId}, uId.toString());

      Provider.of<DriverGetBookingListViewModel>(context, listen: false)
          .fetchDriverGetBookingListViewModel({
        "driverId": uId,
        "pageNumber": "0",
        "pageSize": "5",
        "bookingStatus": "BOOKED"
      }, context);
      Provider.of<DriverPackageViewModel>(context, listen: false)
          .getPackageBookingList(
        context: context,
      );
    });
  }

  void getNotification() {
    Provider.of<NotificationViewModel>(context, listen: false)
        .getAllNotificationList(
            context: context,
            userId: uId ?? '',
            pageNumber: 0,
            pageSize: 100,
            readStatus: 'FALSE');
  }

  String selectedSection = 'rental';
  @override
  Widget build(BuildContext context) {
    var userName =
        context.watch<DriverProfileViewModel>().DataList.data?.data.firstName ??
            '';
    var userLastName =
        context.watch<DriverProfileViewModel>().DataList.data?.data.lastName ??
            '';
    var email =
        context.watch<DriverProfileViewModel>().DataList.data?.data.email ?? '';
    String status =
        context.watch<DriverProfileViewModel>().DataList.status.toString();
    var driverAddress = context
            .watch<DriverProfileViewModel>()
            .DataList
            .data
            ?.data
            .driverAddress ??
        '';
    String? userimage = context
        .watch<DriverProfileViewModel>()
        .DataList
        .data
        ?.data
        .profileImageUrl;
    String rentalStatus = context
        .watch<DriverGetBookingDetailsViewModel>()
        .DataList
        .status
        .toString();
    // String lastLogin = context
    //         .watch<DriverProfileViewModel>()
    //         .DataList
    //         .data
    //         ?.data
    //         .lastLogin
    //         .toString() ??
    //     '';

    print("DriverId here at homeScreen $status");
    return WillPopScope(
      // canPop: false,
      onWillPop: () async {
        bool shouldExit = await showDialog(
          context: context,
          builder: (context) => exitContainer(),
        );
        return shouldExit ?? false;
        // return await showDialog(context: context, builder: (context) =>
        //     exitContainer());
      },
      child: Scaffold(
        backgroundColor: appBarbgcolor,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          toolbarHeight: 140,
          title: const Text(
            'Hi',
            style: TextStyle(color: background),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.notes_rounded,
                  size: 26,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context)
                      .openDrawer(); // Use the context from Builder
                },
              );
            },
          ),
        
          titleSpacing: 0,

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  horizontalTitleGap: 10,
                  dense: true,
                  leading: (userimage ?? '').isNotEmpty
                      ? CircleAvatar(
                          backgroundImage: Image.network(userimage ?? '').image,
                          radius: 25,
                        )
                      : const CircleAvatar(
                          radius: 25,
                          child: Icon(Icons.person, size: 24),
                        ),
                  title: Text(
                    '$userName $userLastName',
                    style: const TextStyle(color: background, fontSize: 20),
                  ),
                  subtitle: Text(
                    email,
                    style: const TextStyle(color: background, fontSize: 14),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Text(
                //     '$userName $userLastName',
                //     style: const TextStyle(color: background, fontSize: 24),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Text(
                //     email,
                //     style: const TextStyle(color: background, fontSize: 14),
                //   ),
                // ),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: btnColor,
                      ),
                      Expanded(
                        child: Text(
                          driverAddress,
                          style: const TextStyle(color: btnColor, fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Consumer<NotificationViewModel>(
              builder: (context, value, child) {
                unReadItem = value.totalUnreadNotification ?? 0;
                return InkWell(
                  onTap: () {
                    Provider.of<NotificationViewModel>(context, listen: false)
                        .updateNotification(context: context, userId: uId ?? '')
                        .then((onValue) {
                      getNotification();
                    });
                  },
                  child: Badge(
                    backgroundColor: greenColor,
                    isLabelVisible: unReadItem == 0 ? false : true,
                    label: Text(unReadItem.toString()),
                    child: const Icon(
                      Icons.notifications_none_outlined,
                      size: 30,
                      color: background,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 10)
          ],
        ),
        drawer: Drawer(
            elevation: 2,
            backgroundColor: bgGreyColor,
            child: MenuList(
              userId: uId ?? '',
            )),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: background,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                // decoration: const BoxDecoration(color: background),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.dashboard,
                          color: btnColor,
                        ),
                        Text(
                          'Dashboard',
                          style: appbarTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              // setState(() {
                              //   selectedSection =
                              //       'rental'; // Set to rental section
                              // });

                              Scrollable.ensureVisible(
                                _rentalKey.currentContext!,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                alignment: 0.5,
                              );
                            },
                            icon: Column(
                              children: [
                                Image.asset(
                                  carRental,
                                  height: 24,
                                  // color: bgGreyColor,
                                ),
                                Text(
                                  'Rental',
                                  style: detailstextTextStyle,
                                )
                              ],
                            )),
                        IconButton(
                            onPressed: () {
                              Scrollable.ensureVisible(
                                _packageKey.currentContext!,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                alignment: 0.5,
                              );
                              // FocusScope.of(context)
                              //     .requestFocus(_focusScopeNode);
                              // Scrollable.ensureVisible(context,
                              //     duration: Duration(milliseconds: 500),
                              //     alignment: 0.5,
                              //     curve: Curves.ease);
                              // setState(() {
                              //   selectedSection =
                              //       'package'; // Set to rental section
                              // });
                            },
                            icon: Column(
                              children: [
                                Image.asset(
                                  holidays,
                                  height: 24,
                                  // color: bgGreyColor,
                                ),
                                Text(
                                  'Package',
                                  style: detailstextTextStyle,
                                )
                              ],
                            ))
                      ],
                    )
                  
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        key: _rentalKey,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Rental Bookings',
                              style: appbarTextStyle1,
                            ),
                            TextButton(
                                onPressed: () {
                                  context.push("/historyManagement",
                                      extra: {"myID": uId}).then((onValue) {
                                    Provider.of<DriverGetBookingListViewModel>(
                                            context,
                                            listen: false)
                                        .fetchDriverGetBookingListViewModel({
                                      "driverId": uId,
                                      "pageNumber": "0",
                                      "pageSize": "5",
                                      "bookingStatus": "BOOKED"
                                    }, context);
                                    Provider.of<DriverPackageViewModel>(context,
                                            listen: false)
                                        .getPackageBookingList(
                                      context: context,
                                    );
                                  });
                                },
                                child: const Text(
                                  'View All',
                                  style: TextStyle(
                                      color: greenColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Consumer<DriverGetBookingListViewModel>(
                          builder: (context, viewModel, child) {
                            final response = viewModel.DataList;

                            if (response.status.toString() ==
                                    "Status.loading" ||
                                status == "Status.loading") {
                              return const SpinKitFadingCube(
                                color: btnColor,
                                size: 70,
                              );
                            } else if (response.status.toString() ==
                                "Status.completed") {
                              final data = response.data?.data.content ?? [];

                              if (data.isEmpty) {
                                // return const Center(child: Text('No Data Available'));
                                return Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: bgGreyColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        'No booking available',
                                        style: GoogleFonts.lato(
                                          fontSize: 15,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ));
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final item = data[index];
                                  return HistoryDetailsContainer(
                                    loader: rentalStatus == "Status.loading" &&
                                        selectedIndex == index,
                                    onTapContainer: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                      Provider.of<DriverGetBookingDetailsViewModel>(
                                              context,
                                              listen: false)
                                          .fetchDriverGetBookingDetailsViewModel(
                                              {
                                            "id": item.id.toString(),
                                          },
                                              context,
                                              item.id.toString(),
                                              uId ?? '');
                                    },
                                    bookingId: item.id ?? '',
                                    carImage: item.vehicle?.images ?? [],
                                    seat: item.vehicle?.seats?.toString() ?? "",
                                    fuelType:
                                        item.vehicle?.fuelType?.toString() ??
                                            "",
                                    carName:
                                        item.vehicle?.carName.toString() ?? "",
                                    status: item.bookingStatus == 'ON_RUNNING'
                                        ? 'ONGOING'
                                        : item.bookingStatus.toString(),
                                    date: item.date?.toString() ?? "",
                                    // rentalCharge:
                                    //     item.rentalCharge?.toString() ?? "",
                                  );
                                },
                              );
                            }
      
                            return Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: bgGreyColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                  child: Text('No booking available',
                                      style: TextStyle(
                                          color: redColor,
                                          fontWeight: FontWeight.w600))),
                            );
                          },
                        ),
                      ),
                    
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        key: _packageKey,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              key: _globalKey,
                              'Recent Package Bookings',
                              style: appbarTextStyle1,
                            ),
                            TextButton(
                                onPressed: () {
                                  context
                                      .push('/packageBookingManagement')
                                      .then((onValue) {
                                    Provider.of<DriverGetBookingListViewModel>(
                                            context,
                                            listen: false)
                                        .fetchDriverGetBookingListViewModel({
                                      "driverId": uId,
                                      "pageNumber": "0",
                                      "pageSize": "5",
                                      "bookingStatus": "BOOKED"
                                    }, context);
                                    Provider.of<DriverPackageViewModel>(context,
                                            listen: false)
                                        .getPackageBookingList(
                                      context: context,
                                    );
                                  });
                                },
                                child: const Text(
                                  'View All',
                                  style: TextStyle(
                                      color: greenColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        ),
                      ),

                      Consumer<DriverPackageViewModel>(
                        builder: (context, viewData, child) {
                          // if (viewData.isLoading) {
                          //   return const Center(
                          //       child: CircularProgressIndicator(
                          //     color: Colors.green,
                          //   ));
                          // } else
                          if (viewData.driverPackageBookingListModel == null ||
                              viewData.driverPackageBookingListModel!.data
                                  .isEmpty) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 200,
                              decoration: BoxDecoration(
                                  color: bgGreyColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                  child: Text(
                                // 'Currently, you have no bookings assigned. Stay tuned for new bookings',
                                'No booking available',
                                style: TextStyle(
                                    color: redColor,
                                    fontWeight: FontWeight.w600),
                              )),
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: viewData
                                  .driverPackageBookingListModel?.data.length,
                              itemBuilder: (context, index) {
                                var package = viewData
                                    .driverPackageBookingListModel!.data[index];
                                var activity = package.activityList
                                    .map((e) => e.activityName)
                                    .toList();
                                debugPrint(
                                    'activityname...${package.activityList.length}');
                                return Custompackageviewpage(
                                  driverAssignId:
                                      package.driverAssignedId.toString(),
                                  date: package.date.toString(),
                                  pickUpLocation:
                                      package.pickupLocation ?? 'N/A',
                                  activityName: activity.join(','),
                                  daySatus: package.dayStatus.toString(),
                                  pickupTime: package.pickupTime ?? 'N/A',
                                  loader: viewData.isLoading1 &&
                                      indexValue == index,
                                  onTap: viewData.isLoading
                                      ? null
                                      : () {
                                          setState(() {
                                            // viewData.isLoading = true;
                                            indexValue = index;
                                          });
                                          Provider.of<DriverPackageViewModel>(
                                                  context,
                                                  listen: false)
                                              .getPackageDetailList(
                                                  context: context,
                                                  driverAssignId:
                                                      package.driverAssignedId);
                                          // setState(() {
                                          //   viewData.isLoading = false;
                                          // });
                                          if (viewData.isLoading1) {
                                            context.push('/packageDetailPage',
                                                extra: {
                                                  "bookingId": package
                                                      .packageBookingId
                                                      .toString(),
                                                  "driverId": package.driverId
                                                      .toString()
                                                }).then((onValue) {
                                              debugPrint(
                                                  'object.........updated');
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                Provider.of<DriverPackageViewModel>(
                                                        context,
                                                        listen: false)
                                                    .getPackageBookingList(
                                                  context: context,
                                                );
                                              });
                                            });
                                          }
                                        },
                                );
                              },
                            );
                          }
                        },
                      ),
                    
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Exit Container Dialog Box
  Widget exitContainer() {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              Text(
                'Are you sure want to exit ?',
                style: pageHeadingTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonSmall(
                    width: 70,
                    height: 40,
                    btnHeading: "NO",
                    onTap: () {
                      context.pop();
                    },
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  CustomButtonSmall(
                    width: 70,
                    height: 40,
                    btnHeading: "YES",
                    onTap: () {
                      exit(0);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
