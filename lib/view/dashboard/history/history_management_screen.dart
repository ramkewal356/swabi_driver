import 'package:flutter/material.dart';
import 'package:flutter_driver/view/dashboard/rental/history_rental_booking_screen.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/view/dashboard/package/history_package_booking_screen.dart';
import 'package:flutter_driver/widgets/custom_page_layout.dart';

class HistoryManagementScreen extends StatefulWidget {
  const HistoryManagementScreen({super.key});

  @override
  State<HistoryManagementScreen> createState() =>
      _HistoryManagementScreenState();
}

class _HistoryManagementScreenState extends State<HistoryManagementScreen>
    with TickerProviderStateMixin {
  int intialIndex = 0;
  int hoveredIndex = -1;
  TabController? _tabcontroller;
  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 2, vsync: this);

    _tabcontroller?.addListener(() {
      setState(() {
        intialIndex = _tabcontroller?.index ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _tabcontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
      appBarTitle: 'History Management',
      child: Column(
        children: [
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                // ignore: deprecated_member_use
                border: Border.all(color: naturalGreyColor.withOpacity(0.3)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: TabBar(
              controller: _tabcontroller,
              onTap: (value) {
                setState(() {
                  intialIndex = value;
                });

                debugPrint("valueIndex $intialIndex");
              },
              unselectedLabelColor: Colors.black87,
              labelColor: Colors.black,
              indicatorWeight: 2.5,
              indicatorColor: buttonColor,
              dividerColor: Colors.transparent,
              indicatorPadding: const EdgeInsets.only(left: 10, right: 10),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(
                  child: Text(
                    'Rental',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                Tab(
                  child: Text(
                    'Package',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabcontroller, children: const [
              HistoryRentalBookingScreen(),
              HistoryPackagebooking()
            ]),
          ),
        ],
      ),
    );
  }
}
