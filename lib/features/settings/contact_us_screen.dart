import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/models/countries_data.dart';
import 'package:labees/core/ui/simple_button.dart';
import 'package:labees/core/ui/widgets.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/settings/model/contact_store_data.dart';
import 'package:labees/features/settings/view_model/settings_provider.dart';
import 'package:provider/provider.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedTypesOfInquiry;
  final List<String> typesOfInquiry = [
    'Delivery',
    'Order',
    'Amber',
    'Return/Cancel order',
    'Product and Stock Information',
    'Website & Account',
    'Other Inquiry',
    'Wardrobe Inspiration',
    'Gift Inspiration',
    'Price Match'
  ];

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  final _emailFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _subjectFocus = FocusNode();
  final _messageFocus = FocusNode();

  CountriesData? selectedCountry;
  String? selectedCountryCode;

  @override
  void initState() {
    super.initState();

    selectedTypesOfInquiry = typesOfInquiry[0];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsProvider>().getCompanySettings();
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
        title: Text(l10n.contactUsTitle,
            style: const TextStyle(color: AppColors.primaryColor)),
      ),
      body: settingsProvider.getIsLoading
          ? const SizedBox()
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                  Widgets.labels('${l10n.typeOfInquiry} '),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedTypesOfInquiry,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.1), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.1), width: 1.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    items: typesOfInquiry.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTypesOfInquiry = value;
                      });
                    },
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
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: _emailFocus.hasFocus
                            ? Colors.white
                            : Colors.grey.withOpacity(0.1),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 20),
                        hintText: l10n.emailHint,
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
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Widgets.labels('${l10n.nameLabel} '),
                  const SizedBox(
                    height: 10,
                  ),
                  Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {});
                    },
                    child: TextFormField(
                      focusNode: _nameFocus,
                      controller: _nameController,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: _nameFocus.hasFocus
                            ? Colors.white
                            : Colors.grey.withOpacity(0.1),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 20),
                        hintText: l10n.nameHint,
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
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
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
                          color: Colors.grey.withOpacity(0.1),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _showCountryBottomSheet(context, l10n,
                                      showCountryCode: true);
                                });
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
                              maxLines: 1,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: _phoneFocus.hasFocus
                                    ? Colors.white
                                    : Colors.grey.withOpacity(0.1),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 20),
                                hintText: l10n.mobileHint,
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.1),
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Widgets.labels('${l10n.subject} '),
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
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: _subjectFocus.hasFocus
                            ? Colors.white
                            : Colors.grey.withOpacity(0.1),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 20),
                        hintText: l10n.subjectHint,
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
                          return 'Please enter subject';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Widgets.labels('${l10n.writeMessageLabel} '),
                  const SizedBox(
                    height: 10,
                  ),
                  Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {});
                    },
                    child: TextFormField(
                      focusNode: _messageFocus,
                      controller: _messageController,
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: _messageFocus.hasFocus
                            ? Colors.white
                            : Colors.grey.withOpacity(0.1),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 20),
                        hintText: l10n.writeMessageHint,
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
                          return 'Please enter message';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  ///send button
                  SizedBox(
                    height: 44,
                    child: SimpleButton(
                      text: l10n.sendBtnText,
                      callback: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          int inquiryTypeNo =
                              typesOfInquiry.indexOf(selectedTypesOfInquiry!);

                          ContactStoreData contactStoreData = ContactStoreData(
                            inquiryType: inquiryTypeNo + 1,
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            subject: _subjectController.text.trim(),
                            message: _messageController.text.trim(),
                            mobileNumber:
                                '$selectedCountryCode-${_phoneController.text.trim()}',
                          );

                          await settingsProvider.contactUs(
                              context, contactStoreData);
                        }
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.contactDetails,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: AppColors.primaryColor,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.phoneCall,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    settingsProvider
                                        .companySettingsResponse.companyPhone!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            const Icon(
                              Icons.email,
                              color: AppColors.primaryColor,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.emailLabel,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  settingsProvider
                                      .companySettingsResponse.companyEmail!,
                                ),
                              ],
                            ),
                          ]),
                        ]),
                  ),
                ],
              ),
            ),
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

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: checkoutProvider.countriesData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                              '${showCountryCode ? '${checkoutProvider.countriesData[index].phoneCode} - ' : ''} ${checkoutProvider.countriesData[index].name!}'),
                          onTap: () {
                            if (mounted) {
                              Navigator.pop(context);
                            }

                            selectedCountry =
                                checkoutProvider.countriesData[index];
                            selectedCountryCode =
                                checkoutProvider.countriesData[index].phoneCode;

                            setState(() {});
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
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _messageController.dispose();

    _emailFocus.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _subjectFocus.dispose();
    _messageFocus.dispose();
  }
}
