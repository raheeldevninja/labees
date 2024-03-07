import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/add_address_screen.dart';
import 'package:labees/features/home/pages/account_page/widgets/addresses_list.dart';
import 'package:labees/features/home/pages/account_page/widgets/no_address_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 10 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: MyAddressTab
*/


class MyAddressTab extends StatefulWidget {
  const MyAddressTab({Key? key}) : super(key: key);

  @override
  State<MyAddressTab> createState() => _MyAddressTabState();
}

class _MyAddressTabState extends State<MyAddressTab> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;
    final checkoutProvider = Provider.of<CheckoutProvider>(context);

    if(checkoutProvider.allAddresses == null) {
      checkoutProvider.getAllAddresses();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await checkoutProvider.getAllAddresses();
      },
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.myAddresses,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Libre Baskerville',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          checkoutProvider.allAddresses != null && checkoutProvider.allAddresses!.addresses!.isEmpty
              ? const NoAddressWidget()
              : AddressesList(myAddresses: checkoutProvider.allAddresses!.addresses!),

          const SizedBox(height: 40,),

          InkWell(
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddAddressScreen(),
                ),
              );

            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    Images.addIcon,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  l10n.addNewAddress,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

