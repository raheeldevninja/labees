import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/ui/widgets.dart';
import 'package:labees/features/auth/view_model/auth_provider.dart';
import 'package:labees/features/home/models/registeration_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 3 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: RegisterWidget
*/


class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context);

    return Expanded(
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  l10n.registerHeading,
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'Libre Baskerville',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              l10n.createAnAccount,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Widgets.labels('${l10n.firstNameLabel} '),
            const SizedBox(
              height: 10,
            ),
            Focus(
              onFocusChange: (hasFocus) {
                setState(() {

                });
              },
              child: TextFormField(
                focusNode: _firstNameFocus,
                controller: _firstNameController,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _firstNameFocus.hasFocus ? Colors.white : Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  hintText: l10n.firstNameHint,
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.primaryColor, width: 1.0),
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
                setState(() {

                });
              },
              child: TextFormField(
                controller: _lastNameController,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _lastNameFocus.hasFocus ? Colors.white : Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                  hintText: l10n.lastNameHint,
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.primaryColor, width: 1.0),
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
                setState(() {

                });
              },
              child: TextFormField(
                focusNode: _emailFocus,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _emailFocus.hasFocus ? Colors.white : Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: l10n.emailHint,
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.primaryColor, width: 1.0),
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
            Widgets.labels('${l10n.phoneNumberLabel} '),
            const SizedBox(
              height: 10,
            ),
            Focus(
              onFocusChange: (hasFocus) {
                setState(() {

                });
              },
              child: TextFormField(
                focusNode: _phoneFocus,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _phoneFocus.hasFocus ? Colors.white : Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                  hintText: l10n.phoneNumberHint,
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.primaryColor, width: 1.0),
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
            const SizedBox(
              height: 20,
            ),
            Widgets.labels(l10n.createPasswordLabel),
            const SizedBox(
              height: 10,
            ),
            Focus(
              onFocusChange: (hasFocus) {
                setState(() {

                });
              },
              child: TextFormField(
                focusNode: _passwordFocus,
                controller: _passwordController,
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _passwordFocus.hasFocus ? Colors.white : Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                  hintText: l10n.createPasswordHint,
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.primaryColor, width: 1.0),
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
                setState(() {

                });
              },
              child: TextFormField(
                focusNode: _confirmPasswordFocus,
                controller: _confirmPasswordController,
                obscureText: true,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _confirmPasswordFocus.hasFocus ? Colors.white : Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: l10n.confirmPasswordHint,
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.primaryColor, width: 1.0),
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
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {

                    RegistrationData registrationData = RegistrationData(
                      fName: _firstNameController.text,
                      lName: _lastNameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      password: _passwordController.text,
                    );

                    await authProvider.register(
                      context,
                      registrationData,
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
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {

                  },
                  child: Text(
                    l10n.termsAndConditions,
                    style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.forgotPasswordColor),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
  }
}
