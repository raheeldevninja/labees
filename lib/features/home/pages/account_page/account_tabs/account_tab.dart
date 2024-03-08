import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/models/account_data.dart';
import 'package:labees/core/models/user.dart';
import 'package:labees/core/ui/simple_button.dart';
import 'package:labees/core/ui/widgets.dart';
import 'package:labees/features/auth/view_model/auth_provider.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/view_model/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 12 - Now-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: Account Tab
*/

enum Gender { male, female }

class AccountTab extends StatefulWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _currentPasswordFocus = FocusNode();
  final _newPasswordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  Gender? selectedGender = Gender.male;

  User? user;
  //bool isEditMode = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.getUserInfo();

      _firstNameController.text = authProvider.getUserData.fName!;
      _lastNameController.text = authProvider.getUserData.lName!;
      _emailController.text = authProvider.getUserData.email!;
      _phoneController.text = authProvider.getUserData.phone!;

      if (authProvider.getUserData.gender == null) {
        selectedGender = Gender.male;
      } else {
        if (authProvider.getUserData.gender == 'Male') {
          selectedGender = Gender.male;
        } else {
          selectedGender = Gender.female;
        }
      }
    });

    // SharedPref.getUser().then((value) {
    //   setState(() {
    //     user = value;
    //   });
    //
    //
    //   _firstNameController.text = user!.fName!;
    //   _lastNameController.text = user!.lName!;
    //   _emailController.text = user!.email!;
    //   _phoneController.text = user!.phone!;
    //
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final accountProvider = Provider.of<AccountProvider>(context);

    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<AuthProvider>(context, listen: false).getUserInfo();
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          //my account and edit button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.myAccountHeading,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Libre Baskerville',
                ),
              ),
              /*TextButton(
                onPressed: () {
                  setState(() {
                    isEditMode = !isEditMode;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Images.editIcon,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.editBtnText,
                      style: const TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ],
                ),
              ),*/
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          Text(
            l10n.personalInfo,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500),
          ),

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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
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
              decoration: InputDecoration(
                filled: true,
                fillColor: _emailFocus.hasFocus
                    ? Colors.white
                    : Colors.grey.withOpacity(0.1),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
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
            child: TextFormField(
              focusNode: _phoneFocus,
              controller: _phoneController,
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: _phoneFocus.hasFocus
                    ? Colors.white
                    : Colors.grey.withOpacity(0.1),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                hintText: l10n.phoneNumberHint,
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
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          Text(
            l10n.selectGender,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 16),

          _buildGenderRadio(Gender.male, 'Male'),
          _buildGenderRadio(Gender.female, 'Female'),

          const SizedBox(height: 16),

          Text(
            l10n.changePasswordHeading,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline),
          ),

          const SizedBox(
            height: 20,
          ),

          Widgets.labels(l10n.currentPasswordLabel),
          const SizedBox(
            height: 10,
          ),
          Focus(
            onFocusChange: (hasFocus) {
              setState(() {});
            },
            child: TextFormField(
              focusNode: _currentPasswordFocus,
              controller: _currentPasswordController,
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: _currentPasswordFocus.hasFocus
                    ? Colors.white
                    : Colors.grey.withOpacity(0.1),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                hintText: l10n.currentPasswordHint,
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
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Widgets.labels('${l10n.passwordLabel} '),
          const SizedBox(
            height: 10,
          ),
          Focus(
            onFocusChange: (hasFocus) {
              setState(() {});
            },
            child: TextFormField(
              focusNode: _newPasswordFocus,
              controller: _newPasswordController,
              obscureText: true,
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: _newPasswordFocus.hasFocus
                    ? Colors.white
                    : Colors.grey.withOpacity(0.1),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                hintText: l10n.minSixChars,
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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
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
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: double.maxFinite,
            height: 50,
            child: SimpleButton(
              text: l10n.update,
              callback: () async {
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);

                AccountData accountData = AccountData(
                  firstName: _firstNameController.text.trim(),
                  lastName: _lastNameController.text.trim(),
                  email: _emailController.text.trim(),
                  phone: _phoneController.text.trim(),
                  gender:
                      selectedGender == Gender.male ? l10n.male : l10n.female,
                  oldPassword: _currentPasswordController.text.trim(),
                  newPassword: _newPasswordController.text.trim(),
                );

                await accountProvider.updateAccount(context, accountData);
                await authProvider.getUserInfo();
              },
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildGenderRadio(Gender gender, String label) {
    return Row(
      children: [
        Radio<Gender>(
          value: gender,
          groupValue: selectedGender,
          onChanged: (Gender? value) {
            setState(() {
              selectedGender = value;
            });
          },
        ),
        Text(label),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }
}
