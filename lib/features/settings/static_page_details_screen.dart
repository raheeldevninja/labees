import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/features/settings/view_model/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as htmlDom;

/*
*  Date 02 - March-2024
*  Author: Raheel Khan- Abaska Technologies
*  Description: Static Page Details Screen
*/

class StaticPageDetailsScreen extends StatefulWidget {
  const StaticPageDetailsScreen({required this.slug, Key? key})
      : super(key: key);

  final String slug;

  @override
  State<StaticPageDetailsScreen> createState() =>
      _StaticPageDetailsScreenState();
}

class _StaticPageDetailsScreenState extends State<StaticPageDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final settingsProvider = context.read<SettingsProvider>();
      settingsProvider.getPageDetails(widget.slug, AppLocalizations.of(context)!.localeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settingsProvider = context.watch<SettingsProvider>();

    String htmlString = settingsProvider.pageDetailsResponse?.description ?? '';

    // Parse HTML
    final document = htmlParser.parse(htmlString);
    String parsedText = parseHtml(document);

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
        title: Text(
            settingsProvider.getIsLoading
                ? ''
                : settingsProvider.pageDetailsResponse?.name ?? '',
            style: const TextStyle(color: AppColors.primaryColor)),
      ),
      body: settingsProvider.getIsLoading
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),

                  //parse description html

                  Text(
                    parsedText,
                    style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }

  String parseHtml(htmlDom.Document document) {
    // Extract text content from the parsed HTML
    String textContent = '';

    if (document.body != null) {
      textContent = document.body!.text;
    }

    return textContent;
  }
}
