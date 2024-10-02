import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/shared_components/error_widget.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/cubits/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/standard_product_item.dart';

class VendorFavoriteScreen extends StatefulWidget {
  const VendorFavoriteScreen({super.key});

  @override
  State<VendorFavoriteScreen> createState() => _VendorFavoriteScreenState();
}

class _VendorFavoriteScreenState extends State<VendorFavoriteScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ProductsCubit.get(context).getFavoriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = ProductsCubit.get(context);
    return BlocConsumer<ProductsCubit, ProductsStates>(
      listener: (context, state) {
        //! if the user clicked on "added_to_favorite" rebuild with getting favorite products
        if (state is AddRemoveFavoriteSuccessState) {
          ProductsCubit.get(context).getFavoriteProducts();
          // updateFavoriteProductList(context);
        }
        if (state is GetFavoriteProductsSuccessState) {
          // updateFavoriteProductList(context);
        }
        if (state is GetFavoriteProductsFailureState) {
          toast(text: state.errorMessage, color: Colors.red);
        }
        updateFavoriteProductList(context);
      },
      builder: (context, state) {
        if (state is GetFavoriteProductsLoadingState) {
          return Shimmer.fromColors(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 160.h,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[200]!,
          );
        }
        if (state is GetFavoriteProductsSuccessState && cubit.favoriteProducts.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/no_fav.png",color: Colors.grey,width: MediaQuery.of(context).size.width*.3,),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('no_fav'.tr(),style: AppTextStyle.title(),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text('no_fav_desc'.tr(),textAlign: TextAlign.center,style: AppTextStyle.bodyText().copyWith(
                        color: Colors.grey,
                      ),),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        if (state is GetFavoriteProductsFailureState) {
          return Center(
            child: CustomErrorWidget(onTap: () {
              ProductsCubit.get(context).getFavoriteProducts();
            }),
          );
        }
        return GridView.builder(
          itemCount: cubit.favoriteProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 265.h,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
          ),
          itemBuilder: (context, index) {
            return StandardProductItem(
              data: cubit.favoriteProducts[index],
              clickedIndex: index,
              isFav: true,
            );
          },
        );
      },
    );
  }

  void updateFavoriteProductList(BuildContext context) {
    CacheKeysManger.setFavoriteList(
        ProductsCubit.get(context).favoriteProducts.map((e) => e.id.toString()).toList());
  }
}
