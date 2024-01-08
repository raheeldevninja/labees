import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/enums/order_status.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/orders/all_orders_page.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/orders/completed_orders_page.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/orders/in_progress_orders_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/*
*  Date 4 - Now-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: Orders Main Page
*/

OrderStatus orderStatus = OrderStatus.all;

class OrdersMainPage extends StatefulWidget {
  const OrdersMainPage({Key? key}) : super(key: key);


  @override
  State<OrdersMainPage> createState() => _OrdersMainPageState();
}

class _OrdersMainPageState extends State<OrdersMainPage> {

  late PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            children: [

              Expanded(
                child: SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {


                      pageController.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);

                      setState(() {
                        orderStatus = OrderStatus.all;
                        currentPage = 0;
                      });

                    },
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: orderStatus == OrderStatus.all ? AppColors.primaryColor : Colors.white,
                      backgroundColor: currentPage == 0 ? AppColors.primaryColor : Colors.white,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                    ),
                    child: Text(
                      l10n.allBtnText,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: currentPage == 0 ? Colors.white : AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {

                      pageController.animateToPage(1, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);


                      setState(() {
                        orderStatus = OrderStatus.inProgress;
                        currentPage = 1;
                      });

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentPage == 1 ? AppColors.primaryColor : Colors.white,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                    ),
                    child: Text(
                      l10n.inProgressBtnText,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: currentPage == 1 ? Colors.white : AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {

                      pageController.animateToPage(2, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);

                      setState(() {
                        orderStatus = OrderStatus.completed;
                        currentPage = 2;
                      });

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentPage == 2 ? AppColors.primaryColor : Colors.white,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                    ),
                    child: Text(
                      l10n.completedBtnText,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        //color: orderStatus == OrderStatus.completed ? Colors.white : AppColors.primaryColor,
                        color: currentPage == 2 ? Colors.white : AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(height: 20,),

          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (page) {
                print('order page: $page');

                setState(() {
                  currentPage = page;
                });

              },
              children: const [
                AllOrdersPage(),
                InProgressOrdersPage(),
                CompletedOrdersPage(),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
