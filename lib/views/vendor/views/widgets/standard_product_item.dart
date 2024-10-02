import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/cubits/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/shared_components/login_first.dart';
import '../../../../core/text_styles/app_text_style.dart';
import '../../../../core/utils/navigation_utility.dart';
import '../../../../model/products/vendor_product_model.dart'
    as vendorProductModel;
import '../screens/vendor_product_details.dart';

class StandardProductItem extends StatelessWidget {
  const StandardProductItem({
    super.key,
    required this.data,
    this.clickedIndex,
    this.isFav = false,
  });
  final vendorProductModel.Data data;
  final int? clickedIndex;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      padding: EdgeInsets.all(5.w),
      child: Stack(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  if (CacheKeysManger.getUserTokenFromCache() == "") {
                    defaultLogin(context: context);
                  } else {
                    ProductsCubit.get(context).clickedIndex = clickedIndex;
                    NavigationUtils.navigateTo(
                      context: context,
                      destinationScreen: VendorProductDetails(
                        productData: data,
                      ),
                    );
                  }
                },
                child: Container(
                  height: 222.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: Color.fromRGBO(87, 116, 86, 1),
                      width: 1.w,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 105.h,
                        width: 120.w,
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          // border: Border.all(
                          //   color: Color.fromRGBO(87, 116, 86, 1),
                          //   width: 1.w,
                          // ),
                        ),
                        child:
                            // InkWell(
                            //   onTap: () {
                            //     ProductsCubit.get(context).clickedIndex =
                            //         clickedIndex;
                            //     NavigationUtils.navigateTo(
                            //       context: context,
                            //       destinationScreen: VendorProductDetails(
                            //         productData: data,
                            //       ),
                            //     );
                            //   },
                            //   child:
                            Hero(
                          tag: '${data.id}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.sp),
                            child: CachedNetworkImage(
                              imageUrl: data.image![0],
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) =>
                                  Center(), //child: Icon(Icons.error)
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // ),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 5.h,
                        ),
                        constraints: BoxConstraints(minHeight: 35.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          // border: Border.all(
                          //   color: Color.fromRGBO(87, 116, 86, 1),
                          //   width: 1.w,
                          // ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(data.name!,
                                maxLines: 2,
                                style: AppTextStyle.bodyText().copyWith(
                                    fontSize: 12.sp,
                                    overflow: TextOverflow.fade,
                                    color: AppColors.primaryColor)),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              data.name2 ?? "",
                              style: AppTextStyle.bodyText().copyWith(
                                fontSize: 10.sp,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      if (isFav == false)
                        // if (data.minPrice == "null" && data.maxPrice == "null")
                        //   Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         "price".tr(),
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .bodyLarge!
                        //             .copyWith(
                        //               fontSize: 8.sp,
                        //               color: Color.fromRGBO(87, 116, 86, 1),
                        //             ),
                        //       ),
                        //       SizedBox(height: 2.h),
                        //       Text(
                        //         "no_price".tr(),
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .bodyLarge!
                        //             .copyWith(
                        //               fontSize: 10.sp,
                        //             ),
                        //       ),
                        //     ],
                        //   )
                        // else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                if (data.minPrice != null &&
                                    data.minPrice != "null")
                                  Text(
                                    "${"from".tr()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 8.sp,
                                          color: Color.fromRGBO(87, 116, 86, 1),
                                        ),
                                  ),
                                SizedBox(height: 2.h),
                                if (data.minPrice != null &&
                                    data.minPrice != "null")
                                  Text(
                                    '${data.minPrice}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 10.sp,
                                        ),
                                  ),
                              ],
                            ),
                            SizedBox(width: 5.w),
                            if (data.minPrice != null &&
                                data.minPrice != "null")
                              Text(
                                "ــــ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 10.sp,
                                    ),
                              ),
                            SizedBox(width: 1.w),
                            Column(
                              children: [
                                if (data.maxPrice != null &&
                                    data.maxPrice != "null")
                                  Text(
                                    "${'to'.tr()} ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 8.sp,
                                          color: Color.fromRGBO(87, 116, 86, 1),
                                        ),
                                  ),
                                SizedBox(height: 2.h),
                                if (data.maxPrice != null &&
                                    data.maxPrice != "null")
                                  Text(
                                    '${data.maxPrice}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 10.sp,
                                        ),
                                  ),
                              ],
                            ),
                            // SizedBox(width: 5.w),
                            if ((data.minPrice != null &&
                                    data.minPrice != "null") ||
                                (data.maxPrice != null &&
                                    data.maxPrice != "null"))
                              Text(
                                'egy'.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 7.sp,
                                    ),
                              ),
                          ],
                        ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 7.h),
              SizedBox(
                width: double.infinity,
                height: 27.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (CacheKeysManger.getUserTokenFromCache() == "") {
                      defaultLogin(context: context);
                    } else {
                      ProductsCubit.get(context).clickedIndex = clickedIndex;
                      NavigationUtils.navigateTo(
                        context: context,
                        destinationScreen: VendorProductDetails(
                          productData: data,
                        ),
                      );
                    }
                  },
                  child: Text(
                    "details".tr(),
                    style: AppTextStyle.subTitle()
                        .copyWith(color: Colors.black, fontSize: 13.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    backgroundColor: Color.fromRGBO(186, 210, 88, 1),
                    minimumSize: Size(85.w, 20.h),
                  ),
                ),
              ),
              // //! add to favorite and remove from favorite
              // BlocConsumer<ProductsCubit, ProductsStates>(
              //   listener: (context, state) {
              //     if (state is AddRemoveFavoriteSuccessState) {
              //       toast(text: state.message, color: Colors.green);
              //     }
              //     if (state is AddRemoveFavoriteFailureState) {
              //       toast(text: state.errorMessage, color: Colors.red);
              //     }
              //   },
              //   buildWhen: (previous, current) {
              //     //! to rebuild only the certin product item
              //     if (ProductsCubit.get(context).clickedIndex == clickedIndex) {
              //       return true;
              //     }
              //     return false;
              //   },
              //   builder: (context, state) {
              //     // 1: check if it founded in favorites
              //     // 2: if not founded make "add_to _favorite"
              //     // 3: and make clickable
              //     // 4: if founded make "added_to_favorite"
              //     bool isFav = CacheKeysManger.getFavorites()
              //         .contains(data.id.toString());
              //     return ElevatedButton(
              //       onPressed: () {
              //         ProductsCubit.get(context).clickedIndex = clickedIndex;
              //         ProductsCubit.get(context)
              //             .addToRemoveFromFavorites(data.id!);
              //       },
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text(
              //             isFav
              //                 ? "added_to_favorite".tr()
              //                 : "add_to_favorite".tr(),
              //             style:
              //                 Theme.of(context).textTheme.bodySmall!.copyWith(
              //                       fontSize: 10.sp,
              //                     ),
              //           ),
              //           SizedBox(
              //             width: 3.w,
              //           ),
              //           if (state is AddRemoveFavoriteLoadingState)
              //             SizedBox(
              //               height: 12.h,
              //               width: 15.w,
              //               child: CircularProgressIndicator(
              //                 color: Colors.white,
              //                 strokeWidth: 2,
              //               ),
              //             )
              //         ],
              //       ),
              //       style: ElevatedButton.styleFrom(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20.r),
              //         ),
              //         backgroundColor: Color.fromRGBO(186, 210, 88, 1),
              //         minimumSize: Size(85.w, 20.h),
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
          PositionedDirectional(
            end: 0.w,
            top: 0.h,
            child: BlocConsumer<ProductsCubit, ProductsStates>(
              listener: (context, state) {
                // if (state is AddRemoveFavoriteSuccessState) {
                //   toast(text: state.message, color: Colors.green);
                // }
                // if (state is AddRemoveFavoriteFailureState) {
                //   toast(text: state.errorMessage, color: Colors.red);
                // }
              },
              buildWhen: (previous, current) {
                //! to rebuild only the certin product item
                if (ProductsCubit.get(context).clickedIndex == clickedIndex) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                // 1: check if it founded in favorites
                // 2: if not founded make "add_to _favorite"
                // 3: and make clickable
                // 4: if founded make "added_to_favorite"
                bool isFav =
                    CacheKeysManger.getFavorites().contains(data.id.toString());
                return IconButton(
                  onPressed: () {
                    if (CacheKeysManger.getUserTokenFromCache() != '') {
                      ProductsCubit.get(context).clickedIndex = clickedIndex;
                      ProductsCubit.get(context)
                          .addToRemoveFromFavorites(data.id!);
                    } else {
                      defaultLogin(context: context);
                    }
                  },
                  icon: state is AddRemoveFavoriteLoadingState
                      ? SizedBox(
                          height: 12.h,
                          width: 15.w,
                          child: CircularProgressIndicator(
                            color: Colors.red[900],
                            strokeWidth: 2,
                          ),
                        )
                      : isFav
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red[900],
                              size: 30.w,
                            )
                          : Icon(
                              Icons.favorite_border_outlined,
                              size: 30.w,
                            ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
