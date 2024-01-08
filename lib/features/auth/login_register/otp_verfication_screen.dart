import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/features/auth/login_register/new_password_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/features/auth/view_model/auth_provider.dart';
import 'package:provider/provider.dart';


/*
*  Date 3 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: OTPVerificationScreen
*/



class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {

  final _otp1 = TextEditingController();
  final _otp2 = TextEditingController();
  final _otp3 = TextEditingController();
  final _otp4 = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context);
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: AppColors.secondaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  l10n.otpVerificationHeading,
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
              l10n.enterFourDigitCode,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(
              height: 40,
            ),


            ///circle otp text fields
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    controller: _otp1,
                    textAlign: TextAlign.center,

                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    onChanged: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: const EdgeInsets.all(12.0),

                      hintStyle: const TextStyle(
                          fontSize: 14, color: AppColors.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    controller: _otp2,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      FocusScope.of(context).nextFocus();
                      if(value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                        _otp1.selection = TextSelection.fromPosition(TextPosition(offset: _otp1.text.length));
                      }
                    },
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: const EdgeInsets.all(12.0),

                      hintStyle: const TextStyle(
                          fontSize: 14, color: AppColors.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    controller: _otp3,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      FocusScope.of(context).nextFocus();

                      if(value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                        _otp2.selection = TextSelection.fromPosition(TextPosition(offset: _otp2.text.length));
                      }
                    },
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: const EdgeInsets.all(12.0),

                      hintStyle: const TextStyle(
                          fontSize: 14, color: AppColors.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    controller: _otp4,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      FocusScope.of(context).unfocus();


                      //on delete go back to previous field but cursor should be at the end
                      if(value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                        _otp3.selection = TextSelection.fromPosition(TextPosition(offset: _otp3.text.length));
                      }

                    },
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: const EdgeInsets.all(12.0),

                      hintStyle: const TextStyle(
                          fontSize: 14, color: AppColors.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
            ]),

            const SizedBox(height: 40,),

            //timer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.alarm, color: AppColors.primaryColor, size: 32,),

                const SizedBox(width: 10,),
                //60 seconds timer
                TweenAnimationBuilder(
                  tween: Tween(begin: 60.0, end: 0.0),
                  duration: const Duration(seconds: 60),
                  builder: (context, value, child) {
                    final seconds = value % 60;
                    return Text(
                      '${seconds.round()} seconds',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: AppColors.primaryColor,
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 40,),
            SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {

                  String otpCode = _otp1.text.trim() + _otp2.text.trim() + _otp3.text.trim() + _otp4.text.trim();

                  ///call verify otp api
                  await authProvider.verifyOTP(context, widget.email, otpCode);

                  if(mounted && authProvider.verifyOTPResponse.status!) {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewPasswordScreen(email: widget.email, otp: otpCode,),
                      ),
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
                  l10n.setNewPasswordBtnText,
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

    _otp1.dispose();
    _otp2.dispose();
    _otp3.dispose();
    _otp4.dispose();
  }

}
