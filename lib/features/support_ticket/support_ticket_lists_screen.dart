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
  State<TicketSupportListsScreen> createState() => _TicketSupportListsScreenState();
}

class _TicketSupportListsScreenState extends State<TicketSupportListsScreen> {

  @override
  void initState() {
    super.initState();

    //add postFrame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {

      final ticketSupportProvider = Provider.of<TicketSupportProvider>(context, listen: false);
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [

          //header
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [


                Expanded(child: Text('ID', style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center,)),
                Expanded(child: Text('Topic', style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center)),
                Expanded(flex: 2, child: Text('Sub Date', style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center)),
                Expanded(flex: 2, child: Text('Type', style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center)),
                Expanded(child: Text('Status', style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center)),
                Expanded(flex: 2, child: Text('Action', style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center)),


              ],
            ),
          ),

          const SizedBox(height: 10),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ticketSupportProvider.ticketSupportLists!.length,
              itemBuilder: (context, index) {

                String status = '';

                if(ticketSupportProvider.ticketSupportLists![index].status! == '1') {
                  status = 'Received';
                }
                else if(ticketSupportProvider.ticketSupportLists![index].status! == '2') {
                  status = 'Assigned';
                }
                else if(ticketSupportProvider.ticketSupportLists![index].status! == '5') {
                  status = 'Cancelled';
                }

                final date = DateTime.parse(ticketSupportProvider.ticketSupportLists![index].createdAt!);
                final formattedDate =
                    '${Utils.monthNumToName(date.month)} ${date.day}, ${date.year}';


                return Container(
                  //padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: index == ticketSupportProvider.ticketSupportLists!.length-1 ? null : Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [

                      Expanded(child: Text(ticketSupportProvider.ticketSupportLists![index].id.toString(), style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center,)),
                      Expanded(child: Text(ticketSupportProvider.ticketSupportLists![index].subject!, style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center)),
                      Expanded(flex: 2, child: Text(formattedDate, style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center)),
                      Expanded(flex: 2, child: Text(ticketSupportProvider.ticketSupportLists![index].type!, style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center)),
                      Expanded(child: Text(status, style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center)),
                      Expanded(
                        flex: 1,
                          child: Column(
                        children: [

                          //delete icon
                          IconButton(
                            onPressed: () {
                              //delete ticket
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),

                          //view icon
                          IconButton(
                            onPressed: () {
                              //view ticket
                            },
                            icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                          ),

                        ],
                      )),

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
    );
  }

  @override
  dispose() {

    super.dispose();
  }

}
