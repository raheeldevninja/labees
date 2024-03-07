import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/models/address_data.dart';
import 'package:labees/core/models/cities_data.dart';
import 'package:labees/core/models/countries_data.dart';
import 'package:labees/core/ui/simple_button.dart';
import 'package:labees/core/ui/widgets.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/home/models/address_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 10 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: Add Address Screen
*/

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key, this.addressData}) : super(key: key);

  final AddressData? addressData;

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _contactPersonNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _postalCodeController = TextEditingController();

  final _contactPersonNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _postalCodeFocus = FocusNode();


  final _countrySearchController = TextEditingController();
  final _citySearchController = TextEditingController();

  CountriesData? selectedCountry;
  String? selectedCountryCode;
  CitiesData? selectedCity;

  String? selectedAddressType;
  String? selectedState;
  int? selectedAddressId;


  String? selectedAddress;

  bool shippingAddress = false;
  bool showAddressForm = false;

  final List<String> addressTypes = [
    'Permanent',
    'Home',
    'Office',
    'Others',
  ];

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  bool? isEdit;

  LatLng? tappedLocation;
  Set<Marker> markers = {};


  Future<LatLng> getLatLngFromUserInput(String userTextLocation) async {
    final geocoding = GeocodingPlatform.instance;
    final placemarks = await geocoding.locationFromAddress(userTextLocation);
    if (placemarks.isNotEmpty) {
      final placemark = placemarks[0];
      return LatLng(placemark.latitude, placemark.longitude);
    } else {
      throw Exception('Could not find location');
    }
  }

  void navigateToCity(String userTextLocation) async {

    print('userTextLocation: $userTextLocation');
    final latLng = await getLatLngFromUserInput(userTextLocation);
    // Update the GoogleMap widget with the new destination.

    print('latLng: ${latLng.longitude}');


    _controller.future.then((controller) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 16.0),
      ));
    });
  }


  void navigateToCountry(String userTextLocation) async {

    print('userTextLocation: $userTextLocation');
    final latLng = await getLatLngFromUserInput(userTextLocation);
    // Update the GoogleMap widget with the new destination.

    print('latLng: $latLng');


    _controller.future.then((controller) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 5.0),
      ));
    });
  }

  Future<String> getAddressFromCoordinates(double lat, double long) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(lat, long);

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      return "${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}";
    } else {
      return "Address not found";
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {

      final checkoutProvider = Provider.of<CheckoutProvider>(context, listen: false);

      isEdit = widget.addressData != null;

      if (isEdit!) {
        _contactPersonNameController.text = widget.addressData!.contactPersonName!;
        _postalCodeController.text = widget.addressData!.zip!;
        _addressController.text = widget.addressData!.address!;
        selectedAddressType = widget.addressData!.addressType!.substring(0, 1).toUpperCase() + widget.addressData!.addressType!.substring(1);
        selectedCountryCode = widget.addressData!.phoneCode!;
        _phoneController.text = widget.addressData!.phone!;


        selectedAddress = widget.addressData!.address!;


        selectedCountry = checkoutProvider.countries.data!.firstWhere((element) => element.id == widget.addressData!.country!);

        await checkoutProvider.getCities(widget.addressData!.country!);

        if(checkoutProvider.cities != null) {
          selectedCity = checkoutProvider.cities!.data!.firstWhere((element) => element.id == widget.addressData!.city!);
        }


      }
      else {

        //saudia id: 194
        navigateToCountry('Saudi Arabia');
        await checkoutProvider.getCities(194);

        selectedAddressType = addressTypes[0];

        selectedCountryCode = checkoutProvider.countriesData.firstWhere((element) => element.id == 194).phoneCode;
        selectedCountry = checkoutProvider.countriesData.firstWhere((element) => element.id == 194);


      }


    });

  }

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;
    final checkoutProvider = Provider.of<CheckoutProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(

        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,

      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [

                Text(
                  l10n.myAddresses,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Libre Baskerville',
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.maxFinite,
                  height: 300,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    markers: markers,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onTap: (latLng) async {

                      setState(() {
                        tappedLocation = latLng;
                        markers.clear(); // Clear existing markers
                        markers.add(
                          Marker(
                            markerId: MarkerId("tapped_location"),
                            position: latLng,
                            infoWindow: InfoWindow(title: "Tapped Location"),
                          ),
                        );
                      });

                      getAddressFromCoordinates(latLng.latitude, latLng.longitude)
                          .then((address) {

                        _addressController.text = address;

                      });

                    },
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),
                Text(
                  l10n.addAddress,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Libre Baskerville',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                const SizedBox(
                  height: 20,
                ),

                Widgets.labels('${l10n.contactPersonName} '),
                const SizedBox(
                  height: 10,
                ),
                Focus(
                  onFocusChange: (hasFocus) {
                    if (hasFocus) {
                      setState(() {});
                    }
                  },
                  child: TextFormField(
                    focusNode: _contactPersonNameFocus,
                    controller: _contactPersonNameController,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: _contactPersonNameFocus.hasFocus ? Colors.white : Colors.grey.withOpacity(0.1),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                      hintText: l10n.contactPersonNameHint,
                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: AppColors.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return l10n.pleaseEnterContactPersonName;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Widgets.labels('${l10n.phoneLabel} '),
                const SizedBox(
                  height: 10,
                ),
                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _phoneFocus.hasFocus ? Colors.white : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: InkWell(
                            onTap: () {
                              _showCountryBottomSheet(context, l10n, showCountryCode: true);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  selectedCountryCode ?? '- -',
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        // Text Form Field
                        Expanded(
                          child: TextFormField(
                            focusNode: _phoneFocus,
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: l10n.phoneNumberHint,
                              border: InputBorder.none,
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //countries
                Row(
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Widgets.labels('${l10n.countryLabel} ', isRequired: true),
                          const SizedBox(
                            height: 10,
                          ),

                          InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            onTap: () {

                              _showCountryBottomSheet(context, l10n);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(32.0),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.1),
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(child: Text(selectedCountry?.name ?? l10n.selectCountry, maxLines: 1, overflow: TextOverflow.ellipsis,)),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                //cities and postal code
                Row(
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Widgets.labels('${l10n.cityLabel} ', isRequired: true),
                          const SizedBox(
                            height: 10,
                          ),

                          InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            onTap: () {

                              if(checkoutProvider.cities == null) {
                                Fluttertoast.showToast(msg: l10n.pleaseSelectCountry);
                                return;
                              }

                              if(checkoutProvider.cities!.data!.isEmpty) {
                                Fluttertoast.showToast(msg: l10n.citiesNotFound);
                                return;
                              }

                              _showCityBottomSheet(context, l10n);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(32.0),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.1),
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(child: Text(selectedCity?.name ?? l10n.selectCity, maxLines: 1, overflow: TextOverflow.ellipsis,)),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Widgets.labels('${l10n.postalCodeLabel} ', isRequired: true),
                          const SizedBox(
                            height: 10,
                          ),

                          Focus(
                            onFocusChange: (hasFocus) {
                              setState(() {});
                            },
                            child: TextFormField(
                              focusNode: _postalCodeFocus,
                              controller: _postalCodeController,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: _postalCodeFocus.hasFocus ? Colors.white : Colors.grey.withOpacity(0.1),
                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                                hintText: l10n.postalCodeLabel,
                                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: AppColors.primaryColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return l10n.pleaseEnterPostalCode;
                                }
                                return null;
                              },
                            ),
                          ),


                        ],
                      ),
                    ),

                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                Widgets.labels('${l10n.addressType} '),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  value: selectedAddressType,
                  hint: Text(l10n.addressTypeHint),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.0),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  items: addressTypes.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedAddressType = value;
                    });
                  },

                ),

                const SizedBox(
                  height: 20,
                ),


                Widgets.labels('${l10n.address} '),
                const SizedBox(
                  height: 10,
                ),
                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {});
                  },
                  child: TextFormField(
                    focusNode: _addressFocus,
                    controller: _addressController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: _addressFocus.hasFocus ? Colors.white : Colors.grey.withOpacity(0.1),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                      hintText: l10n.addressHint,
                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: AppColors.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return l10n.pleaseEnterAddress;
                      }
                      return null;
                    },
                  ),
                ),


                const SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 20,
                ),

                SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: SimpleButton(
                    text: isEdit! ? l10n.updateAddress : l10n.addAddress,
                    callback: () async {
                      if (_formKey.currentState!.validate()) {


                        if(selectedCountry == null) {
                          Fluttertoast.showToast(msg: l10n.pleaseSelectCountry);
                          return;
                        }

                        if(selectedCity == null) {
                          Fluttertoast.showToast(msg: l10n.pleaseSelectCity);
                          return;
                        }

                        AddressModel addressModel = AddressModel(
                          contactPersonName: _contactPersonNameController.text.trim(),
                          phone: _phoneController.text,
                          phoneCode: selectedCountry!.phoneCode!,
                          country: selectedCountry!.id!,
                          address: _addressController.text.trim(),
                          city: selectedCity!.id!,
                          zip: _postalCodeController.text.trim(),
                          addressType: selectedAddressType!,
                          isBilling: 1,
                          latitude: tappedLocation?.longitude.toString(),
                          longitude: tappedLocation?.latitude.toString(),
                        );

                        if(isEdit!) {
                          addressModel.id = widget.addressData!.id;
                          await checkoutProvider.updateAddress(context, addressModel);
                        }
                        else {
                          await checkoutProvider.addAddress(context, addressModel);
                        }

                        await checkoutProvider.getAllAddresses();

                        if(mounted) {
                          Navigator.pop(context);
                        }

                      }


                    },
                  ),

                ),


                const SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCityBottomSheet(BuildContext context, AppLocalizations l10n) {

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0),),
      ),
      builder: (BuildContext context) {

        final checkoutProvider = context.watch<CheckoutProvider>();

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.selectCity,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16.0),


              TextFormField(
                controller: _citySearchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: 'Search for a city',
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                onChanged: (value) {
                  checkoutProvider.searchCity(value);
                },
              ),

              const SizedBox(height: 16.0),

              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: checkoutProvider.cities!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(checkoutProvider.cities!.data![index].name!),
                      onTap: () {

                        setState(() {
                          selectedCity = checkoutProvider.cities!.data![index];
                        });


                        navigateToCity(selectedCity!.name!);


                        // Handle city selection
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    );
                  },
                ),
              ),

            ],
          ),
        );
      },
    );
  }

  void _showCountryBottomSheet(BuildContext context, AppLocalizations l10n, {bool showCountryCode = false}) {

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0),),
      ),

      builder: (BuildContext context) {

        final checkoutProvider = context.watch<CheckoutProvider>();

        return StatefulBuilder(

          builder: (BuildContext context, StateSetter setState) {

            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.selectCountry,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16.0),


                  TextFormField(
                    controller: _countrySearchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(12.0),
                      hintText: 'Search for a country',
                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: AppColors.primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onChanged: (value) {
                      checkoutProvider.searchCountry(value);
                    },
                  ),

                  const SizedBox(height: 16.0),

                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: checkoutProvider.countriesData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text('${showCountryCode ? '${checkoutProvider.countriesData[index].phoneCode} - ' : ''} ${checkoutProvider.countriesData[index].name!}'),
                          onTap: () async {

                            await checkoutProvider.getCities(checkoutProvider.countriesData[index].id!);

                            setState(() {
                              selectedCountry = checkoutProvider.countriesData[index];
                              selectedCountryCode = checkoutProvider.countriesData[index].phoneCode;
                              selectedCity = null;
                            });

                            navigateToCountry(checkoutProvider.countriesData[index].name!);


                            if(mounted) {
                              // Handle city selection
                              Navigator.pop(context);
                            }

                          },
                        );
                      },
                    ),
                  ),

                ],
              ),
            );
          },
        );
      },
    );
  }


  @override
  void dispose() {
    super.dispose();

    _contactPersonNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _postalCodeController.dispose();

    _contactPersonNameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _addressFocus.dispose();
    _postalCodeFocus.dispose();

    _countrySearchController.dispose();
    _citySearchController.dispose();
  }

}
