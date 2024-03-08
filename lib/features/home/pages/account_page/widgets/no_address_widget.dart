import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/images/images.dart';

/*
*  Date 10 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: NoAddressWidget
*/

class NoAddressWidget extends StatelessWidget {
  const NoAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'You Currently Have No Addresses Added So Far. Once You Have Made A Purchase, We Will Store Your Billing Information In Your Account For Future Purchases.',
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Montserrat',
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        SvgPicture.asset(
          width: double.maxFinite,
          height: 170,
          Images.noAddress,
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
