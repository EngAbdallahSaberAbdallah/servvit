import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomSplashSlider extends StatelessWidget {
  CustomSplashSlider({Key? key, required this.images}) : super(key: key);
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Image.asset(
        images[itemIndex],
        height: MediaQuery.of(context).size.height * 0.3,
      ),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.3,
        aspectRatio: 1,
        viewportFraction: 1,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(milliseconds: 1500),
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
