import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/models/countries_data.dart';
import 'package:labees/core/ui/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/seller/model/seller_registration_data.dart';
import 'package:labees/features/seller/view_model/seller_registration_provider.dart';
import 'package:provider/provider.dart';

class RegisterSellerScreen extends StatefulWidget {
  const RegisterSellerScreen({Key? key}) : super(key: key);

  @override
  State<RegisterSellerScreen> createState() => _RegisterSellerScreenState();
}

class _RegisterSellerScreenState extends State<RegisterSellerScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNoController = TextEditingController();

  final _shopNameController = TextEditingController();
  final _shopAddressController = TextEditingController();
  final _crIDNoController = TextEditingController();

  final _createPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _mobileNoFocus = FocusNode();

  final _shopNameFocus = FocusNode();
  final _shopAddressFocus = FocusNode();
  final _crIDNoFocus = FocusNode();

  final _createPasswordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  CountriesData? selectedCountry;
  String? selectedCountryCode;

  final ImagePicker picker = ImagePicker();

  String? selectedDocumentType;
  final List<String> commercialDocumentTypes = ['CR', 'Freelance'];

  @override
  void initState() {
    super.initState();

    selectedDocumentType = commercialDocumentTypes[0];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final sellerRegistrationProvider =
        Provider.of<SellerRegistrationProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          l10n.registerAsSellerTitle,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        primary: true,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),

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
                        vertical: 12.0, horizontal: 20),
                    hintText: l10n.firstNameHint,
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
                  focusNode: _lastNameFocus,
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
                    // You can add more sophisticated email validation if needed
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Widgets.labels('${l10n.mobileLabel} '),
              const SizedBox(
                height: 10,
              ),
              Focus(
                onFocusChange: (hasFocus) {
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _mobileNoFocus.hasFocus
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                          focusNode: _mobileNoFocus,
                          controller: _mobileNoController,
                          keyboardType: TextInputType.phone,
                          maxLines: 1,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: _mobileNoFocus.hasFocus
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
                                  color: AppColors.primaryColor, width: 1.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your mobile number';
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

              Widgets.labels('${l10n.shopNameLabel} '),
              const SizedBox(
                height: 10,
              ),
              Focus(
                onFocusChange: (hasFocus) {
                  setState(() {});
                },
                child: TextFormField(
                  focusNode: _shopNameFocus,
                  controller: _shopNameController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: _shopNameFocus.hasFocus
                        ? Colors.white
                        : Colors.grey.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20),
                    hintText: l10n.shopNameHint,
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
                      return 'Please enter your shop name';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Widgets.labels('${l10n.shopAddressLabel} '),
              const SizedBox(
                height: 10,
              ),
              Focus(
                onFocusChange: (hasFocus) {
                  setState(() {});
                },
                child: TextFormField(
                  focusNode: _shopAddressFocus,
                  controller: _shopAddressController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: _shopAddressFocus.hasFocus
                        ? Colors.white
                        : Colors.grey.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20),
                    hintText: l10n.shopAddressHint,
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
                      return 'Please enter your shop address';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Widgets.labels('${l10n.commercialDocumentLabel} '),
              const SizedBox(
                height: 10,
              ),
              //cr and freelance dropdown
              DropdownButtonFormField<String>(
                value: selectedDocumentType,
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
                items: commercialDocumentTypes.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDocumentType = value;
                  });
                },
              ),

              const SizedBox(
                height: 20,
              ),

              Widgets.labels('${l10n.crNoLabel} '),
              const SizedBox(
                height: 10,
              ),
              Focus(
                onFocusChange: (hasFocus) {
                  setState(() {});
                },
                child: TextFormField(
                  focusNode: _crIDNoFocus,
                  controller: _crIDNoController,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: _crIDNoFocus.hasFocus
                        ? Colors.white
                        : Colors.grey.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20),
                    hintText: l10n.crNoHint,
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
                      return 'Please enter your CR ID No';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Widgets.labels('${l10n.uploadCRFreelanceDoc} '),
              const SizedBox(
                height: 10,
              ),

              //cr freelance document picker
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg', 'pdf', 'doc'],
                  );

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    sellerRegistrationProvider
                        .setCRFreelanceDocFile(File(file.path!));
                  } else {
                    // User canceled the picker
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.upload_file,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          sellerRegistrationProvider.getCRFreelanceDocFile ==
                                  null
                              ? l10n.uploadFile
                              : sellerRegistrationProvider
                                  .getCRFreelanceDocFile!.path
                                  .split('/')
                                  .last,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Widgets.labels('${l10n.uploadLogo} '),
              const SizedBox(
                height: 10,
              ),

              //logo picker
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg', 'pdf', 'doc'],
                  );

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    sellerRegistrationProvider.setLogoFile(File(file.path!));
                  } else {
                    // User canceled the picker
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.upload_file,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          sellerRegistrationProvider.getLogoFile == null
                              ? l10n.uploadFile
                              : sellerRegistrationProvider.getLogoFile!.path
                                  .split('/')
                                  .last,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Widgets.labels('${l10n.uploadBanner} '),
              const SizedBox(
                height: 10,
              ),

              //banner picker
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg', 'pdf', 'doc'],
                  );

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    sellerRegistrationProvider.setBannerFile(File(file.path!));
                  } else {
                    // User canceled the picker
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.upload_file,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          sellerRegistrationProvider.getBannerFile == null
                              ? l10n.uploadFile
                              : sellerRegistrationProvider.getBannerFile!.path
                                  .split('/')
                                  .last,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Widgets.labels('${l10n.additionalLegalDocument} '),
              const SizedBox(
                height: 10,
              ),

              //banner picker
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg', 'pdf', 'doc'],
                  );

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    sellerRegistrationProvider
                        .setAdditionalDocFile(File(file.path!));
                  } else {
                    // User canceled the picker
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.upload_file,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          sellerRegistrationProvider.getAdditionalDocFile ==
                                  null
                              ? l10n.uploadFile
                              : sellerRegistrationProvider
                                  .getAdditionalDocFile!.path
                                  .split('/')
                                  .last,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Widgets.labels('${l10n.createPasswordLabel} '),
              const SizedBox(
                height: 10,
              ),
              Focus(
                onFocusChange: (hasFocus) {
                  setState(() {});
                },
                child: TextFormField(
                  focusNode: _createPasswordFocus,
                  controller: _createPasswordController,
                  obscureText: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: _createPasswordFocus.hasFocus
                        ? Colors.white
                        : Colors.grey.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20),
                    hintText: l10n.createPasswordHint,
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20),
                    hintText: l10n.confirmPasswordHint,
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
                      return 'Please enter your password';
                    }
                    if (value != _createPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //upload image
              Widgets.labels('${l10n.uploadImageLabel} '),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    sellerRegistrationProvider.setImage(File(pickedFile.path));
                  }
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: sellerRegistrationProvider.image == null
                      ? const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.grey,
                            size: 50,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Image.file(
                            sellerRegistrationProvider.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              //elevated button register as seller
              SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final sellerRegistrationProvider =
                          context.read<SellerRegistrationProvider>();

                      SellerRegistrationData sellerRegistrationData =
                          SellerRegistrationData(
                        fName: _firstNameController.text.trim(),
                        lName: _lastNameController.text.trim(),
                        email: _emailController.text.trim(),
                        phone:
                            '$selectedCountryCode-${_mobileNoController.text.trim()}',
                        password: _createPasswordController.text.trim(),
                        shopName: _shopNameController.text.trim(),
                        shopAddress: _shopAddressController.text.trim(),
                        crIDNo: _crIDNoController.text.trim(),
                        commercialDocument:
                            selectedDocumentType == 'CR' ? 1 : 2,
                        crFreelanceDocPath: sellerRegistrationProvider
                            .getCRFreelanceDocFile!.path,
                        imagePath: sellerRegistrationProvider.getImage!.path,
                        logoPath: sellerRegistrationProvider.getLogoFile!.path,
                        bannerPath:
                            sellerRegistrationProvider.getBannerFile!.path,
                        additionalLegalDocPath: sellerRegistrationProvider
                            .getAdditionalDocFile!.path,
                      );

                      await sellerRegistrationProvider.sellerRegister(
                        context,
                        sellerRegistrationData,
                      );
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
                    l10n.registerBtnText,
                  ),
                ),
              ),
            ],
          ),
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

    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileNoController.dispose();
    _createPasswordController.dispose();
    _confirmPasswordController.dispose();

    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _mobileNoFocus.dispose();
    _createPasswordFocus.dispose();
    _confirmPasswordFocus.dispose();
  }
}
