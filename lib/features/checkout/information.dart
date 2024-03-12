import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/models/cities_data.dart';
import 'package:labees/core/models/countries_data.dart';
import 'package:labees/core/ui/widgets.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/auth/view_model/auth_provider.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/home/models/address_data.dart';
import 'package:labees/features/home/models/registeration_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 24 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: Information
*/

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();


  final _contactPersonNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _postalCodeController = TextEditingController();

  final _countrySearchController = TextEditingController();
  final _citySearchController = TextEditingController();

  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();

  final _contactPersonNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _postalCodeFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();


  CountriesData? selectedCountry;

  //String? selectedCountry;
  String? selectedCountryCode;

  //String? selectedCity;
  CitiesData? selectedCity;

  String? selectedAddressType;
  String? selectedState;
  int? selectedAddressId;

  String? selectedAddress;

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
          checkoutProvider.checkAddressesHaveBillingAddress()) {
        int billingAddressIndex =
            checkoutProvider.getFirstBillingAddressIndex();

        if (billingAddressIndex != -1) {
          setState(() {
            selectedAddressId = checkoutProvider
                .allAddresses!.addresses![billingAddressIndex].id;

            selectedAddress =
                '${checkoutProvider.allAddresses!.addresses![billingAddressIndex].phone!}, '
                '${checkoutProvider.allAddresses!.addresses![billingAddressIndex].contactPersonName!}, ${checkoutProvider.allAddresses!.addresses![billingAddressIndex].zip!}';
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final checkoutProvider = context.watch<CheckoutProvider>();
    final authProvider = context.watch<AuthProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          shrinkWrap: true,
          children: [
            Text(
              l10n.billingAddress,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Libre Baskerville',
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            if (checkoutProvider.allAddresses != null &&
                checkoutProvider.allAddresses!.addresses != null &&
                checkoutProvider.checkAddressesHaveBillingAddress()) ...[
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
                ),
              ),
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
                    l10n.addNewAddress,
                    style: const TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ),
            ],

            if (checkoutProvider.allAddresses?.addresses == null ||
                checkoutProvider.allAddresses!.addresses!.isEmpty ||
                !checkoutProvider.checkAddressesHaveBillingAddress() ||
                showAddressForm == true) ...[
              const SizedBox(
                height: 20,
              ),


              if(APIs.token.isEmpty) ...[

                Widgets.labels('${l10n.firstNameLabel} '),
                const SizedBox(
                  height: 10,
                ),
                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {});
                  },
                  child: TextFormField(
                    focusNode: _firstNameFocus,
                    controller: _firstNameController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: _firstNameFocus.hasFocus
                          ? Colors.white
                          : Colors.grey.withOpacity(0.1),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20.0),
                      hintText: l10n.firstNameHint,
                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.1), width: 1.0),
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
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Widgets.labels('${l10n.lastNameLabel} '),
                const SizedBox(
                  height: 10,
                ),
                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {});
                  },
                  child: TextFormField(
                    controller: _lastNameController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: _lastNameFocus.hasFocus
                          ? Colors.white
                          : Colors.grey.withOpacity(0.1),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20),
                      hintText: l10n.lastNameHint,
                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.1), width: 1.0),
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
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),


                Widgets.labels('${l10n.emailLabel} '),

                const SizedBox(
                  height: 10,
                ),

                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {});
                  },
                  child: TextFormField(
                    focusNode: _emailFocus,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: _emailFocus.hasFocus
                          ? Colors.white
                          : Colors.grey.withOpacity(0.1),
                      contentPadding: const EdgeInsets.all(12.0),
                      hintText: l10n.emailHint,
                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.1), width: 1.0),
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
                        return 'Please enter your email';
                      }
                      // You can add more sophisticated email validation if needed
                      if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),

              ],

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
                    contentPadding: const EdgeInsets.all(12.0),
                    hintText: l10n.contactPersonNameHint,
                    hintStyle:
                        const TextStyle(fontSize: 14, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.1), width: 1.0),
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
                      return 'Please enter contact person name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Widgets.labels('${l10n.phoneNumberLabel} '),
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
                            hintText: l10n.phoneLabel,
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

              ///cities and postal code
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
                hint: Text(l10n.addressTypeHint),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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

              Widgets.labels('${l10n.address} '),
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
                    hintText: 'Enter your address',
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



              if(APIs.token.isEmpty) ...[

                const SizedBox(
                  height: 20,
                ),
                Widgets.labels(l10n.createPasswordLabel),
                const SizedBox(
                  height: 10,
                ),
                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {});
                  },
                  child: TextFormField(
                    focusNode: _passwordFocus,
                    controller: _passwordController,
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: _passwordFocus.hasFocus
                          ? Colors.white
                          : Colors.grey.withOpacity(0.1),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20),
                      hintText: l10n.createPasswordHint,
                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.1), width: 1.0),
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
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Widgets.labels('${l10n.confirmPassword} '),
                const SizedBox(
                  height: 10,
                ),
                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {});
                  },
                  child: TextFormField(
                    focusNode: _confirmPasswordFocus,
                    controller: _confirmPasswordController,
                    obscureText: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: _confirmPasswordFocus.hasFocus
                          ? Colors.white
                          : Colors.grey.withOpacity(0.1),
                      contentPadding: const EdgeInsets.all(12.0),
                      hintText: l10n.confirmPasswordHint,
                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.1), width: 1.0),
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
                        return 'Please enter your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),

              ],












              ///hide form button

              // if (checkoutProvider.allAddresses?.addresses == null ||
              //     checkoutProvider.allAddresses!.addresses!.isEmpty) ...[
              //   Row(
              //     mainAxisAlignment: l10n.localeName == 'en'
              //         ? MainAxisAlignment.start
              //         : MainAxisAlignment.end,
              //     children: [
              //       TextButton(
              //         onPressed: () {
              //           _clearForm();
              //
              //           setState(() {
              //             showAddressForm = false;
              //           });
              //         },
              //         child: const Text('Hide Form'),
              //       ),
              //     ],
              //   ),
              // ],

            ],

            const SizedBox(
              height: 20,
            ),

            ///continue to shipping button
            SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (checkoutProvider.allAddresses?.addresses == null ||
                      checkoutProvider.allAddresses!.addresses!.isEmpty ||
                      !checkoutProvider.checkAddressesHaveBillingAddress() ||
                      showAddressForm) {
                    if (selectedCity == null) {
                      Utils.showCustomSnackBar(context, 'Please select city');
                      return;
                    }

                    if(selectedAddressType == null || selectedAddressType!.isEmpty){
                      Utils.showCustomSnackBar(context, 'Please select address type');
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
                        isBilling: 1,
                      );

                      if(APIs.token.isEmpty){
                        await authProvider.register(context, RegistrationData(
                          fName: _firstNameController.text.trim(),
                          lName: _lastNameController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          phone: _phoneController.text.trim(),
                        ));
                      }

                      await checkoutProvider.addAddress(context, addressModel);

                      //set billing address id
                      checkoutProvider.setBillingAddressId(
                          checkoutProvider.addAddressResponse!.addressId);

                      await checkoutProvider.getAllAddresses();

                      Utils.pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    }
                  } else {
                    if (selectedAddress == null) {
                      Utils.showCustomSnackBar(context, 'Please select address');
                      return;
                    }

                    checkoutProvider.setBillingAddressId(selectedAddressId!);
                    print('billing addr id: $selectedAddressId');

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
                  l10n.continueToShippingBtnText,
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
                    if (checkoutProvider
                            .allAddresses!.addresses![index].isBilling ==
                        0) {
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

    _firstNameController.dispose();
    _lastNameController.dispose();

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

    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();

  }
}
