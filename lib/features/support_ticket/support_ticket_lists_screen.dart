import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/ui/simple_button.dart';
import 'package:labees/core/ui/widgets.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/support_ticket/model/ticket_support_data.dart';
import 'package:labees/features/support_ticket/support_ticket_screen.dart';
import 'package:labees/features/support_ticket/view_model/ticket_support_provider.dart';
import 'package:provider/provider.dart';

/*
*  Date 8 - March-2024
*  Author: Raheel Khan- Abaska Technologies
*  Description:
*/

class TicketSupportListsScreen extends StatefulWidget {
  const TicketSupportListsScreen({super.key});

  @override
  State<TicketSupportListsScreen> createState() =>
      _TicketSupportListsScreenState();
}

class _TicketSupportListsScreenState extends State<TicketSupportListsScreen> {
  @override
  void initState() {
    super.initState();

    //add postFrame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ticketSupportProvider =
          Provider.of<TicketSupportProvider>(context, listen: false);
      ticketSupportProvider.getTicketSupportList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ticketSupportProvider = Provider.of<TicketSupportProvider>(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(l10n.supportTicketsTitle,
            style: const TextStyle(color: AppColors.primaryColor)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final ticketSupportProvider =
              Provider.of<TicketSupportProvider>(context, listen: false);
          ticketSupportProvider.getTicketSupportList();
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ticketSupportProvider.ticketSupportLists!.length,
                itemBuilder: (context, index) {
                  String status = '';
                  final ticketSupportItem =
                      ticketSupportProvider.ticketSupportLists![index];

                  if (ticketSupportItem.status! == '1') {
                    status = 'Received';
                  } else if (ticketSupportItem.status! == '2') {
                    status = 'Assigned';
                  } else if (ticketSupportItem.status! == '5') {
                    status = 'Cancelled';
                  }

                  final date = DateTime.parse(ticketSupportItem.createdAt!);
                  final formattedDate =
                      '${Utils.monthNumToName(date.month)} ${date.day}, ${date.year}';

                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Subscription Date: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            ),
                            Text(formattedDate,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                textAlign: TextAlign.center),
                            Spacer(),
                            Text(
                              'ID: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              ticketSupportItem.id.toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Expanded(
                                child: Text(
                              'Topic: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                            Expanded(
                                flex: 3,
                                child: Text(ticketSupportItem.subject!,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16))),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Expanded(
                                child: Text('Type: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                                flex: 3,
                                child: Text(ticketSupportItem.type!,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16))),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              decoration: BoxDecoration(
                                color: ticketSupportItem.status == '5'
                                    ? Colors.red.withOpacity(0.1)
                                    : Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: ticketSupportItem.status == '5'
                                        ? Colors.red
                                        : Colors.grey.withOpacity(0.3)),
                              ),
                              child: Text(status,
                                  style: TextStyle(
                                      color: ticketSupportItem.status == '5'
                                          ? Colors.red
                                          : Colors.black,
                                      fontSize: 12),
                                  textAlign: TextAlign.center),
                            ),

                            const Spacer(),

                            //view icon
                            IconButton(
                              onPressed: () {
                                //view ticket
                              },
                              icon: const Icon(Icons.remove_red_eye,
                                  color: Colors.blue),
                            ),

                            //delete icon
                            IconButton(
                              onPressed: () {
                                //delete ticket
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),

            ///submit new ticket button
            SizedBox(
              width: double.maxFinite,
              height: 50,
              child: SimpleButton(
                text: l10n.submitTicketBtnText,
                callback: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SupportTicketScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  @override
  dispose() {
    super.dispose();
  }
}
