import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/models/cities_data.dart';
import 'package:labees/core/models/countries_data.dart';
import 'package:labees/core/ui/widgets.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/home/models/address_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 24 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: ShippingAddress
*/

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({Key? key}) : super(key: key);

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _contactPersonNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _postalCodeController = TextEditingController();

  final _countrySearchController = TextEditingController();
  final _citySearchController = TextEditingController();

  final _contactPersonNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _postalCodeFocus = FocusNode();

  CountriesData? selectedCountry;
  //String? selectedCountry;
  String? selectedCountryCode;
  //String? selectedCity;
  CitiesData? selectedCity;

  String? selectedAddressType;
  String? selectedState;

  String? selectedAddress;
  int? selectedAddressId;

  bool shippingAddress = false;

  bool showAddressForm = false;

  final List<String> addressTypes = [
    'Permanent',
    'Home',
    'Office',
    'Others',
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final checkoutProvider =
          Provider.of<CheckoutProvider>(context, listen: false);

      if (checkoutProvider.allAddresses != null &&
          checkoutProvider.allAddresses!.addresses != null &&
          checkoutProvider.checkAddressesHaveShippingAddress()) {
        int shippingAddressIndex =
            checkoutProvider.getFirstShippingAddressIndex();

        if (shippingAddressIndex != -1) {
          setState(() {
            selectedAddressId = checkoutProvider
                .allAddresses!.addresses![shippingAddressIndex].id;

            selectedAddress =
                '${checkoutProvider.allAddresses!.addresses![shippingAddressIndex].phone!}, '
                '${checkoutProvider.allAddresses!.addresses![shippingAddressIndex].contactPersonName!}, ${checkoutProvider.allAddresses!.addresses![shippingAddressIndex].zip!}';
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final checkoutProvider = context.watch<CheckoutProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          shrinkWrap: true,
          children: [
            Text(
              l10n.shippingAddressHeading,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Libre Baskerville',
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            if (checkoutProvider.allAddresses!.addresses != null &&
                checkoutProvider.checkAddressesHaveShippingAddress()) ...[
              Widgets.labels('${l10n.existingAddresses} ', isRequired: true),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(32.0),
                onTap: () {
                  _showAddressesBottomSheet(context, l10n);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Text(
                        selectedAddress ?? l10n.selectAddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                l10n.orLabel,
                style: const TextStyle(fontSize: 20),
              )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showAddressForm = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
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
                    l10n.addNewAddressBtnText,
                    style: const TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ),
            ],

            if (checkoutProvider.allAddresses!.addresses == null ||
                checkoutProvider.allAddresses!.addresses!.isEmpty ||
                !checkoutProvider.checkAddressesHaveShippingAddress() ||
                showAddressForm == true) ...[
              const SizedBox(
                height: 20,
              ),

              Widgets.labels('${l10n.contactPersonName} '),
              const SizedBox(
                height: 10,
              ),
              Focus(
                onFocusChange: (hasFocus) {
                  setState(() {});
                },
                child: TextFormField(
                  focusNode: _contactPersonNameFocus,
                  controller: _contactPersonNameController,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: _contactPersonNameFocus.hasFocus
                        ? Colors.white
                        : Colors.grey.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20),
                    hintText: l10n.contactPersonNameHint,
                    hintStyle:
                        const TextStyle(fontSize: 14, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.pleaseEnterContactPersonName;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Widgets.labels('${l10n.phoneLabel} '),
              const SizedBox(
                height: 10,
              ),
              Focus(
                onFocusChange: (hasFocus) {
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _phoneFocus.hasFocus
                        ? Colors.white
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: const BoxDecoration(),
                        child: InkWell(
                          onTap: () {
                            _showCountryBottomSheet(context, l10n,
                                showCountryCode: true);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                selectedCountryCode ?? '- -',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                      // Text Form Field
                      Expanded(
                        child: TextFormField(
                          focusNode: _phoneFocus,
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: l10n.phoneNumberHint,
                            border: InputBorder.none,
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //countries
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.labels('${l10n.countryLabel} ',
                            isRequired: true),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(32.0),
                          onTap: () {
                            _showCountryBottomSheet(context, l10n);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(32.0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                    child: Text(
                                  selectedCountry?.name ?? l10n.selectCountry,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),

                        /*DropdownButtonFormField<CountriesData>(
                        isExpanded: true,
                        value: selectedCountry,
                        hint: const Text('Select'),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            //vertical: 12,
                            horizontal: 6,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        items: checkoutProvider.countriesData.map((CountriesData item) {
                          return DropdownMenuItem<CountriesData>(
                            value: item,
                            child: Text(item.name!),
                          );
                        }).toList(),
                        onChanged: (value) async {

                          await checkoutProvider.getCities(value!.id!);

                          setState(() {
                            selectedCountry = value;
                            selectedCity = null;
                          });


                        },
                      ),*/
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              //cities and postal code
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.labels('${l10n.cityLabel} ', isRequired: true),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(32.0),
                          onTap: () {
                            if (checkoutProvider.cities == null) {
                              Fluttertoast.showToast(
                                  msg: 'Please select country first');
                              return;
                            }

                            if (checkoutProvider.cities!.data!.isEmpty) {
                              Fluttertoast.showToast(msg: 'Cities not found');
                              return;
                            }

                            _showCityBottomSheet(context, l10n);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(32.0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                    child: Text(
                                  selectedCity?.name ?? l10n.selectCity,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),

                        /*DropdownButtonFormField<CitiesData>(
                        value: selectedCity,
                        isExpanded: true,
                        hint: const Text('Select'),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        items: checkoutProvider.cities != null ? checkoutProvider.cities?.data?.map((CitiesData item) {
                          return DropdownMenuItem<CitiesData>(
                            value: item,
                            child: Text(item.name!),
                          );
                        }).toList() : [],
                        onChanged: (value) {
                          setState(() {
                            selectedCity = value;
                          });
                        },
                      ),*/
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.labels('${l10n.postalCodeLabel} ',
                            isRequired: true),
                        const SizedBox(
                          height: 10,
                        ),
                        Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {});
                          },
                          child: TextFormField(
                            focusNode: _postalCodeFocus,
                            controller: _postalCodeController,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: _postalCodeFocus.hasFocus
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.1),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 20),
                              hintText: l10n.postalCodeLabel,
                              hintStyle: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.primaryColor, width: 1.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return l10n.pleaseEnterPostalCode;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              Widgets.labels('${l10n.addressType} '),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: selectedAddressType,
                hint: const Text('Select Address Type'),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                items: addressTypes.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAddressType = value;
                  });
                },
              ),

              const SizedBox(
                height: 20,
              ),

              Widgets.labels('${l10n.addressLabel} '),
              const SizedBox(
                height: 10,
              ),
              Focus(
                onFocusChange: (hasFocus) {
                  setState(() {});
                },
                child: TextFormField(
                  focusNode: _addressFocus,
                  controller: _addressController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: _addressFocus.hasFocus
                        ? Colors.white
                        : Colors.grey.withOpacity(0.1),
                    contentPadding: const EdgeInsets.all(12.0),
                    hintText: l10n.addressHint,
                    hintStyle:
                        const TextStyle(fontSize: 14, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.pleaseEnterAddress;
                    }
                    return null;
                  },
                ),
              ),

              ///hide form button

              if (checkoutProvider.allAddresses!.addresses == null ||
                  checkoutProvider.allAddresses!.addresses!.isEmpty) ...[
                Row(
                  mainAxisAlignment: l10n.localeName == 'en'
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _clearForm();

                        setState(() {
                          showAddressForm = false;
                        });
                      },
                      child: const Text('Hide Form'),
                    ),
                  ],
                ),
              ],
            ],

            const SizedBox(
              height: 20,
            ),

            ///continue to payment button
            SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (checkoutProvider.allAddresses?.addresses == null ||
                      !checkoutProvider.checkAddressesHaveShippingAddress() ||
                      checkoutProvider.allAddresses!.addresses!.isEmpty ||
                      showAddressForm) {
                    if (selectedCity == null) {
                      Utils.toast('Please select city');
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      AddressModel addressModel = AddressModel(
                        contactPersonName:
                            _contactPersonNameController.text.trim(),
                        phone: _phoneController.text,
                        phoneCode: selectedCountry!.phoneCode!,
                        country: selectedCountry!.id!,
                        address: _addressController.text.trim(),
                        city: selectedCity!.id!,
                        zip: _postalCodeController.text.trim(),
                        addressType: selectedAddressType!,
                        isBilling: 0,
                      );

                      await checkoutProvider.addAddress(context, addressModel);

                      //set shipping address id
                      checkoutProvider.setShippingAddressId(
                          checkoutProvider.addAddressResponse!.addressId);

                      await checkoutProvider.getAllAddresses();

                      Utils.pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    }
                  } else {
                    if (selectedAddress == null) {
                      Utils.toast('Please select address');
                      return;
                    }

                    checkoutProvider.setShippingAddressId(selectedAddressId!);
                    print('shipping addr id: $selectedAddressId');

                    Utils.pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                ),
                child: Text(
                  l10n.continueToPayment,
                ),
              ),
            ),

            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  void _showCityBottomSheet(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        final checkoutProvider = context.watch<CheckoutProvider>();

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.selectCity,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _citySearchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: 'Search for a city',
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                onChanged: (value) {
                  checkoutProvider.searchCity(value);
                },
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: checkoutProvider.cities!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(checkoutProvider.cities!.data![index].name!),
                      onTap: () {
                        setState(() {
                          selectedCity = checkoutProvider.cities!.data![index];
                        });

                        // Handle city selection
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCountryBottomSheet(BuildContext context, AppLocalizations l10n,
      {bool showCountryCode = false}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        final checkoutProvider = context.watch<CheckoutProvider>();

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.selectCountry,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _countrySearchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: 'Search for a country',
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                onChanged: (value) {
                  checkoutProvider.searchCountry(value);
                },
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: checkoutProvider.countriesData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                          '${showCountryCode ? '${checkoutProvider.countriesData[index].phoneCode} - ' : ''} ${checkoutProvider.countriesData[index].name!}'),
                      onTap: () async {
                        await checkoutProvider.getCities(
                            checkoutProvider.countriesData[index].id!);

                        setState(() {
                          selectedCountry =
                              checkoutProvider.countriesData[index];
                          selectedCountryCode =
                              checkoutProvider.countriesData[index].phoneCode;
                          selectedCity = null;
                        });

                        if (mounted) {
                          // Handle city selection
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddressesBottomSheet(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        final checkoutProvider = context.watch<CheckoutProvider>();

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.selectAddress,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: checkoutProvider.allAddresses!.addresses!.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(
                        'is billing: ${checkoutProvider.allAddresses!.addresses![index].isBilling}');

                    if (checkoutProvider
                            .allAddresses!.addresses![index].isBilling ==
                        1) {
                      return const SizedBox();
                    }

                    return ListTile(
                      title: Text(
                          '${checkoutProvider.allAddresses!.addresses![index].phone!}, '
                          '${checkoutProvider.allAddresses!.addresses![index].contactPersonName!}, ${checkoutProvider.allAddresses!.addresses![index].zip!}'),
                      onTap: () {
                        setState(() {
                          selectedAddressId = checkoutProvider
                              .allAddresses!.addresses![index].id;

                          selectedAddress =
                              '${checkoutProvider.allAddresses!.addresses![index].phone!}, '
                              '${checkoutProvider.allAddresses!.addresses![index].contactPersonName!}, ${checkoutProvider.allAddresses!.addresses![index].zip!}';

                          showAddressForm = false;
                        });

                        _clearForm();

                        // Handle city selection
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _clearForm() {
    _contactPersonNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
    _postalCodeController.clear();

    selectedCountry = null;
    selectedCountryCode = null;
    selectedCity = null;
    selectedAddressType = null;

    selectedState = null;
  }

  @override
  void dispose() {
    super.dispose();

    _contactPersonNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _postalCodeController.dispose();

    _countrySearchController.dispose();
    _citySearchController.dispose();

    _contactPersonNameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _addressFocus.dispose();
    _postalCodeFocus.dispose();
  }
}
