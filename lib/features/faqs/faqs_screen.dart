import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/features/settings/view_model/settings_provider.dart';
import 'package:provider/provider.dart';

/*
*  Date 27 - Feb-2024
*  Author: Raheel Khan- Abaska Technologies
*  Description: FAQScreen
*/

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  void initState() {
    super.initState();

    //add postframe callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getFAQs();
    });
  }

  _getFAQs() {
    Provider.of<SettingsProvider>(context, listen: false)
        .getFAQs(AppLocalizations.of(context)!.localeName);
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
        title: Text(l10n.faq,
            style: const TextStyle(color: AppColors.primaryColor)),
      ),
      body: settingsProvider.getIsLoading
          ? const SizedBox()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //expansion tile

                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: settingsProvider.allFAQs.faqsResponse!.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        onExpansionChanged: (value) {

                          settingsProvider.setFAQExpansionTileStatus(
                              index, value);
                        },
                        expandedAlignment: Alignment.centerLeft,
                        iconColor: AppColors.primaryColor,
                        title: Container(
                            color: Colors.white,
                            child: Text(
                                settingsProvider
                                    .allFAQs.faqsResponse![index].question!,
                                style: const TextStyle(
                                    color: AppColors.primaryColor))),
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(settingsProvider
                                  .allFAQs.faqsResponse![index].answer!)),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
