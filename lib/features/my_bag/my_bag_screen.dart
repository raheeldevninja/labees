import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/models/cart_product.dart';
import 'package:labees/core/ui/summary_sheet.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/auth/login_register/login_register_widget.dart';
import 'package:labees/features/auth/view_model/auth_provider.dart';
import 'package:labees/features/checkout/checkout_screen.dart';
import 'package:labees/features/my_bag/model/my_bag.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/*
*  Date 15 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: MyBagScreen
*/


class MyBagScreen extends StatefulWidget {
  const MyBagScreen({Key? key}) : super(key: key);

  @override
  State<MyBagScreen> createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {

  List<MyBag> myBagProducts = [];
  int qty = 1;


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context);

    final authProvider = Provider.of<AuthProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return authProvider.isLoggedIn
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              centerTitle: true,
              //title: Text('My Bag (${myBagProducts.length})',
              title: Text('${l10n.myBag} (${cartProvider.cartProducts.length})',
                  style: const TextStyle(color: AppColors.primaryColor)),
            ),
            body: ColoredBox(
              color: AppColors.white,
              child: Stack(
                children: [
                  cartProvider.cartProducts.isEmpty ? const Center(child: Text('No items')) : ListView.separated(
                    //itemCount: myBagProducts.length,
                    itemCount: cartProvider.cartProducts.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          /*setState(() {
                            myBagProducts.removeAt(index);
                          });*/

                          cartProvider.removeCartProduct(cartProvider.cartProducts[index]);
                        },
                        background: Container(
                          padding: const EdgeInsets.only(right: 16),
                          color: AppColors.primaryColor,
                          alignment: Alignment.centerRight,
                          //child: const Icon(Icons.delete, color: Colors.white),
                          child: SvgPicture.asset(
                            'assets/icons/delete_icon_bag.svg',
                            color: Colors.white,
                          ),
                        ),
                        child: /*MyBagItem(
                          myBag: myBagProducts[index],
                          increment: () {
                            int qty = myBagProducts[index].quantity;
                            qty++;
                            setState(() {
                              myBagProducts[index] =
                                  myBagProducts[index].copyWith(quantity: qty);
                            });
                          },
                          decrement: () {
                            int qty = myBagProducts[index].quantity;
                            qty--;
                            if (qty > 1) {
                              setState(() {
                                myBagProducts[index] = myBagProducts[index]
                                    .copyWith(quantity: qty);
                              });
                            }
                          },
                        ),*/
                        CartProductItem(
                          cartProduct: cartProvider.cartProducts[index],
                          quantity: cartProvider.cartProducts[index].quantity,
                          increment: () {
                            //cartProvider.incrementQuantity(cartProvider.cartProducts[index]);
                            cartProvider.incrementQuantity(index);
                          },
                          decrement: () {
                            //cartProvider.decrementQuantity(cartProvider.cartProducts[index]);
                            cartProvider.decrementQuantity(index);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),

                  const SummarySheet(),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              color: AppColors.bgColor,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {

                        if(cartProvider.cartProducts.isNotEmpty) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckoutScreen(),
                            ),
                          );

                        }
                        else {
                          Utils.toast('No items in cart');
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(l10n.checkoutBtnText),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            body: const SafeArea(
              child: LoginRegisterWidget(),
            ),
          );
  }
}

class MyBagItem extends StatefulWidget {
  const MyBagItem({
    Key? key,
    required this.myBag,
    required this.increment,
    required this.decrement,
  }) : super(key: key);

  final MyBag myBag;
  final VoidCallback increment;
  final VoidCallback decrement;

  @override
  State<MyBagItem> createState() => _MyBagItemState();
}

class _MyBagItemState extends State<MyBagItem> {
  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Center(
                child: CachedNetworkImage(
                  width: 80,
                  height: 80,
                  imageUrl: widget.myBag.productImage,
                  placeholder: (context, url) =>
                      const CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.myBag.productBrand,
                      style: const TextStyle(
                          fontFamily: 'Libre Baskerville',
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Size: ${widget.myBag.size}',
                      style: const TextStyle(
                          fontFamily: 'Montserrat', fontSize: 12)),
                  const SizedBox(height: 8),
                  Text('Color: ${widget.myBag.color}',
                      style: const TextStyle(
                          fontFamily: 'Montserrat', fontSize: 12)),
                  const SizedBox(height: 8),
                  Container(
                    width: 90,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        border:
                            Border.all(width: 1, color: AppColors.borderColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: widget.decrement,
                          child: Container(
                            width: 20,
                            height: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child:
                                Icon(l10n.localeName == 'en'
                                    ? Icons.keyboard_arrow_left_rounded
                                    : Icons.keyboard_arrow_right_rounded, size: 16),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.myBag.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: widget.increment,
                          child: Container(
                            width: 20,
                            height: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(l10n.localeName == 'en'
                                ? Icons.keyboard_arrow_right_rounded
                                : Icons.keyboard_arrow_left_rounded,
                                size: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Text('${widget.myBag.price.toString()} Sar',
                    style: const TextStyle(
                        fontFamily: 'Libre Baskerville',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.red))),
          ],
        ),
      ),
    );
  }
}


class CartProductItem extends StatefulWidget {
  const CartProductItem({
    Key? key,
    required this.cartProduct,
    required this.quantity,
    required this.increment,
    required this.decrement,
  }) : super(key: key);

  final CartProduct cartProduct;
  final int quantity;
  final VoidCallback increment;
  final VoidCallback decrement;

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Center(
                child: CachedNetworkImage(
                  width: 80,
                  height: 80,
                  imageUrl: '${APIs.imageBaseURL}${APIs.productThumbnailImages}${widget.cartProduct.image}',
                  placeholder: (context, url) =>
                  const CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.cartProduct.brand,
                      style: const TextStyle(
                          fontFamily: 'Libre Baskerville',
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(widget.cartProduct.title,
                      style: const TextStyle(
                          fontFamily: 'Libre Baskerville',
                          fontSize: 12)),
                  const SizedBox(height: 8),
                  Container(
                    width: 90,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(30)),
                        border:
                        Border.all(width: 1, color: AppColors.borderColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: widget.decrement,
                          child: Container(
                            width: 20,
                            height: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child:
                            Icon(l10n.localeName == 'en'
                                ? Icons.keyboard_arrow_left_rounded
                                : Icons.keyboard_arrow_right_rounded, size: 16),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          //widget.cartProduct.quantity.toString(),
                          widget.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: widget.increment,
                          child: Container(
                            width: 20,
                            height: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(l10n.localeName == 'en'
                                ? Icons.keyboard_arrow_right_rounded
                                : Icons.keyboard_arrow_left_rounded,
                                size: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Text('${widget.cartProduct.unitPrice * widget.cartProduct.quantity} Sar',
                    style: const TextStyle(
                        fontFamily: 'Libre Baskerville',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.red))),
          ],
        ),
      ),
    );
  }
}