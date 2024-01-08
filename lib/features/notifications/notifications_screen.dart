import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/features/notifications/model/notification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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

    _initNotificationsList();
  }

  _initNotificationsList() {
    _notificationsList.add(NotificationModel(
        title: 'Lorem ipsum ',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
        time: '5:26 pm',
        date: '1/24/2023'));
    _notificationsList.add(NotificationModel(
        title: 'Lorem ipsum ',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
        time: '5:26 pm',
        date: '1/24/2023'));
    _notificationsList.add(NotificationModel(
        title: 'Lorem ipsum ',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
        time: '5:26 pm',
        date: '1/24/2023'));
    _notificationsList.add(NotificationModel(
        title: 'Lorem ipsum ',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
        time: '5:26 pm',
        date: '1/24/2023'));
    _notificationsList.add(NotificationModel(
        title: 'Lorem ipsum ',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
        time: '5:26 pm',
        date: '1/24/2023'));
    _notificationsList.add(NotificationModel(
        title: 'Lorem ipsum ',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
        time: '5:26 pm',
        date: '1/24/2023'));
    _notificationsList.add(NotificationModel(
        title: 'Lorem ipsum ',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
        time: '5:26 pm',
        date: '1/24/2023'));
    _notificationsList.add(NotificationModel(
        title: 'Lorem ipsum ',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
        time: '5:26 pm',
        date: '1/24/2023'));
    _notificationsList.add(NotificationModel(
        title: 'Lorem ipsum ',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
        time: '5:26 pm',
        date: '1/24/2023'));
    _notificationsList.add(NotificationModel(
        title: 'Lorem ipsum ',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
        time: '5:26 pm',
        date: '1/24/2023'));
    _notificationsList.add(NotificationModel(
        title: 'Lorem ipsum ',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
        time: '5:26 pm',
        date: '1/24/2023'));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

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
      body: Column(
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
            child: Center(
              child: Text(
                l10n.noNotifications,
              ),
            ),
          ),

          // Expanded(
          //   child: ListView.builder(
          //     itemCount: _notificationsList.length,op
          //     shrinkWrap: true,
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 12,
          //     ),
          //     itemBuilder: (context, index) {
          //       return Container(
          //         padding: EdgeInsets.all(16),
          //         margin: EdgeInsets.all(4),
          //         decoration: BoxDecoration(
          //           color: Colors.grey.withOpacity(0.1),
          //           borderRadius: const BorderRadius.all(
          //             Radius.circular(12),
          //           ),
          //         ),
          //         child: Row(
          //           children: [
          //             Expanded(
          //               flex: 4,
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     _notificationsList[index].title,
          //                     style: const TextStyle(
          //                       fontSize: 16,
          //                       color: AppColors.primaryColor,
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 4,
          //                   ),
          //                   Text(
          //                     _notificationsList[index].description,
          //                     style: const TextStyle(
          //                       fontSize: 12,
          //                       color: AppColors.primaryColor,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             Expanded(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.end,
          //                 children: [
          //                   Text(
          //                     _notificationsList[index].time,
          //                     style: const TextStyle(
          //                       fontSize: 12,
          //                       color: AppColors.primaryColor,
          //                     ),
          //                   ),
          //                   const SizedBox(
          //                     height: 4,
          //                   ),
          //                   Text(
          //                     _notificationsList[index].date,
          //                     style: const TextStyle(
          //                       fontSize: 10,
          //                       color: AppColors.primaryColor,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
