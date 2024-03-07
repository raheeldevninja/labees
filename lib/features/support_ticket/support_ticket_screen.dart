import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/ui/simple_button.dart';
import 'package:labees/core/ui/widgets.dart';
import 'package:labees/features/settings/view_model/settings_provider.dart';
import 'package:provider/provider.dart';

/*
*  Date 5 - March-2024
*  Author: Raheel Khan- Abaska Technologies
*  Description: SupportTicketScreen
*/

class SupportTicketScreen extends StatefulWidget {
  const SupportTicketScreen({super.key});

  @override
  State<SupportTicketScreen> createState() => _SupportTicketScreenState();
}

class _SupportTicketScreenState extends State<SupportTicketScreen> {

  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> types = [
    'Website Problem',
    'Payment Request',
    'Complaint',
    'Info Inquiry',
  ];

  String selectedType = 'Website Problem';

  final List<String> priority = [
    'Urgent',
    'High',
    'Medium',
    'Low',
  ];

  String selectedPriority = 'Urgent';


  final FocusNode _subjectFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    //add postFrame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });

  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settingsProvider = Provider.of<SettingsProvider>(context);


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
        title: Text(l10n.supportTicket,
            style: const TextStyle(color: AppColors.primaryColor)),
      ),
      body: settingsProvider.getIsLoading ? const SizedBox() :
      ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [

          Text(
            l10n.submitTicket,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Libre Baskerville',
            ),
          ),

          const SizedBox(height: 40),


          Widgets.labels('${l10n.subjectLabel} '),
          const SizedBox(
            height: 10,
          ),

          Focus(
            onFocusChange: (hasFocus) {
              setState(() {});
            },
            child: TextFormField(
              focusNode: _subjectFocus,
              controller: _subjectController,
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: _subjectFocus.hasFocus
                    ? Colors.white
                    : Colors.grey.withOpacity(0.1),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                hintText: l10n.subjectHint,
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: AppColors.primaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Widgets.labels('${l10n.typeLabel} '),
          const SizedBox(
            height: 10,
          ),

          ///type drop down
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              underline: const SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              value: selectedType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue!;
                });
              },
              items: types.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),


          const SizedBox(height: 20),

          Widgets.labels('${l10n.priorityLabel} '),
          const SizedBox(
            height: 10,
          ),

          ///priority drop down
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              underline: const SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              value: selectedPriority,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPriority = newValue!;
                });
              },
              items: priority.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),


          const SizedBox(height: 20),

          Widgets.labels('${l10n.issueDescLabel} '),
          const SizedBox(
            height: 10,
          ),

          Focus(
            onFocusChange: (hasFocus) {
              setState(() {});
            },
            child: TextFormField(
              focusNode: _descriptionFocus,
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                fillColor: _subjectFocus.hasFocus
                    ? Colors.white
                    : Colors.grey.withOpacity(0.1),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                hintText: l10n.issueDescHint,
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: AppColors.primaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          ///submit ticket button
          SizedBox(
            width: double.maxFinite,
            height: 50,
            child: SimpleButton(
              text: l10n.submitTicketBtnText,
              callback: () async {

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
    _subjectController.dispose();
    _descriptionController.dispose();

    _subjectFocus.dispose();
    _descriptionFocus.dispose();

    super.dispose();
  }

}
