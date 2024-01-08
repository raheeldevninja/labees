import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'register_seller_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.becomeSellerHeading,
                style: const TextStyle(
                    fontSize: 30, fontWeight: FontWeight.w400, color: AppColors.primaryColor),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                l10n.createSellerAccountText,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.primaryColor),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: Image.asset(
                  Images.sellerImg,
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  l10n.registerNow,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400, color: AppColors.primaryColor),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterSellerScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                  ),
                  child: Text(
                    l10n.registerAsSeller,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
