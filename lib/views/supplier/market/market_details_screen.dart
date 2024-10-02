import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/default_cached_network_image.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/supplier_market/supplier_market_cubit.dart';
import 'package:echo/cubits/supplier_market/supplier_market_states.dart';
import 'package:echo/model/supplier_products/supplier_products_model.dart';
import 'package:echo/views/supplier/edit_market/edit_product_market_new_size_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../core/shared_components/custom_pop_up.dart';
import '../../../cubits/bottom_navbar/bottom_navbar_cubit.dart';
import '../../../layout/main/main_layout.dart';

class MarketDetailsScreen extends StatelessWidget {
  const MarketDetailsScreen(
      {Key? key,
      required this.productSizes,
      required this.image,
      required this.indexNumber,
      required this.name})
      : super(key: key);

  final List<ProductSizes> productSizes;
  final String image;
  final String name;
  final int indexNumber;

  @override
  Widget build(BuildContext context) {
    var cubit = SupplierMarketCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Text(
              name,
              style: AppTextStyle.headLine().copyWith(color: Colors.black),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10.sp),
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          if (productSizes[index].quantity1 !=
                                              "null")
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  bodyItem(
                                                      title:
                                                          "${productSizes[index].quantity1}"),
                                                  SizedBox(height: 5.h),
                                                  bodyItem(
                                                      title:
                                                          "${productSizes[index].price1}"),
                                                ],
                                              ),
                                            ),
                                          if (productSizes[index].quantity2 !=
                                              "null")
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  bodyItem(
                                                      title:
                                                          "${productSizes[index].quantity2 ?? ""}"),
                                                  SizedBox(height: 5.h),
                                                  bodyItem(
                                                      title:
                                                          "${productSizes[index].price2 ?? ""}"),
                                                ],
                                              ),
                                            ),
                                          if (productSizes[index].quantity3 !=
                                              "null")
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  bodyItem(
                                                      title:
                                                          "${productSizes[index].quantity3}"),
                                                  SizedBox(height: 5.h),
                                                  bodyItem(
                                                      title:
                                                          "${productSizes[index].price3}"),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      child: DefaultCachedNetworkImage(
                                          imageUrl: image,
                                          imageHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.12,
                                          fit: BoxFit.fill,
                                          imageWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${"size".tr()} : ${productSizes[index].sizes!.size!}",
                                  style: AppTextStyle.title()
                                      .copyWith(fontSize: 14.sp),
                                ),
                                Text(
                                  "mini_quantity".tr(),
                                  style: AppTextStyle.title(),
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  children: [
                                    Expanded(
                                        child: bodyItem(
                                            title:
                                                "${productSizes[index].quantity1}")),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: DefaultButton(
                                          onPress: () {
                                            NavigationUtils.navigateTo(
                                                context: context,
                                                destinationScreen:
                                                    EditNewSizeProductScreen(
                                                  productData: cubit
                                                      .supplierProductsModel!
                                                      .data![indexNumber]
                                                      .productSizes![index],
                                                  productId: cubit
                                                      .supplierProductsModel!
                                                      .data![indexNumber]
                                                      .productId!,
                                                ));
                                          },
                                          text: "edit".tr(),
                                          height: 4.h,
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    //fayez
                                    BlocConsumer<SupplierMarketCubit,
                                        SupplierMarketStates>(
                                      builder: (BuildContext context, state) {
                                        return SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: DefaultButton(
                                              onPress: () {
                                                context
                                                    .read<SupplierMarketCubit>()
                                                    .disableSize(
                                                        sizeId:
                                                            productSizes[index]
                                                                .id!);
                                              },
                                              backgroundColor:
                                                  productSizes[index].status ==
                                                          "able"
                                                      ? Colors.red
                                                      : Colors.blue,
                                              text:
                                                  productSizes[index].status ==
                                                          "able"
                                                      ? "delete".tr()
                                                      : "run".tr(),
                                              height: 4.h,
                                            ));
                                      },
                                      listener:
                                          (BuildContext context, state) async {
                                        if (state
                                            is DiableProductSizeSuccessState) {
                                          customPopUpDialog(
                                            context: context,
                                            button: DefaultButton(
                                              onPress: () {
                                                Navigator.pop(context);
                                                BottomNavbarCubit.get(context)
                                                    .changeBottomNavbar(1);
                                                NavigationUtils
                                                    .navigateReplacement(
                                                        context: context,
                                                        destinationScreen:
                                                            MainLayout());
                                              },
                                              text: "close".tr(),
                                              borderRadius: 10.sp,
                                            ),
                                            icon: image,
                                            mainTitle:
                                                productSizes[index].status ==
                                                        "able"
                                                    ? "turnOffMessage".tr()
                                                    : "turnOnMessage".tr(),
                                          );
                                        } else if (state
                                            is DiableProductSizeErrorState) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(state.errMessage),
                                            backgroundColor: Colors.red,
                                          ));
                                        } else if (state
                                            is DiableProductSizeLoadingState) {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => WillPopScope(
                                              onWillPop: () {
                                                return Future.value(false);
                                              },
                                              child: AlertDialog(
                                                insetPadding:
                                                    const EdgeInsets.all(0),
                                                contentPadding: EdgeInsets.zero,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                content: SizedBox(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 20),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SpinKitCubeGrid(
                                                          color: AppColors
                                                              .primaryColor,
                                                          size: 40.0,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "loadingLogin".tr(),
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemCount: productSizes.length),
            )
          ],
        ),
      ),
    );
  }

  Widget bodyItem(
          {required String title, double? fontSize, bool isColor = false}) =>
      Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.sp),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.sp),
            border: Border.all(),
          ),
          alignment: AlignmentDirectional.center,
          child: Text(
            title,
            style: AppTextStyle.title().copyWith(
              fontSize: fontSize ?? 13.sp,
            ),
          ),
        ),
      );
}
