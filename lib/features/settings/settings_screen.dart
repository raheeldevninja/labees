import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/core/view_model/locale_provider.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/settings/contact_us_screen.dart';
import 'package:labees/features/settings/static_page_details_screen.dart';
import 'package:labees/features/settings/view_model/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isEnglishLangSelected = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final settingsProvider = context.read<SettingsProvider>();
      await settingsProvider.getFooterSettings(AppLocalizations.of(context)!.localeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeProvider = context.watch<LocaleProvider>();

    final homeProvider = context.read<HomeProvider>();
    final settingsProvider = context.watch<SettingsProvider>();

    _isEnglishLangSelected = l10n.localeName == 'en' ? true : false;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: AppColors.secondaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(l10n.settingsTitle,
            style: const TextStyle(color: AppColors.primaryColor)),
      ),
      body: settingsProvider.getIsLoading
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.language,
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),

                      //english arabic toggle button
                      Container(
                        width: 150,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.drawerIconBgColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                onTap: () async {


                                  setState(() {
                                    _isEnglishLangSelected = true;
                                  });

                                  localeProvider
                                      .changeLocale(const Locale('en'));
                                  await localeProvider
                                      .saveChooseLanguageShown();

                                  if (mounted) {

                                    _callApis(
                                        context, homeProvider, localeProvider);
                                  }
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: _isEnglishLangSelected
                                        ? AppColors.red
                                        : Colors.transparent,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'English',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: _isEnglishLangSelected
                                            ? Colors.white
                                            : AppColors.primaryColor),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                onTap: () async {



                                  setState(() {
                                    _isEnglishLangSelected = false;
                                  });

                                  localeProvider
                                      .changeLocale(const Locale('ar'));
                                  await localeProvider
                                      .saveChooseLanguageShown();

                                  if (mounted) {

                                    _callApis(
                                        context, homeProvider, localeProvider);
                                  }
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: _isEnglishLangSelected
                                        ? Colors.transparent
                                        : AppColors.red,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'العربیہ',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: _isEnglishLangSelected
                                            ? AppColors.primaryColor
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactUsScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.contactUs,
                              style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryColor,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),


                  const SizedBox(
                    height: 16,
                  ),

                  //listview for footer settings
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        settingsProvider.footerSettingsResponse.pages!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {

                          //print('footer settings: ${settingsProvider.footerSettingsResponse.pages![index].slug}');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StaticPageDetailsScreen(
                                  slug: settingsProvider
                                      .footerSettingsResponse
                                      .pages![index]
                                      .slug!),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  settingsProvider.footerSettingsResponse
                                      .pages![index].name!,
                                  style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.primaryColor,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.appVersion,
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                      const Text('0.0.1',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  void _callApis(BuildContext context, HomeProvider homeProvider,
      LocaleProvider localProvider) async {

    final settingsProvider = context.read<SettingsProvider>();

    if (homeProvider.getMainCategoriesList.categories != null) {
      int categoryId = homeProvider.getMainCategoriesList.categories!.first.id!;

      print('localeName: ${localProvider.appLocale.languageCode}');

      if (mounted) {
        await homeProvider.getDashboardData(context, false,
            localProvider.appLocale.languageCode, categoryId, 'all');
      }

      if (mounted) {
        await homeProvider.getMainCategories(
            context, localProvider.appLocale.languageCode);
      }

      await settingsProvider.getFooterSettings(AppLocalizations.of(context)!.localeName);

    }
  }
}
