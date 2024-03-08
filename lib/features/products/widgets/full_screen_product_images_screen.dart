import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labees/core/util/apis.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

/*
*  Date 12 - Jan-2024
*  Author: Raheel Khan- Abaska Technologies
*  Description: FullScreenProductImagesScreen
*/

class FullScreenProductImagesScreen extends StatefulWidget {
  const FullScreenProductImagesScreen({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<String>? images;

  @override
  State<FullScreenProductImagesScreen> createState() =>
      _FullScreenProductImagesScreenState();
}

class _FullScreenProductImagesScreenState
    extends State<FullScreenProductImagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
                '${APIs.imageBaseURL}${APIs.productImages}${widget.images![index]}'),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            heroAttributes: PhotoViewHeroAttributes(tag: widget.images![index]),
          );
        },
        itemCount: widget.images!.length,
        loadingBuilder: (context, event) => const Center(
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: CupertinoActivityIndicator(),
          ),
        ),
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        pageController: PageController(initialPage: 0),
        onPageChanged: (index) {
          setState(() {});
        },
      ),
    );
  }
}
