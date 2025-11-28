import 'package:flutter/material.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/view/dashboard/rental/booking_details_container.dart';
import 'package:flutter_driver/view_model/driver_rental_booking_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../data/response/status.dart';

class HistoryRentalBookingScreen extends StatefulWidget {
  const HistoryRentalBookingScreen({super.key});

  @override
  State<HistoryRentalBookingScreen> createState() =>
      _HistoryRentalBookingScreenState();
}

class _HistoryRentalBookingScreenState
    extends State<HistoryRentalBookingScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPackageBooking();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      getPackageBooking(isPagination: true);
    }
  }

  Future<void> getPackageBooking({bool isPagination = false}) async {
    context
        .read<DriverRentalBookingViewModel>()
        .fetchDriverGetBookingListViewModel(
            isFilter: true, isPagination: isPagination, filterText: 'ALL');
  }

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
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
            style: TextStyle(color: redColor, fontWeight: FontWeight.w500),
          ));
        } else if (viewModel.bookingdataList.status == Status.completed) {
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: data.length + (viewModel.isLastPage ? 0 : 1),
              itemBuilder: (context, index) {
                if (index == data.length) {
                  return const Center(child: CircularProgressIndicator());
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
                      getPackageBooking();
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
            ),
          );
        }

        return const Center(child: Text('No data found'));
      },
    );
  }
}
