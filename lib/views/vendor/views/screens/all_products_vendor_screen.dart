import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/shared_components/custom_back_button.dart';
import 'package:echo/core/shared_components/error_widget.dart';
import 'package:echo/core/shared_components/headline_text.dart';
import 'package:echo/core/utils/constants.dart';
import 'package:echo/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:echo/views/vendor/views/widgets/build_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/assets.dart';
import '../../../../cubits/all_products/all_products_cubit.dart';
import '../widgets/standard_product_item.dart';

class AllProductsVendorScreen extends StatefulWidget {
  AllProductsVendorScreen({
    super.key,
  });

  @override
  State<AllProductsVendorScreen> createState() =>
      _AllProductsVendorScreenState();
}

class _AllProductsVendorScreenState extends State<AllProductsVendorScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50.h,
        leading: CustomBackButton(
          onPressed: () {
            context.read<BottomNavbarCubit>().changeBottomNavbar(0);
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          Assets.imagesLogo2,
          width: 100.w,
          height: 40.h,
          fit: BoxFit.contain,
        ),
        actions: CacheKeysManger.getUserTokenFromCache() == ""
            ? null
            : [BuildCartIcon()],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// products
            Headline(
              text: 'all_products'.tr(),
              fontSize: 18.sp,
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: BlocBuilder<AllProductsCubit, AllProductsStates>(
                builder: (context, state) {
                  if (state is GetAllProductsLoadingState) {
                    return Shimmer.fromColors(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 160.h,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                        ),
                        itemCount: 4,
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
                  if (state is GetAllProductsErrorState) {
                    return Column(
                      children: [
                        CustomErrorWidget(onTap: () {
                          AllProductsCubit.get(context).getAllProducts();
                        }),
                      ],
                    );
                  }
                  return GridView.builder(
                    itemCount: AllProductsCubit.get(context)
                        .allProductsModel!
                        .data!
                        .length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 265.h,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 5.h,
                    ),
                    itemBuilder: (context, index) {
                      return StandardProductItem(
                        data: AllProductsCubit.get(context)
                            .allProductsModel!
                            .data![index],
                        clickedIndex: index,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
