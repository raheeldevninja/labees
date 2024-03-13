import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/support_ticket/view_model/ticket_support_provider.dart';
import 'package:provider/provider.dart';

/*
*  Date 13 - March-2024
*  Author: Raheel Khan- Abaska Technologies
*  Description:
*/

class TicketSupportDetailsScreen extends StatefulWidget {
  const TicketSupportDetailsScreen({
    required this.id,
    super.key});

  final int id;

  @override
  State<TicketSupportDetailsScreen> createState() =>
      _TicketSupportDetailsScreenState();
}

class _TicketSupportDetailsScreenState extends State<TicketSupportDetailsScreen> {

  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //add postFrame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ticketSupportProvider =
          Provider.of<TicketSupportProvider>(context, listen: false);

      ticketSupportProvider.getTicketSupportDetails(context, widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ticketSupportProvider = Provider.of<TicketSupportProvider>(context);


    String status = '';
    final ticketSupportDetails = ticketSupportProvider.ticketSupportDetailsResponse?.ticket!;

    if (ticketSupportDetails?.status == '1') {
      status = l10n.receivedStatus;
    } else if (ticketSupportDetails?.status == '2') {
      status = l10n.assignedStatus;
    } else if (ticketSupportDetails?.status == '5') {
      status = l10n.cancelledStatus;
    }

    final date = DateTime.parse(ticketSupportDetails?.createdAt ?? '2000-00-23T03:26:25.000000Z');
    final formattedDate =
        '${Utils.monthNumToName(date.month)} ${date.day}, ${date.year}';


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
        title: Text(l10n.supportTicketTitle,
            style: const TextStyle(color: AppColors.primaryColor)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final ticketSupportProvider =
              Provider.of<TicketSupportProvider>(context, listen: false);

          ticketSupportProvider.getTicketSupportDetails(context, widget.id);
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            Container(
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
                        '${l10n.subscriptionDateLabel}: ',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                      Text(formattedDate,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          textAlign: TextAlign.center),

                      const Spacer(),

                      Text(
                        'ID: ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        ticketSupportDetails!.id.toString(),
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
                          child: Text(ticketSupportDetails!.subject!,
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
                          child: Text(ticketSupportDetails.type!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Expanded(
                        child: Text('Priority: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,),),),
                      Expanded(
                          flex: 3,
                          child: Text(ticketSupportDetails.priority!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        decoration: BoxDecoration(
                          color: ticketSupportDetails.status == '5'
                              ? Colors.red.withOpacity(0.1)
                              : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: ticketSupportDetails.status == '5'
                                  ? Colors.red
                                  : Colors.grey.withOpacity(0.3)),
                        ),
                        child: Text(status,
                            style: TextStyle(
                                color: ticketSupportDetails.status == '5'
                                    ? Colors.red
                                    : Colors.black,
                                fontSize: 12),
                            textAlign: TextAlign.center),
                      ),

                      //close ticket button
                      if (ticketSupportDetails.status == '1')
                        InkWell(
                          onTap: () async {

                            await ticketSupportProvider.closeTicketSupport(context, widget.id);
                            await ticketSupportProvider.getTicketSupportDetails(context, widget.id);

                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.red.withOpacity(0.3)),
                            ),
                            child: Text(l10n.closeTicketBtnText,
                                style: const TextStyle(color: Colors.red, fontSize: 12),
                                textAlign: TextAlign.center),
                          ),
                        ),


                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.customerSupportLabel,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),

                  //conversation listview
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ticketSupportProvider.ticketSupportDetailsResponse!.conversations!.length,
                    itemBuilder: (context, index) {

                      //if customer message is not null create a bubble on right
                      //if admin message is not null create a bubble on left

                      if (ticketSupportProvider.ticketSupportDetailsResponse!.conversations![index].customerMessage != null) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(ticketSupportProvider.ticketSupportDetailsResponse!.conversations![index].customerMessage!,
                                  style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(l10n.adminLabel,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),

                            const SizedBox(height: 10),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(ticketSupportProvider.ticketSupportDetailsResponse!.conversations![index].adminMessage ?? '',
                                  style: const TextStyle(color: Colors.black, fontSize: 16)),
                            ),
                          ],
                        );
                      }


                    },
                  ),



                  //message from customer bubble
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(ticketSupportDetails.description!,
                        style: const TextStyle(color: Colors.black, fontSize: 16)),
                  ),

                  //reply from admin
                  if (ticketSupportDetails.reply != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(l10n.adminLabel,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),

                        const SizedBox(height: 10),

                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(ticketSupportDetails.reply!,
                              style: const TextStyle(color: Colors.black, fontSize: 16)),
                        ),
                      ],
                    ),




                ],
              ),
            ),


            //write message


            if(ticketSupportDetails?.status != '5') ...[

              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: l10n.writeMessageHint,
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(backgroundColor: AppColors.primaryColor),
                      onPressed: () async {

                        await ticketSupportProvider.sendMessage(context, widget.id, _messageController.text.trim());

                        if(context.mounted) {
                          await ticketSupportProvider.getTicketSupportDetails(context, widget.id);
                        }

                        _messageController.clear();

                      },
                      icon: //send icon at angle
                      const Icon(Icons.send, color: Colors.white),
                    ),
                  ],
                ),
              ),

            ],



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
