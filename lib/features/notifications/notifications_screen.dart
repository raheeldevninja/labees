import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/notifications/model/notification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

/*
*  Date 18 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: NotificationsScreen
*/

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> _notificationsList = [];

  @override
  void initState() {
    super.initState();

    getNotifications();
  }

  getNotifications() {
    Provider.of<CheckoutProvider>(context, listen: false).getNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final checkoutProvider = Provider.of<CheckoutProvider>(context);

    final notifications = checkoutProvider.notifications;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(l10n.notifications,
            style: const TextStyle(color: AppColors.primaryColor)),
      ),
      body: checkoutProvider.getIsLoading
          ? const SizedBox()
          : RefreshIndicator(
              onRefresh: () async {
                await checkoutProvider.getNotifications(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                  //   child: InkWell(
                  //     onTap: () {},
                  //     child: Text(
                  //       'Mark all read',
                  //       style: TextStyle(
                  //           fontSize: 12, decoration: TextDecoration.underline),
                  //     ),
                  //   ),
                  // ),

                  Expanded(
                    child: notifications.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Text(
                                l10n.noNotifications,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: notifications.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            itemBuilder: (context, index) {
                              String timestamp = "2023-06-13T04:09:45.000000Z";
                              DateTime dateTime = DateTime.parse(timestamp);
                              String time =
                                  "${dateTime.hour < 10 ? 0 : ''}${dateTime.hour}:${dateTime.minute < 10 ? 0 : ''}${dateTime.minute}";

                              //format date
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(dateTime);

                              return Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            notifications[index].title!,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            notifications[index].description!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            time,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            formattedDate,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
