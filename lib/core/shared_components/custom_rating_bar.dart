import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  CustomRatingBar({Key? key, required this.rate, this.onChange, this.readOnly=false,this.itemSize=18})
      : super(key: key);
  int rate;
  Function? onChange;
  bool readOnly;
  double itemSize;
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: rate.toDouble(),
      minRating: 1,
      direction: Axis.horizontal,
      itemCount: 5,
      itemSize: itemSize,
      ignoreGestures: readOnly,
      allowHalfRating: true,
      ratingWidget: RatingWidget(
        empty:  Icon(
          Icons.star_border,
          color: AppColors.secondaryColor,
        ),
        half:  Icon(
          Icons.star_half,
          color: AppColors.secondaryColor,
        ),
        full:  Icon(
          Icons.star,
          color: AppColors.secondaryColor,
        ),
      ),
      onRatingUpdate: (rating) {
        if (onChange != null) {
          onChange!(rating.toDouble());
        }
      },
    );
  }
}