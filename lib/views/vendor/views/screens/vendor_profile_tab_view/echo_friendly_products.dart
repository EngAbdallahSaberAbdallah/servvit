import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/shared_components/custom_back_button.dart';
import 'package:echo/core/shared_components/error_widget.dart';
import 'package:echo/core/shared_components/headline_text.dart';
import 'package:echo/core/utils/assets.dart';
import 'package:echo/core/utils/constants.dart';
import 'package:echo/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:echo/cubits/eco_friendly/eco_friendly_cubit.dart';
import 'package:echo/cubits/eco_friendly/eco_friendly_state.dart';
import 'package:echo/views/vendor/views/widgets/build_cart_icon.dart';
import 'package:echo/views/vendor/views/widgets/standard_echo_friendly_item.dart';
import 'package:echo/views/vendor/views/widgets/standard_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class EchoFriendlyProducts extends StatefulWidget {
  EchoFriendlyProducts({
    super.key,
  });

  @override
  State<EchoFriendlyProducts> createState() => _EchoFriendlyProductsState();
}

class _EchoFriendlyProductsState extends State<EchoFriendlyProducts> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "eco".tr(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color.fromRGBO(115, 169, 51, 1),
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: " " + "friendly".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: BlocBuilder<EcoFriendlyCubit, EcoFriendlyState>(
                builder: (context, state) {
                  if (state is GetEchoFriendlyLoadingState) {
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
                  if (state is GetEchoFriendlyErrorState) {
                    return Column(
                      children: [
                        CustomErrorWidget(onTap: () {
                          EcoFriendlyCubit.get(context).getEchoFirendly();
                        }),
                      ],
                    );
                  }
                  return GridView.builder(
                    itemCount:
                        EcoFriendlyCubit.get(context).echoFriendlyModels.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 243.h,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 5.h,
                    ),
                    itemBuilder: (context, index) {
                      return StandardEchoFriendlyItem(
                        echoFiendlyModel: EcoFriendlyCubit.get(context)
                            .echoFriendlyModels[index],
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
