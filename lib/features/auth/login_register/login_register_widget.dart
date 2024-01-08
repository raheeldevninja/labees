import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/features/auth/login_register/login_widget.dart';
import 'package:labees/features/auth/login_register/register_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/*
*  Date 7 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: LoginRegisterWidget
*/

class LoginRegisterWidget extends StatefulWidget {
  const LoginRegisterWidget({Key? key}) : super(key: key);

  @override
  State<LoginRegisterWidget> createState() => _LoginRegisterWidgetState();
}

class _LoginRegisterWidgetState extends State<LoginRegisterWidget> {

  bool _isLoginSelected = true;

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.drawerIconBgColor,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    onTap: () {

                      setState(() {
                        _isLoginSelected = true;
                      });

                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: _isLoginSelected ? AppColors.primaryColor : Colors.transparent ,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(l10n.login, style: TextStyle(color: _isLoginSelected ? Colors.white : AppColors.primaryColor),),
                    ),
                  ),
                ),

                Expanded(
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    onTap: () {
                      setState(() {
                        _isLoginSelected = false;
                      });

                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: _isLoginSelected ? Colors.transparent : AppColors.primaryColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(l10n.register, style: TextStyle(color: _isLoginSelected ? AppColors.primaryColor : Colors.white),),
                    ),
                  ),
                ),
              ],
            ),
          ),

          _isLoginSelected ? const LoginWidget() : const RegisterWidget(),

        ],
      ),
    );
  }
}
