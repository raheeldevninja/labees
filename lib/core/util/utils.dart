import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/enums/main_categories.dart';
import 'package:labees/core/ui/widgets.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/view_model/order_provider.dart';
import 'package:labees/features/home/pages/account_page/model/order.dart';
import 'package:labees/features/home/pages/account_page/model/order_product.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 3 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: Utils
*/

class Utils {
  //bottom navigation
  static PersistentTabController controller =
      PersistentTabController(initialIndex: 0);

  static String step = 'information';
  static final pageController = PageController();
  static int currentPage = 0;

  static List<Order> myOrders = [];

  static List<Color> bannerBgColors = [
    Colors.deepPurple,
    Colors.orange,
    Colors.pink,
    Colors.blue,
    Colors.green,
  ];

  static MainCategories mainCategories = MainCategories.men;

  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  static toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: AppColors.secondaryColor,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  //cancel order dialog
  static void showCancelOrderDialog(
      BuildContext context,
      int orderId,
      AppLocalizations l10n,
      OrderProvider orderProvider,
      TextEditingController reasonController) {
    List<String> cancellationReasonsList = [
      'Found a better price',
      'No need anymore',
      'Ordered by mistake',
      'Delay in delivery',
      'Other',
    ];

    String selectedReason = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const SizedBox(),
          contentPadding: const EdgeInsets.all(24),
          buttonPadding: const EdgeInsets.all(24),
          scrollable: true,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.close, size: 48, color: AppColors.white),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  l10n.cancelOrderConfirmation,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  l10n.cancellationReasonLabel,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Widgets.labels('${l10n.reasonLabel} '),
              const SizedBox(
                height: 8,
              ),

              /*TextFormField(
                controller: reasonController,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.lightGrey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: l10n.writeMessageHint,
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),*/

              //cancellation reason drop down
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.lightGrey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20),
                  hintText: 'Select reason',
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                items: cancellationReasonsList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  selectedReason = value!;
                },
              ),
            ],
          ),
          actions: [
            //rounded red button
            SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  //final orderProvider = Provider.of<OrderProvider>(context, listen: false);

                  print('selectedReason: $selectedReason');

                  if (selectedReason.isEmpty) {
                    Utils.toast(l10n.enterCancellationReason);
                    return;
                  }

                  await orderProvider.cancelOrder(
                    context,
                    orderId,
                    selectedReason,
                  );

                  await orderProvider.getOrders(context, 'all', 10, 1);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                ),
                child: Text(
                  l10n.cancelOrderBtnText,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void initOrders() {
    myOrders.add(
      Order(
        orderStatus: 'In Progress',
        paymentStatus: 'Paid',
        shippingStatus: 'Shipped',
        totalPrice: 4500,
        paymentMethod: 'Master Card',
        products: [
          OrderProduct(
            productName: 'Product 1',
            productBrand: 'Vercase',
            productImg: 'https://picsum.photos/250?image=9',
            price: 100,
            quantity: 1,
            orderId: '345344',
            size: 'Medium',
            color: 'Red',
            orderDate: '12/12/2021',
            deliveryDate: '12/12/2021',
          ),
          OrderProduct(
            productName: 'Product 2',
            productBrand: 'Vercase',
            productImg: 'https://picsum.photos/250?image=8',
            price: 4400,
            quantity: 1,
            orderId: '345344',
            size: 'Regular',
            color: 'Red',
            orderDate: '12/12/2021',
            deliveryDate: '12/12/2021',
          ),
        ],
      ),
    );

    myOrders.add(
      Order(
        orderStatus: 'Completed',
        paymentStatus: 'Paid',
        shippingStatus: 'Shipped',
        totalPrice: 4500,
        paymentMethod: 'Master Card',
        products: [
          OrderProduct(
            productName: 'Product 1',
            productBrand: 'Vercase',
            productImg: 'https://picsum.photos/250?image=9',
            price: 100,
            quantity: 1,
            orderId: '345344',
            size: 'Medium',
            color: 'Red',
            orderDate: '12/12/2021',
            deliveryDate: '12/12/2021',
          ),
          OrderProduct(
            productName: 'Product 2',
            productBrand: 'Vercase',
            productImg: 'https://picsum.photos/250?image=8',
            price: 4400,
            quantity: 1,
            orderId: '345344',
            size: 'Regular',
            color: 'Red',
            orderDate: '12/12/2021',
            deliveryDate: '12/12/2021',
          ),
        ],
      ),
    );

    myOrders.add(
      Order(
        orderStatus: 'In Progress',
        paymentStatus: 'Paid',
        shippingStatus: 'Shipped',
        totalPrice: 4500,
        paymentMethod: 'Master Card',
        products: [
          OrderProduct(
            productName: 'Product 1',
            productBrand: 'Vercase',
            productImg: 'https://picsum.photos/250?image=9',
            price: 100,
            quantity: 1,
            orderId: '345344',
            size: 'Medium',
            color: 'Red',
            orderDate: '12/12/2021',
            deliveryDate: '12/12/2021',
          ),
          OrderProduct(
            productName: 'Product 2',
            productBrand: 'Vercase',
            productImg: 'https://picsum.photos/250?image=8',
            price: 4400,
            quantity: 1,
            orderId: '345344',
            size: 'Regular',
            color: 'Red',
            orderDate: '12/12/2021',
            deliveryDate: '12/12/2021',
          ),
        ],
      ),
    );
  }

  //month num to month name 3 chars
  static String monthNumToName(int monthNum) {
    switch (monthNum) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      default:
        return 'Dec';
    }
  }
}
