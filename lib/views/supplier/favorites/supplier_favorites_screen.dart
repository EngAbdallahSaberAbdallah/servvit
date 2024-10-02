import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/shared_components/product_item.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/cubits/supplier_market/supplier_market_cubit.dart';
import 'package:echo/cubits/supplier_market/supplier_market_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupplierFavoritesScreen extends StatefulWidget {
  const SupplierFavoritesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SupplierFavoritesScreen> createState() =>
      _SupplierFavoritesScreenState();
}

class _SupplierFavoritesScreenState extends State<SupplierFavoritesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SupplierMarketCubit.get(context).getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Text(
            "fav_product".tr(),
            style: AppTextStyle.headLine().copyWith(color: Colors.black),
          ),
        ),
        SizedBox(height: 10.h),
        BlocBuilder<SupplierMarketCubit, SupplierMarketStates>(
            builder: (context, state) {
          var cubit = SupplierMarketCubit.get(context);
          return state is GetFavoritesLoadingState
              ? const Center(child: CircularProgressIndicator())
              : cubit.favoritesModel!.data!.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 190.h,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 5.h,
                        // childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, index) => ProductItem(
                        // onTap: () {
                        //   // NavigationUtils.navigateTo(
                        //   //     context: context, destinationScreen: ProductDetailsScreen(
                        //   //   productDetails: cubit.favoritesModel.data[index].product ,
                        //   // ));
                        // },
                        image: cubit
                            .favoritesModel!.data![index].product!.image![0],
                        // isFav: true,
                        // favoriteOnTap: () {
                        //   SupplierMarketCubit.get(context)
                        //       .addAndRemoveFavorites(productId: cubit.favoritesModel!.data![index].product!.id!);
                        // },
                        name: cubit.favoritesModel!.data![index].product!.name!,
                        name2: '',
                      ),
                      itemCount: cubit.favoritesModel!.data!.length,
                    ))
                  : Center(
                      child: Text(
                      "no_fav".tr(),
                      style: AppTextStyle.subTitle(),
                    ));
        }),
      ],
    );
  }
}
