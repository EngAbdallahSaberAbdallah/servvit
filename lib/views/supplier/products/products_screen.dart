import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/shared_components/login_first.dart';
import 'package:echo/core/shared_components/product_item.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/products/products_cubit.dart';
import 'package:echo/views/supplier/products/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/assets.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key, required this.categoryId}) : super(key: key);
  final int categoryId;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    ProductsCubit.get(context)
        .getProductsByCategoryId(categoryId: widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50.h,
          title: Image.asset(
            Assets.imagesLogo2,
            width: 100.w,
            height: 40.h,
            fit: BoxFit.contain,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                Assets.imagesIconBackSquare,
                height: 20.h,
                color: AppColors.primaryColor,
              )),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "products_title".tr(),
                  style: AppTextStyle.headLine().copyWith(color: Colors.black),
                ),
                BlocBuilder<ProductsCubit, ProductsStates>(
                    builder: (context, state) {
                  var cubit = ProductsCubit.get(context);
                  return state is GetAllProductsByCategoryIdLoadingState
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.3),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        )
                      : Expanded(
                          child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 190.h,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 5.h,
                          ),
                          itemBuilder: (context, index) => ProductItem(
                            onTap: () async {
                              if (CacheKeysManger.getUserTokenFromCache() ==
                                  "") {
                                defaultLogin(context: context);
                              } else {
                                NavigationUtils.navigateTo(
                                    context: context,
                                    destinationScreen: ProductDetailsScreen(
                                      productDetails:
                                          cubit.productsModel!.data![index],
                                    ));
                              }
                            },
                            image: cubit.productsModel!.data![index].image![0],
                            // isFav: false,
                            // favoriteOnTap: () {
                            //   SupplierMarketCubit.get(context)
                            //       .addAndRemoveFavorites(
                            //           productId:
                            //               cubit.productsModel!.data![index].id!);
                            // },
                            name: cubit.productsModel!.data![index].name ?? "",

                            name2:
                                cubit.productsModel!.data![index].name2 ?? "",
                          ),
                          itemCount: cubit.productsModel!.data!.length,
                        ));
                }),
              ],
            )));
  }
}
