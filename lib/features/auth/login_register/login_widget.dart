import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/ui/widgets.dart';
import 'package:labees/features/auth/login_register/forgot_password_screen.dart';
import 'package:labees/features/auth/view_model/auth_provider.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 6 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: LoginWidget
*/

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailPhoneFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool obscureText = true;

  //testing email 1:
  //john.doe@gmail.com

  //testing password 1:
  //Welcome@123

  final _emailPhoneController =
      TextEditingController(text: '11hasnainali@gmail.com');
  final _passwordController = TextEditingController(text: 'welcome123');

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final l10n = AppLocalizations.of(context)!;

    return Expanded(
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          //crossAxisAlignment: CrossAxisAlignment.start,
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  l10n.welcome,
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
              l10n.loginToContinue,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Widgets.labels(l10n.emailPhoneLabel),
            const SizedBox(
              height: 10,
            ),
            Focus(
              onFocusChange: (onFocus) {
                setState(() {});
              },
              child: TextFormField(
                focusNode: _emailPhoneFocus,
                controller: _emailPhoneController,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _emailPhoneFocus.hasFocus
                      ? Colors.white
                      : Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: l10n.enterEmailOrPhone,
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
                  if (value == null || value.isEmpty) {
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
            Widgets.labels(l10n.passwordLabel),
            const SizedBox(
              height: 10,
            ),
            Focus(
              onFocusChange: (onFocus) {
                setState(() {});
              },
              child: TextFormField(
                focusNode: _passwordFocus,
                controller: _passwordController,
                obscureText: obscureText,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                  fillColor: _passwordFocus.hasFocus
                      ? Colors.white
                      : Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20),
                  hintText: l10n.passwordHint,
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: l10n.localeName == 'en'
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    l10n.forgotPassword,
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
            SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {

                    int categoryId = context.read<HomeProvider>().getMainCategoriesList.categories!.first.id!;

                    await authProvider.login(
                      context,
                      _emailPhoneController.text,
                      _passwordController.text,
                    );

                    if (authProvider.loginResponse.success!) {
                      if (mounted) {
                        await Future.wait([
                          context.read<CartProvider>().getCartProducts(),
                          context.read<CartProvider>().getShippingMethods(context),
                          context.read<CartProvider>().getCheckoutSettings(context),
                          context.read<CheckoutProvider>().getCountries(context),
                          context.read<HomeProvider>().getDashboardData(context, true,
                              AppLocalizations.of(context)!.localeName, categoryId, 'all'),
                          context.read<CheckoutProvider>().getAllAddresses(context),
                        ]);


                      }
                    }
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
                  l10n.login,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailPhoneController.dispose();
    _passwordController.dispose();
  }
}
