import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/view_model/locale_provider.dart';
import 'package:labees/features/home/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

/*
*  Date 24 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: ChooseLanguageScreen
*/


class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context);

    final localeProvider = context.read<LocaleProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.bgImage),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          color: const Color(0xFF00354E).withOpacity(0.77),
          width: double.maxFinite,
          height: double.maxFinite,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _offsetAnimation,
                child: Hero(
                  tag: 'labeesAr',
                  child: SvgPicture.asset(
                    Images.labeesAr,
                  ),
                ),
              ),
              SlideTransition(
                position: _offsetAnimation,
                child: Hero(
                  tag: 'labeesEn',
                  child: SvgPicture.asset(
                    Images.labeesEn,
                  ),
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).choose_language,
                    style: const TextStyle(
                      fontFamily: 'Libre Baskerville',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    l10n.letsGetStarted,
                    style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {

                          localeProvider.changeLocale(const Locale('en'));
                          await localeProvider.saveChooseLanguageShown();

                          if(mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                        ),
                        child: const Text('English'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {

                          localeProvider.changeLocale(const Locale('ar'));
                          await localeProvider.saveChooseLanguageShown();

                          if(mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }

                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          side: const BorderSide(
                            width: 1.0,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                        ),
                        child: const Text('العربیہ'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
