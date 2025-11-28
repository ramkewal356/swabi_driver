import 'package:flutter/material.dart';
import 'package:flutter_driver/data/response/status.dart';
import 'package:flutter_driver/widgets/custom_page_layout.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/view_model/raise_issue_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IssueViewDetails extends StatefulWidget {
  final String issueId;
  const IssueViewDetails({super.key, required this.issueId});

  @override
  State<IssueViewDetails> createState() => _IssueViewDetailsState();
}

class _IssueViewDetailsState extends State<IssueViewDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      getIssueDetails();
    });
  }

  void getIssueDetails() {
    context
        .read<RaiseIssueViewModel>()
        .getRaiseIssueDetailsApi(issueId: widget.issueId);
  }

  @override
  Widget build(BuildContext context) {
    var issueData =
        context.watch<RaiseIssueViewModel>().getIssueDetail.data?.data;
    var status = context.watch<RaiseIssueViewModel>().getIssueDetail.status;
    return CustomPageLayout(
      appBarTitle: 'Issue Details',
      child: status == Status.loading
          ? const Center(
              child: CircularProgressIndicator(
              color: greenColor,
            ))
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  /// 🔹 Status Card
                  Card(
                    color: background,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Status",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          _statusBadge(issueData?.issueStatus ?? "OPEN"),
                        ],
                      ),
                    ),
                  ),
            
                  const SizedBox(height: 12),

                  /// 🔹 Issue Information
                  Card(
                    color: background,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoTile(Icons.confirmation_number, "Issue ID",
                              issueData?.issueId.toString() ?? ''),
                          _infoTile(Icons.assignment, "Booking ID",
                              issueData?.bookingId.toString() ?? ''),
                          _infoTile(
                              Icons.calendar_today,
                              "Created Date",
                              DateFormat('dd-MM-yyyy').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      issueData?.createdDate ?? 0))),
                          _infoTile(
                            Icons.directions_car,
                            "Booking Type",
                            issueData?.bookingType == 'PACKAGE_BOOKING'
                                ? "Package Booking"
                                : "Rental Booking",
                          ),
                          _infoTile(Icons.description, "Issue Description",
                              issueData?.issueDescription ?? ''),
                        ],
                      ),
                    ),
                  ),
            
                  const SizedBox(height: 12),

                  /// 🔹 Resolution (if available)
                  if (issueData?.resolutionDescription != null &&
                      issueData?.resolutionDescription!.isNotEmpty)
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Resolution",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            const Divider(),
                            Text(
                              issueData?.resolutionDescription ?? '',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  /// 🔹 Info Row with Icon
  Widget _infoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: btnColor),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "$label: ",
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87),
                children: [
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Status Badge
  Widget _statusBadge(String status) {
    Color bgColor;
    switch (status) {
      case "OPEN":
        bgColor = Colors.redAccent;
        break;
      case "IN_PROGRESS":
        bgColor = Colors.orangeAccent;
        break;
      default:
        bgColor = Colors.green;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: bgColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: bgColor, width: 1),
      ),
      child: Text(
        status == "IN_PROGRESS" ? "In Progress" : status,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: bgColor,
        ),
      ),
    );
  }
}
