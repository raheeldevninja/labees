import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/core/models/orders_response.dart';

/*
*  Date 16 - Mar-2024
*  Author: Raheel Khan- Abaska Technologies
*  Description: TrackOrderScreen
*/

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({
    super.key,
    required this.orderData,
  });

  final OrderData orderData;

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(l10n.trackOrderTitle,
            style: const TextStyle(color: AppColors.primaryColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          ///order id
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.red.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppColors.red,
                  ),
                ),
                child: Text(
                  '${l10n.orderLabel} #${widget.orderData.id}',
                  style: const TextStyle(color: AppColors.red),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///order status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${l10n.statusLabel}: '),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.orange,
                      ),
                    ),
                    child: Text(
                      widget.orderData.orderStatus!,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.orange),
                    ),
                  ),
                ],
              ),

              ///payment status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${l10n.paymentStatus}: '),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.orange,
                      ),
                    ),
                    child: Text(
                      widget.orderData.paymentStatus!,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          //estimated delivery date

          widget.orderData.orderStatus != 'delivered' &&
                  widget.orderData.orderStatus != 'returned' &&
                  widget.orderData.orderStatus != 'canceled'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${l10n.estimatedDelivery}: '),
                        const SizedBox(height: 8),
                        Text(
                          widget.orderData.expectedDeliveryDate ?? '',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )
              : const SizedBox(),

          ///order status returned
          widget.orderData.orderStatus == 'returned'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.orderReturned,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : const SizedBox(),

          ///order status failed
          widget.orderData.orderStatus == 'failed'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.cannotCompleteOrder,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : const SizedBox(),

          ///steps
          widget.orderData.orderStatus != 'returned' &&
                  widget.orderData.orderStatus != 'failed'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    ///step 1
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: const Icon(Icons.check, color: Colors.white),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l10n.firstStep),
                            const SizedBox(height: 8),
                            Text(
                              l10n.orderPlacedLabel,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    ///step 2
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                widget.orderData.orderStatus == 'processing' ||
                                        widget.orderData.orderStatus ==
                                            'processed' ||
                                        widget.orderData.orderStatus ==
                                            'out_for_delivery' ||
                                        widget.orderData.orderStatus ==
                                            'delivered'
                                    ? Colors.green
                                    : Colors.grey.withOpacity(0.3),
                          ),
                          child: widget.orderData.orderStatus == 'processing' ||
                                  widget.orderData.orderStatus == 'processed' ||
                                  widget.orderData.orderStatus ==
                                      'out_for_delivery' ||
                                  widget.orderData.orderStatus == 'delivered'
                              ? const Icon(Icons.check, color: Colors.white)
                              : const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l10n.secondStep),
                            const SizedBox(height: 8),
                            Text(
                              l10n.packingOrderLabel,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),

                    ///third step
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.orderData.orderStatus ==
                                        'out_for_delivery' ||
                                    widget.orderData.orderStatus == 'delivered'
                                ? Colors.green
                                : Colors.grey.withOpacity(0.3),
                          ),
                          child: widget.orderData.orderStatus ==
                                      'out_for_delivery' ||
                                  widget.orderData.orderStatus == 'delivered'
                              ? const Icon(Icons.check, color: Colors.white)
                              : const Icon(Icons.close, color: Colors.black),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l10n.thirdStep),
                            const SizedBox(height: 8),
                            Text(
                              l10n.preparingShipmentLabel,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    ///fourth step
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.orderData.orderStatus == 'delivered'
                                ? Colors.green
                                : Colors.grey.withOpacity(0.3),
                          ),
                          child: widget.orderData.orderStatus == 'delivered'
                              ? const Icon(Icons.check, color: Colors.white)
                              : const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l10n.forthStep),
                            const SizedBox(height: 8),
                            Text(
                              l10n.orderShippedLabel,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
