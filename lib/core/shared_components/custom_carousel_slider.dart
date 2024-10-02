import 'package:carousel_slider/carousel_slider.dart';
import 'package:echo/core/shared_components/default_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarouselItem extends StatelessWidget {
  CustomCarouselItem({
    Key? key,
    required this.images,
    this.imageHeight,
    this.viewportFraction,
  }) : super(key: key);
  final List<String> images;
  final double? imageHeight;
  final double? viewportFraction;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          images.isNotEmpty
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: DefaultCachedNetworkImage(
                    imageWidth: double.infinity,
                    fit: BoxFit.contain,
                    imageHeight:
                        imageHeight ?? MediaQuery.of(context).size.height * 0.2,
                    imageUrl: images[itemIndex],
                  ),
                )
              : Container(
                  color: Colors.grey.shade100,
                ),
      options: CarouselOptions(
        height: imageHeight ?? MediaQuery.of(context).size.height * 0.2,
        aspectRatio: 1,
        viewportFraction: viewportFraction ?? 1,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
