import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/*
*  Date 29 - Oct-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: ProductDetailsShimmer
*/

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.all(12),
            width: double.maxFinite,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 100,
          child: Padding(
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
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.maxFinite,
          height: 20,
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
          height: 20,
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
          height: 20,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 240),
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
        const SizedBox(height: 50),
        SizedBox(
          width: double.maxFinite,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 180),
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
        const SizedBox(height: 30),
        SizedBox(
          height: 20,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 20,
                height: 20,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 20,
                height: 20,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 20,
                height: 20,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 20,
                height: 20,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 100,
          child: Padding(
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
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.maxFinite,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 180),
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
          height: 20,
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
          height: 20,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 240),
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
          height: 20,
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
        const SizedBox(height: 50),
      ],
    );
  }
}
