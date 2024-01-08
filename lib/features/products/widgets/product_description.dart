import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as htmlDom;
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:provider/provider.dart';


/*
*  Date 19 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: ProductDescription
*/


class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final homeProvider = Provider.of<HomeProvider>(context);

    String htmlString = homeProvider.productDetails!.details ?? '';

    // Parse HTML
    final document = htmlParser.parse(htmlString);
    String parsedText = parseHtml(document);

    return Text(
      parsedText,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.blackColor,
        fontWeight: FontWeight.w400
      ),
    );
  }

  String parseHtml(htmlDom.Document document) {
    // Extract text content from the parsed HTML
    String textContent = '';

    if (document.body != null) {
      textContent = document.body!.text;
    }

    return textContent;
  }
}