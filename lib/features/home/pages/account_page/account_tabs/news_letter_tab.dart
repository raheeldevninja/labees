import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/models/user.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/view_model/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/*
*  Date 5 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: Add Address Screen
*/


class NewsLetterTab extends StatefulWidget {
  const NewsLetterTab({Key? key}) : super(key: key);

  @override
  State<NewsLetterTab> createState() => _NewsLetterTabState();
}

class _NewsLetterTabState extends State<NewsLetterTab> {

  User? user;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getUser();
    });

  }

  _getUser() async {
    user = await SharedPref.getUser();
    setState(() {

    });
  }



  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;
    final accountProvider = Provider.of<AccountProvider>(context);


    return RefreshIndicator(
      onRefresh: () async {
        await accountProvider.updateNewsletter(context, user!.newsletter!);
        _getUser();
      },
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.subscribeToNewsLetter,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Libre Baskerville',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            l10n.joinSubscriberList,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SvgPicture.asset(
            width: double.maxFinite,
            height: 170,
            Images.newsLetterImg,
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: /*SimpleButton(
                    text: l10n.yesBtnText,
                    callback: () {

                      SharedPref.getUser().then((value) {
                        String email = value!.email!;
                        accountProvider.newsLetter(context, email);
                      });

                    },

                  ),*/

                    ElevatedButton(
                      onPressed: () async {
                        await accountProvider.updateNewsletter(context, 1);
                        _getUser();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: user?.newsletter == 1 ? AppColors.primaryColor : Colors.white,
                        foregroundColor: user?.newsletter == 1 ? Colors.white : AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                      ),
                      child: Text(
                        l10n.yesBtnText,
                      ),
                    ),

                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: /*ElevatedButton(
                    onPressed: () {
                      accountProvider.updateNewsletter(context, 0);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      side: const BorderSide(
                        width: 1.0,
                        color: AppColors.primaryColor,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                    ),
                    child: Text(
                      l10n.noBtnText,
                      style: const TextStyle(color: AppColors.primaryColor),
                    ),
                  ),*/

                  ElevatedButton(
                    onPressed: () async {
                      await accountProvider.updateNewsletter(context, 2);
                      _getUser();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: user?.newsletter == 2 ? AppColors.primaryColor : Colors.white,
                      foregroundColor: user?.newsletter == 2 ? Colors.white : AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                    ),
                    child: Text(
                      l10n.noBtnText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
