// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/widgets/custom_btn.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_driver/view_model/driver_profile_view_model.dart';
import 'package:flutter_driver/view_model/driver_rental_booking_view_model.dart';
import 'package:flutter_driver/view_model/driver_package_view_model.dart';
import 'package:flutter_driver/view_model/notification_view_model.dart';
import 'package:flutter_driver/data/response/status.dart';
import 'package:flutter_driver/view/dashboard/rental/booking_details_container.dart';
import 'package:flutter_driver/view/dashboard/package/custom_package_view_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _rentalKey = GlobalKey();
  final GlobalKey _packageKey = GlobalKey();

  int? selectedIndex;
  int indexValue = -1;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
      startNotificationPolling();
    });
  }

  void _loadData() {
    context.read<DriverProfileViewModel>().getDriverByIdApi();
    context
        .read<DriverRentalBookingViewModel>()
        .fetchDriverGetBookingListViewModel(
          isFilter: true,
          isPagination: false,
          filterText: 'BOOKED',
          pageNumer1: 0,
          pageSize1: 5,
        );

    context.read<DriverPackageViewModel>().getPackageBookingList();
  }

  void startNotificationPolling() {
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      fetchNotifications();
    });
  }

  void fetchNotifications() {
    context.read<NotificationViewModel>().getAllNotificationList(
          isPagination: false,
          isFilter: true,
          pageNumber1: -1,
          pageSize1: -1,
          readStatus: "FALSE",
        );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    var driverData =
        context.watch<DriverProfileViewModel>().getDriverDetails.data?.data;
    var status =
        context.watch<DriverProfileViewModel>().getDriverDetails.status;
    return Scaffold(
      backgroundColor: const Color(0xfff1f3f6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: _buildModernAppBar(driverData),
      ),
      body: status == Status.loading
          ? SpinKitFadingCircle(
              color: btnColor,
            )
          : _buildBody(),
    );
  }

  // ---------------------------- MODERN APP BAR ----------------------------

  Widget _buildModernAppBar(dynamic driverData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff8A0B23),
            Color(0xff81001E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildProfile(driverData),
          const SizedBox(width: 16),
          Expanded(child: _buildDriverInfo(driverData)),
          _buildNotificationButton(),
        ],
      ),
    );
  }

  Widget _buildProfile(dynamic driverData) {
    return CircleAvatar(
      radius: 28,
      backgroundColor: Colors.white,
      backgroundImage: (driverData?.profileImageUrl ?? "").isNotEmpty
          ? NetworkImage(driverData!.profileImageUrl!)
          : null,
      child: (driverData?.profileImageUrl ?? "").isEmpty
          ? const Icon(Icons.person, size: 30, color: Colors.grey)
          : null,
    );
  }

  Widget _buildDriverInfo(dynamic driverData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${driverData?.firstName ?? ''} ${driverData?.lastName ?? ''}",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          driverData?.email ?? "",
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationButton() {
    return Consumer<NotificationViewModel>(
      builder: (context, value, child) {
        return Stack(
          children: [
            IconButton(
              onPressed: () {
                _timer?.cancel();
                context.push('/notification').then((onValue) {
                  _loadData();
                  startNotificationPolling();
                });
              },
              icon: const Icon(Icons.notifications_none,
                  size: 30, color: Colors.white),
            ),
            if (value.totalUnreadNotification > 0)
              Positioned(
                right: 6,
                top: 8,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    value.totalUnreadNotification.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
          ],
        );
      },
    );
  }

  // ---------------------------- BODY ----------------------------

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          _buildStatsRow(),
          SizedBox(height: 15),
          _buildQuickActions(),
          const SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Recent Rental Bookings", () {
                    Scrollable.ensureVisible(_rentalKey.currentContext!,
                        duration: const Duration(milliseconds: 600));
                  }),
                  const SizedBox(height: 8),
                  Padding(
                    key: _rentalKey,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: _buildRentalList(),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionHeader("Recent Package Bookings", () {
                    Scrollable.ensureVisible(_rentalKey.currentContext!,
                        duration: const Duration(milliseconds: 600));
                  }),
                  const SizedBox(height: 8),
                  Padding(
                    key: _packageKey,
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: _buildPackageList(),
                  ),
                  const SizedBox(height: 25),
                  _buildRaiseIssueCard(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statCard("Today's Rides", "12", Colors.blue),
          SizedBox(width: 10),
          _statCard("Upcoming's Rides", "45", Colors.green),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        // margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color.withOpacity(0.15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87)),
            const SizedBox(height: 6),
            Text(value,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _quickAction(Icons.directions_car, "Go Online", Colors.indigo, () {
            // handle online
          }),
          _quickAction(Icons.history, "History", Colors.orange, () {
            context.push('/historyManagement');
          }),
          _quickAction(Icons.support_agent, "Support", Colors.red, () {
            context.push('/help&support');
          }),
        ],
      ),
    );
  }

  Widget _quickAction(
      IconData icon, String title, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 8),
          Text(title,
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildRaiseIssueCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.error_outline, color: Colors.red, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              "Having issues with rental or package booking?\nRaise a ticket now.",
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
          CustomButtonSmall(
            height: 40,
            width: 120,
            btnHeading: 'Raised Issue',
            onTap: () {
              context.push('/getRaiseIssue');
            },
          )
        ],
      ),
    );
  }

  // ---------------------------- SECTION HEADER ----------------------------
  Widget _buildSectionHeader(String title, VoidCallback onTapShortcut) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w600)),
          TextButton(
            onPressed: onTapShortcut,
            child:
                const Text("Scroll To", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  // ---------------------------- RENTAL LIST ----------------------------
  Widget _buildRentalList() {
    return Consumer<DriverRentalBookingViewModel>(
      builder: (context, viewModel, child) {
        final response = viewModel.bookingdataList;

        if (response.status == Status.loading) {
          return const Center(
              child: SpinKitCircle(color: Colors.blue, size: 50));
        }

        if (response.status == Status.completed) {
          final data = response.data ?? [];
          if (data.isEmpty) return _emptyCard();

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return BookingDetailsContainer(
                loader: selectedIndex == index,
                onTapContainer: () {
                  setState(() => selectedIndex = index);
                  context.push('/bookingDetails', extra: {
                    "bookingId": item.id.toString(),
                    "driverId": item.driver?.driverId.toString()
                  }).then((_) {
                    setState(() => selectedIndex = null);
                    _loadData();
                  });
                },
                bookingId: item.id.toString(),
                carImage: item.vehicle?.images ?? [],
                seat: item.vehicle?.seats.toString() ?? "",
                fuelType: item.vehicle?.fuelType.toString() ?? "",
                carName: item.vehicle?.carName ?? "",
                status: item.bookingStatus == "ON_RUNNING"
                    ? "ONGOING"
                    : item.bookingStatus.toString(),
                date: item.date.toString(),
              );
            },
          );
        }

        return _emptyCard();
      },
    );
  }

  // ---------------------------- PACKAGE LIST ----------------------------
  Widget _buildPackageList() {
    return Consumer<DriverPackageViewModel>(
      builder: (context, viewData, child) {
        final packages = viewData.packageBookingList.data?.data ?? [];

        if (packages.isEmpty) return _emptyCard();

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: packages.length,
          itemBuilder: (context, index) {
            var pkg = packages[index];
            var activity =
                pkg.activityList?.map((e) => e.activityName).join(", ");

            return CustomPackageViewPage(
              driverAssignId: pkg.driverAssignedId.toString(),
              date: pkg.date ?? "",
              pickUpLocation: pkg.pickupLocation ?? "N/A",
              activityName: activity ?? '',
              dayStatus: pkg.dayStatus ?? "",
              pickupTime: pkg.pickupTime ?? "N/A",
              loader: indexValue == index,
              onTap: () {
                context.push('/packageDetailPage', extra: {
                  "driverAssignedId": pkg.driverAssignedId.toString(),
                  "driverId": pkg.driverId.toString()
                }).then((_) => _loadData());
              },
            );
          },
        );
      },
    );
  }

  // ---------------------------- EMPTY CARD ----------------------------
  Widget _emptyCard() {
    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          "No bookings available",
          style: GoogleFonts.poppins(
            color: Colors.redAccent,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
