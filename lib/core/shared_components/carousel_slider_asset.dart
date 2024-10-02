import 'package:carousel_slider/carousel_slider.dart';
import 'package:echo/core/shared_components/default_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselSliderAsset extends StatelessWidget {
  CarouselSliderAsset({
    Key? key,
    required this.images,
    this.imageHeight,
  }) : super(key: key);
  final List<String> images;
  final double? imageHeight;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
      images.isNotEmpty
          ? Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(15.sp),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          width: double.infinity,
          fit: BoxFit.fill,
          height:
          imageHeight ?? MediaQuery.of(context).size.height * 0.15, images[itemIndex],
        ),
      )
          : Container(
        color: Colors.grey.shade100,
      ),
      options: CarouselOptions(
        height: imageHeight ?? MediaQuery.of(context).size.height * 0.2,
        aspectRatio: 1,
        viewportFraction: 1.2,
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
