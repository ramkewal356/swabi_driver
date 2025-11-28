import 'package:flutter/material.dart';
import 'package:flutter_driver/widgets/custom_page_layout.dart';
import 'package:flutter_driver/widgets/custom_tab_bar.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/view/dashboard/rental/booking_details_container.dart';
import 'package:flutter_driver/view_model/driver_rental_booking_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../data/response/status.dart';

class RentalBookingManagment extends StatefulWidget {
  const RentalBookingManagment({super.key});

  @override
  State<RentalBookingManagment> createState() => _RentalBookingManagmentState();
}

class _RentalBookingManagmentState extends State<RentalBookingManagment>
    with SingleTickerProviderStateMixin {
  List<String> tabList = ['BOOKED', 'ONGOING', 'COMPLETED', 'CANCELLED'];
  TabController? _tabController;
  // int initialIndex = 0;
  final ScrollController _scrollController = ScrollController();

  String status = 'BOOKED';
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabList.length, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPackageBooking(isFilter: true);
    });

    _scrollController.addListener(_onScroll);
  }

  void _onFilterChanged(int index) {
    setState(() {
      status = tabList[index] == 'ONGOING' ? "ON_RUNNING" : tabList[index];
      debugPrint('rental status,,,,,, $status');
    });
    getPackageBooking(isFilter: true);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      getPackageBooking(isPagination: true);
    }
  }

  Future<void> getPackageBooking(
      {bool isFilter = false, bool isPagination = false}) async {
    context
        .read<DriverRentalBookingViewModel>()
        .fetchDriverGetBookingListViewModel(
            isFilter: isFilter, isPagination: isPagination, filterText: status);
  }

  int? selectedIndex;
  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
        appBarTitle: 'Rental Management',
        onTap: () {
          context.go('/'); // ALWAYS go to dashboard
        },
        child: Customtabbar(
            controller: _tabController,
            tabs: tabList,
            onTap: _onFilterChanged,
            viewchildren: List.generate(tabList.length, (index) {
              return Consumer<DriverRentalBookingViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.bookingdataList.status == Status.loading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: greenColor,
                    ));
                  } else if (viewModel.bookingdataList.status == Status.error) {
                    return const Center(
                        child: Text(
                      'No data found',
                      style: TextStyle(
                          color: redColor, fontWeight: FontWeight.w500),
                    ));
                  } else if (viewModel.bookingdataList.status ==
                      Status.completed) {
                    final response = viewModel.bookingdataList;
                    final data = response.data ?? [];

                    if (data.isEmpty) {
                      // return const Center(child: Text('No Data Available'));
                      return Center(
                          child: Text(
                        'No data found',
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ));
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length + (viewModel.isLastPage ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index == data.length) {
                          return const Center(
                              child: CircularProgressIndicator());
                          // Hide if not loading
                        }
                        final item = data[index];
                        return BookingDetailsContainer(
                          loader: selectedIndex == index,
                          onTapContainer: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            context.push('/bookingDetails', extra: {
                              "bookingId": item.id.toString(),
                              "driverId": item.driver?.driverId.toString()
                            }).then((value) {
                              getPackageBooking(isFilter: true);
                              setState(() {
                                selectedIndex = null;
                              });
                            });
                          },
                          bookingId: item.id.toString(),
                          carImage: item.vehicle?.images ?? [],
                          seat: item.vehicle?.seats?.toString() ?? "",
                          fuelType: item.vehicle?.fuelType?.toString() ?? "",
                          carName: item.vehicle?.carName ?? "",
                          status: item.bookingStatus == 'ON_RUNNING'
                              ? 'ONGOING'
                              : item.bookingStatus.toString(),
                          date: item.date?.toString() ?? "",
                          // rentalCharge: item.rentalCharge?.toString() ?? "",
                        );
                      },
                    );
                  }

                  return const Center(child: Text('No data found'));
                },
              );
            })));
  }
}
