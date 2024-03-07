import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/models/alphabet.dart';
import 'package:labees/core/models/brand.dart';
import 'package:labees/core/models/category.dart';
import 'package:labees/core/models/product_color.dart';
import 'package:labees/core/models/product_size.dart';
import 'package:labees/core/models/sub_category.dart';
import 'package:labees/features/home/widgets/app_drawer.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:labees/features/notifications/notifications_screen.dart';
import 'package:labees/features/search/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/*
*  Date 26 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: DesignersPage
*/

class DesignersPage extends StatefulWidget {
  const DesignersPage({Key? key}) : super(key: key);

  @override
  State<DesignersPage> createState() => _DesignersPageState();
}

class _DesignersPageState extends State<DesignersPage> {

  late ScrollController _scrollController;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();

  List<Category> categories = [];
  List<SubCategory> subCategories = [];
  List<Brand> brands = [];
  List<ProductSizes> sizes = [];

  bool _isPriorityDeliverySelected = false;
  SfRangeValues _values = const SfRangeValues(0.0, 100000.0);

  List<ProductColor> colorsList = [];

  List<Alphabet> alphabets = [];

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _initCategories();
    _initMaleSubCategories();
    _initBrands();
    _initColorsList();
    _initSizes();
    _initAlphabets();
  }

  _initCategories() {
    categories.add(Category(
        name: 'Dresses',
        image:
            'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png',
        isSelected: true));
    categories.add(Category(
        name: 'Coats & Jackets',
        image:
            'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'));
    categories.add(Category(
        name: 'Tops',
        image:
            'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'));
    categories.add(Category(
      name: 'Trousers',
      image:
          'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png',
    ));
    categories.add(Category(
        name: 'Jeans',
        image:
            'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'));
    categories.add(Category(
        name: 'Skirts',
        image:
            'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'));
    categories.add(Category(
        name: 'Shoes',
        image:
            'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'));
    categories.add(Category(
        name: 'Bags',
        image:
            'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'));
  }

  _initMaleSubCategories() {
    subCategories.add(SubCategory(name: 'Office Wear'));
    subCategories.add(SubCategory(name: 'T-shirts'));
    subCategories.add(SubCategory(name: 'Dresses'));
    subCategories.add(SubCategory(name: 'Coats'));
    subCategories.add(SubCategory(name: 'Pants & Jeans'));
    subCategories.add(SubCategory(name: 'Shorts'));
    subCategories.add(SubCategory(name: 'Sweaters'));
  }

  _initWomenSubCategories() {
    subCategories.add(SubCategory(name: 'Tops'));
    subCategories.add(SubCategory(name: 'T-shirts'));
    subCategories.add(SubCategory(name: 'Dresses'));
    subCategories.add(SubCategory(name: 'Bride'));
    subCategories.add(SubCategory(name: 'Pants & Jeans'));
    subCategories.add(SubCategory(name: 'Shorts'));
    subCategories.add(SubCategory(name: 'Figure'));
  }

  _initKidsSubCategories() {
    subCategories.add(SubCategory(name: 'Baby'));
    subCategories.add(SubCategory(name: 'Boy'));
    subCategories.add(SubCategory(name: 'Girl'));
    subCategories.add(SubCategory(name: 'Designers'));
  }

  _initBrands() {
    brands.add(Brand(name: 'Versace', image: 'https://labees.mydomain101.net/storage/app/public/brand/2023-07-06-64a694045e73c.svg',));
    brands.add(Brand(name: 'Versace', image: 'https://labees.mydomain101.net/storage/app/public/brand/2023-07-06-64a693dfa4114.svg'));


    brands.add(Brand(name: 'Versace', image: 'https://labees.mydomain101.net/storage/app/public/brand/2023-07-06-64a694045e73c.svg',));
    brands.add(Brand(name: 'Versace', image: 'https://labees.mydomain101.net/storage/app/public/brand/2023-07-06-64a693dfa4114.svg'));


    brands.add(Brand(name: 'Versace', image: 'https://labees.mydomain101.net/storage/app/public/brand/2023-07-06-64a694045e73c.svg',));
    brands.add(Brand(name: 'Versace', image: 'https://labees.mydomain101.net/storage/app/public/brand/2023-07-06-64a693dfa4114.svg'));

    brands.add(Brand(name: 'Versace', image: 'https://labees.mydomain101.net/storage/app/public/brand/2023-07-06-64a694045e73c.svg',));
    brands.add(Brand(name: 'Versace', image: 'https://labees.mydomain101.net/storage/app/public/brand/2023-07-06-64a693dfa4114.svg'));


    brands.add(Brand(name: '', image: 'https://labees.mydomain101.net/storage/app/public/brand/2023-07-06-64a694045e73c.svg',));
    brands.add(Brand(name: '', image: 'https://labees.mydomain101.net/storage/app/public/brand/2023-07-06-64a693dfa4114.svg'));


    brands.add(Brand(name: '', image: 'https://labees.mydomain101.net/storage/app/public/brand/2023-07-06-64a694045e73c.svg',));
    brands.add(Brand(name: '', image: 'https://labees.mydomain101.net/storage/app/public/brand/2023-07-06-64a693dfa4114.svg'));

  }

  _initColorsList() {
    colorsList.add(ProductColor(color: Colors.red));
    colorsList.add(ProductColor(color: Colors.blue));
    colorsList.add(ProductColor(color: Colors.green));
    colorsList.add(ProductColor(color: Colors.yellow));
    colorsList.add(ProductColor(color: Colors.purple));
    colorsList.add(ProductColor(color: Colors.orange));
    colorsList.add(ProductColor(color: Colors.pink));
    colorsList.add(ProductColor(color: Colors.brown));
    colorsList.add(ProductColor(color: Colors.grey));
    colorsList.add(ProductColor(color: Colors.black));
    colorsList.add(ProductColor(color: Colors.white));
  }

  _initSizes() {
    sizes.add(ProductSizes(size: 'S', isSelected: true));
    sizes.add(ProductSizes(size: 'M'));
    sizes.add(ProductSizes(size: 'L'));
    sizes.add(ProductSizes(size: 'XL'));
    sizes.add(ProductSizes(size: 'XXL'));
  }


  _initAlphabets() {
    alphabets.add(Alphabet(letter: '0-9'));

    //a - z
    for (int i = 65; i <= 90; i++) {
      alphabets.add(Alphabet(letter: String.fromCharCode(i)));
    }
  }

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
            leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: SvgPicture.asset(
              Images.menu,
              width: 24,
              height: 24,
              color: AppColors.primaryColor,
            ),
          ),
          title: SizedBox(
            height: 40,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              child: AbsorbPointer(
                child: TextFormField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(12.0),
                    hintText: l10n.searchHint,
                    hintStyle:
                        const TextStyle(fontSize: 14, color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        Images.searchIcon,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: badges.Badge(
                badgeContent: Text(
                  cartProvider.cartProducts.length.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                child: SvgPicture.asset(
                  Images.cartIcon,
                  color: AppColors.primaryColor,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 14,
              color: AppColors.primaryColor,
              margin: const EdgeInsets.symmetric(vertical: 16),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsScreen(),
                  ),
                );
              },
              icon: SvgPicture.asset(
                Images.notificationsIcon,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.designers,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Libre Baskerville',
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //men, women, kids
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      subCategories.clear();
                      _initMaleSubCategories();
                    });
                  },
                  child: const Text(
                    'Men',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    subCategories.clear();
                    _initWomenSubCategories();
                    setState(() {});
                  },
                  child: Text(
                    'Women',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    subCategories.clear();
                    _initKidsSubCategories();
                    setState(() {});
                  },
                  child: Text(
                    'Kids',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //left section
                  SizedBox(
                    width: 110,
                    child: RawScrollbar(
                      thumbVisibility: true,
                      thumbColor: AppColors.primaryColor,
                      thickness: 2,
                      child: ListView.builder(
                        controller: ScrollController(),
                        itemCount: categories.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(4),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              for (int i = 0; i < categories.length; i++) {
                                categories[i] =
                                    categories[i].copyWith(isSelected: false);
                              }
                              categories[index] =
                                  categories[index].copyWith(isSelected: true);

                              setState(() {});
                            },
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: categories[index].isSelected
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                  width: 1,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: categories[index].image!,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    categories[index].name,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: categories[index].isSelected
                                          ? Colors.white
                                          : AppColors.lightGrey,
                                      fontFamily: 'Montserrat',
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(width: 4),

                  //right section
                  Expanded(
                    child: Column(

                      children: [

                        //horizontal listview of alphabets
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            itemCount: alphabets.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {

                              final header = alphabets.elementAt(index);

                              return InkWell(
                                onTap: () {
                                  scrollToHeader(header);

                                  for (int i = 0; i < alphabets.length; i++) {
                                    alphabets[i] = alphabets[i]
                                        .copyWith(isSelected: false);
                                  }
                                  alphabets[index] = alphabets[index]
                                      .copyWith(isSelected: true);

                                  setState(() {});


                                },
                                child: Container(
                                  margin: const EdgeInsets.all(4),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: alphabets[index].isSelected
                                        ? AppColors.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:
                                          AppColors.lightGrey.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    alphabets[index].letter,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: alphabets[index].isSelected
                                          ? Colors.white
                                          : AppColors.lightGrey,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 16,),

                        //list view of designers with sticky headers of alphabet
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: alphabets.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {

                              return StickyHeader(
                                header: Container(
                                  height: 40,
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.lightGrey
                                            .withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    alphabets[index].letter,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                content: ListView.separated(
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index2) {
                                    return InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 30,
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                        child: Text(
                                          'A',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                AppColors.blackColor,
                                            fontFamily:
                                                'Montserrat',
                                          ),
                                          maxLines: 1,
                                          overflow:
                                              TextOverflow.ellipsis,
                                        ),
                                      ),
                                    );
                                  }, separatorBuilder: (BuildContext context, int index) {
                                    return Container(height: 0.5, color: AppColors.lightGrey.withOpacity(0.3),);
                                },
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openFilterBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return FractionallySizedBox(
            heightFactor: 0.75,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Filter By: ',
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //rounded corner border container
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isPriorityDeliverySelected =
                            !_isPriorityDeliverySelected;
                      });
                    },
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: _isPriorityDeliverySelected
                            ? AppColors.selectedOption
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Priority Delivery',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: AppColors.blackColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Category',
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (int i = 0; i < categories.length; i++)
                        InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            setState(() {
                              categories[i] = categories[i].copyWith(
                                  isSelected: !categories[i].isSelected);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: categories[i].isSelected
                                  ? AppColors.selectedOption.withOpacity(0.3)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: AppColors.borderColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              categories[i].name,
                              style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: AppColors.blackColor),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Brands',
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (int i = 0; i < brands.length; i++)
                        InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            setState(() {
                              brands[i] = brands[i]
                                  .copyWith(isSelected: !brands[i].isSelected);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: brands[i].isSelected
                                  ? AppColors.selectedOption.withOpacity(0.3)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: AppColors.borderColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              brands[i].name,
                              style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: AppColors.blackColor),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Price',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: AppColors.borderColor.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Sar ${_values.end.round()}',
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                              color: AppColors.blackColor),
                        ),
                      ),
                    ],
                  ),

                  SfRangeSlider(
                    min: 300.0,
                    max: 100000.0,
                    values: _values,
                    interval: 30,
                    showTicks: false,
                    showLabels: false,
                    enableTooltip: false,
                    showDividers: false,
                    minorTicksPerInterval: 1,
                    onChanged: (SfRangeValues values) {
                      setState(() {
                        _values = values;
                      });
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //start range and end range
                        Expanded(
                          child: Text(
                            'Sar ${_values.start.round()}',
                            style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: AppColors.blackColor),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'Sar ${_values.end.round()}',
                            style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: AppColors.blackColor),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Color',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //color options
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      for (int i = 0; i < colorsList.length; i++)
                        InkWell(
                          borderRadius: BorderRadius.circular(30.0),
                          onTap: () {
                            setState(() {
                              for (int j = 0; j < colorsList.length; j++) {
                                if (j == i) {
                                  colorsList[j] = colorsList[j].copyWith(
                                      isSelected: !colorsList[j].isSelected);
                                } else {
                                  colorsList[j] =
                                      colorsList[j].copyWith(isSelected: false);
                                }
                              }
                            });
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorsList[i].color,
                              border: Border.all(
                                color: colorsList[i].isSelected
                                    ? AppColors.blackColor
                                    : Colors.transparent,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Sizing',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //size options
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      for (int i = 0; i < sizes.length; i++)
                        InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            setState(() {
                              for (int j = 0; j < sizes.length; j++) {
                                if (j == i) {
                                  sizes[j] = sizes[j].copyWith(
                                      isSelected: !sizes[j].isSelected);
                                } else {
                                  sizes[j] =
                                      sizes[j].copyWith(isSelected: false);
                                }
                              }
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 4.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: sizes[i].isSelected
                                  ? AppColors.selectedOption.withOpacity(0.3)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: AppColors.borderColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              sizes[i].size,
                              style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: AppColors.blackColor),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void scrollToHeader(Alphabet header) {

    final index = alphabets.indexOf(header);

    //animate to header position

    print('index value: $index');
    print('header value: ${header.letter}');
    final headerHeight = 130.0; // Adjust as needed
    final totalHeaderHeight = index * headerHeight;
    _scrollController.animateTo(
      totalHeaderHeight,
      //0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }
}
