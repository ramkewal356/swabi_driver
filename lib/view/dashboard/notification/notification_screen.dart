import 'package:flutter/material.dart';

import 'package:flutter_driver/data/models/get_all_notification_model.dart'
    hide Status;
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/common/styles/text_styles.dart';
import 'package:flutter_driver/view_model/notification_view_model.dart';
import 'package:flutter_driver/widgets/custom_btn.dart';
import 'package:flutter_driver/widgets/custom_page_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../data/response/status.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateNotification();
      getNotification();
    });
    _scrollController.addListener(_onScroll);
  }

  void updateNotification() {
    context.read<NotificationViewModel>().updateNotificationApi();
  }

  void getNotification({bool isPagination = false}) {
    context.read<NotificationViewModel>().getAllNotificationList(
        isFilter: true, isPagination: isPagination, readStatus: 'all');
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      getNotification(isPagination: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
        appBarTitle: 'Notification',
        actionIcon: IconButton(
            onPressed: () {
              _showClearNotificationModal(context);
            },
            icon: Icon(
              Icons.clear_all,
              color: background,
            )),
        child: Consumer<NotificationViewModel>(
            builder: (context, value, snapshot) {
          if (value.notificationList.status == Status.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: greenColor,
              ),
            );
          } else if (value.notificationList.status == Status.completed) {
            final notifications = value.notificationList.data ?? [];

            List<Content> todayNotification = [];
            List<Content> earlierNotification = [];

            final now = DateTime.now();
            final todayStart = DateTime(now.year, now.month, now.day);

            for (var item in notifications) {
              final createdDate =
                  DateTime.fromMillisecondsSinceEpoch(item.createdDate ?? 0);

              if (createdDate.isAfter(todayStart)) {
                todayNotification.add(item);
              } else {
                earlierNotification.add(item);
              }
            }
            return notifications.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'No Notification Available',
                        style: TextStyle(
                            color: redColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (todayNotification.isNotEmpty)
                            Text(
                              'Taday',
                              style: titleTextStyle,
                            ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: todayNotification.length,
                            itemBuilder: (context, index) {
                              return NotificationContainer(
                                title: todayNotification[index].title ?? '',
                                subTitle:
                                    todayNotification[index].message ?? '',
                                time: todayNotification[index].createdDate ?? 0,
                              );
                            },
                          ),
                          if (earlierNotification.isNotEmpty)
                            Text(
                              'Earlier',
                              style: titleTextStyle,
                            ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: earlierNotification.length,
                            itemBuilder: (context, index) {
                              return NotificationContainer(
                                title: earlierNotification[index].title ?? '',
                                subTitle:
                                    earlierNotification[index].message ?? '',
                                time:
                                    earlierNotification[index].createdDate ?? 0,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
          } else {
            return Center(
              child: Text('No Data found'),
            );
          }
        }));
  }

  void _showClearNotificationModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(
            "Clear All Notifications?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("Are you sure you want to clear all notifications?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
            ),
            CustomButtonSmall(
              btnHeading: 'Clear',
              loading: context
                      .watch<NotificationViewModel>()
                      .clearNotification
                      .status ==
                  Status.loading,
              height: 40,
              width: 100,
              borderRadius: 35,
              onTap: () async {
                Navigator.pop(context);

                await context
                    .read<NotificationViewModel>()
                    .clearAllNotificationApi();

                // Refresh the list
                getNotification();
              },
            )
          ],
        );
      },
    );
  }
}

class NotificationContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final int time;
  const NotificationContainer(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: background,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: ListTile(
            dense: true,
            minLeadingWidth: 30,
            horizontalTitleGap: 10,
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            leading: const Stack(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: btnColor,
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 10,
                    child: SizedBox(
                      width: 15,
                      height: 15,
                      child: CircleAvatar(
                        backgroundColor: btnColor,
                      ),
                    ))
              ],
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  // overflow: TextOverflow.ellipsis,
                ),
                Text(
                  formatTimeAgo(time),
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            subtitle: Text(
              subTitle,
              style: GoogleFonts.lato(
                  color: greyColor, fontSize: 12, fontWeight: FontWeight.w600),
              // overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  String formatTimeAgo(int dateTime) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
      dateTime,
    );
    debugPrint('timeeee$date');
    Duration difference = DateTime.now().difference(date);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} sec${difference.inSeconds > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      return '${(difference.inDays / 7).floor()} week${(difference.inDays / 7).floor() > 1 ? 's' : ''} ago';
    }
  }
}
