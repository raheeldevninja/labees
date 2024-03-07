import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/models/address_data.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/add_address_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/*
*  Date 18 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: AddressesList
*/

class AddressesList extends StatelessWidget {

  const AddressesList({
    Key? key,
    required this.myAddresses,
  }) : super(key: key);

  final List<AddressData> myAddresses;

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;
    final checkoutProvider = Provider.of<CheckoutProvider>(context);


    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: myAddresses.length,
      itemBuilder: (context, index) {

        final isDefault = myAddresses[index].isDefault == 1;

        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(
              width: isDefault ? 2 : 1,
              color: isDefault ? AppColors.primaryColor : AppColors.borderColor,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                width: 60,
                height: 60,
                Images.selectedLocation,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${myAddresses[index].addressType!} ${l10n.addressLabel} (${myAddresses[index].isBilling == 1 ? l10n.billingLabel : l10n.shippingLabel})',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Libre Baskerville',
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${l10n.addressLabel}: ',
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Libre Baskerville',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            myAddresses[index].address!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Libre Baskerville',
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${l10n.phoneLabel}: ',
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Libre Baskerville',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            myAddresses[index].phone!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Libre Baskerville',
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    ///edit and delete button
                    Row(
                      children: [

                        InkWell(
                          onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddAddressScreen(addressData: myAddresses[index],),
                              ),
                            );


                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  Images.editIcon,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  l10n.editAddressBtn,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Libre Baskerville',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        isDefault ? const SizedBox() : InkWell(
                          onTap: () async {
                            bool? res = await _showDeleteConfirmationDialog(context, l10n);

                            if(res == true){
                              await checkoutProvider.deleteAddress(myAddresses[index].id!);
                              await checkoutProvider.getAllAddresses();
                            }

                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  Images.deleteIcon,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  l10n.deleteAddressBtn,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Libre Baskerville',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    //default address
                    !isDefault ? InkWell(
                      onTap: () async {
                        await checkoutProvider.updateDefaultAddress(myAddresses[index].id!);
                        await checkoutProvider.getAllAddresses();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          l10n.setAsDefaultBtnText,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Libre Baskerville',
                          ),
                        ),
                      ),
                    ) : const SizedBox(),

                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///delete confirmation dialog
  Future<bool?> _showDeleteConfirmationDialog(BuildContext context, AppLocalizations l10n) {

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        return AlertDialog(
          title: Text(l10n.deleteAddressTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(l10n.deleteAddressConfirmation),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.yesBtnText),
              onPressed: () {

                Navigator.of(context).pop(true);

              },
            ),
            TextButton(
              child: Text(l10n.noBtnText),
              onPressed: () {

                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

}
