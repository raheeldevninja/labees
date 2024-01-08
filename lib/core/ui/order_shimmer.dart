import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


/*
*  Date 4 - Now-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: OrdersShimmer
*/


class OrdersShimmer extends StatelessWidget {
  const OrdersShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  width: double.maxFinite,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
            ),


            Expanded(
              child: Column(
                children: [

                  Container(
                    width: 100,
                    padding: const EdgeInsets.only(left: 16, right: 200),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),


                  SizedBox(
                    width: double.maxFinite,
                    height: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 40),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.maxFinite,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.maxFinite,
                    height: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 20),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.maxFinite,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.maxFinite,
                    height: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 80),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.maxFinite,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),


          ],
        ),

        const SizedBox(height: 10),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  width: double.maxFinite,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
            ),


            Expanded(
              child: Column(
                children: [

                  Container(
                    width: 100,
                    padding: const EdgeInsets.only(left: 16, right: 200),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),


                  SizedBox(
                    width: double.maxFinite,
                    height: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 40),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.maxFinite,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.maxFinite,
                    height: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 20),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.maxFinite,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.maxFinite,
                    height: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 80),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.maxFinite,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),


          ],
        ),

        const SizedBox(height: 10),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  width: double.maxFinite,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
            ),


            Expanded(
              child: Column(
                children: [

                  Container(
                    width: 100,
                    padding: const EdgeInsets.only(left: 16, right: 200),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),


                  SizedBox(
                    width: double.maxFinite,
                    height: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 40),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.maxFinite,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.maxFinite,
                    height: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 20),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.maxFinite,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.maxFinite,
                    height: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 80),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.maxFinite,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),


          ],
        ),
      ],
    );
  }
}
