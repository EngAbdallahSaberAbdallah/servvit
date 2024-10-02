import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/cubits/all_products/all_products_cubit.dart';
import 'package:echo/cubits/products/products_cubit.dart';
import 'package:echo/model/echo_firendly/echo_friendly_model.dart';
import 'package:echo/views/vendor/views/widgets/animated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/shared_components/login_first.dart';
import '../../../../core/text_styles/app_text_style.dart';
import '../../../../core/utils/navigation_utility.dart';
import 'package:echo/model/products/vendor_product_model.dart' as productModel;

import '../screens/vendor_product_details.dart';

class StandardEchoFriendlyItem extends StatelessWidget {
  const StandardEchoFriendlyItem({
    super.key,
    required this.echoFiendlyModel,
    this.clickedIndex,
    this.isFav = false,
  });
  final EchoFiendlyModel echoFiendlyModel;
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
                  productModel.Data? productData;
                  for (int i = 0;
                      i <
                          AllProductsCubit.get(context)
                              .allProductsModel!
                              .data!
                              .length;
                      i++) {
                    if (echoFiendlyModel.id ==
                        AllProductsCubit.get(context)
                            .allProductsModel!
                            .data![i]
                            .id) {
                      productData = AllProductsCubit.get(context)
                          .allProductsModel!
                          .data![i];
                    }
                  }

                  NavigationUtils.navigateTo(
                    context: context,
                    destinationScreen: VendorProductDetails(
                      productData: productData!,
                    ),
                  );
                },
                child: Container(
                  height: 200.h,
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
                        child: InkWell(
                          onTap: () {
                            if (CacheKeysManger.getUserTokenFromCache() == "") {
                              defaultLogin(context: context);
                            } else {
                              productModel.Data? productData;
                              for (int i = 0;
                                  i <
                                      AllProductsCubit.get(context)
                                          .allProductsModel!
                                          .data!
                                          .length;
                                  i++) {
                                if (echoFiendlyModel.id ==
                                    AllProductsCubit.get(context)
                                        .allProductsModel!
                                        .data![i]
                                        .id) {
                                  productData = AllProductsCubit.get(context)
                                      .allProductsModel!
                                      .data![i];
                                }
                              }

                              NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: VendorProductDetails(
                                  productData: productData!,
                                ),
                              );
                            }
                          },
                          child: Hero(
                            tag: '${echoFiendlyModel.id}',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.sp),
                              child: CachedNetworkImage(
                                imageUrl: echoFiendlyModel.image!,
                                fit: BoxFit.contain,
                                errorWidget: (context, url, error) =>
                                    Center(child: Icon(Icons.error)),
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
                            Text(echoFiendlyModel.name!,
                                maxLines: 2,
                                style: AppTextStyle.bodyText().copyWith(
                                    fontSize: 12.sp,
                                    overflow: TextOverflow.fade,
                                    color: AppColors.primaryColor)),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              echoFiendlyModel.name2 ?? "",
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
                      productModel.Data? productData;
                      for (int i = 0;
                          i <
                              AllProductsCubit.get(context)
                                  .allProductsModel!
                                  .data!
                                  .length;
                          i++) {
                        if (echoFiendlyModel.id ==
                            AllProductsCubit.get(context)
                                .allProductsModel!
                                .data![i]
                                .id) {
                          productData = AllProductsCubit.get(context)
                              .allProductsModel!
                              .data![i];
                        }
                      }

                      NavigationUtils.navigateTo(
                        context: context,
                        destinationScreen: VendorProductDetails(
                          productData: productData!,
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
                bool isFav = CacheKeysManger.getFavorites()
                    .contains(echoFiendlyModel.id.toString());
                return IconButton(
                  onPressed: () {
                    if (CacheKeysManger.getUserTokenFromCache() != '') {
                      ProductsCubit.get(context).clickedIndex = clickedIndex;
                      ProductsCubit.get(context)
                          .addToRemoveFromFavorites(echoFiendlyModel.id!);
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
