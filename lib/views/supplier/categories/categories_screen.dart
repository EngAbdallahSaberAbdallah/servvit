import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/shared_components/default_cached_network_image.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/assets.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/all_categories/all_categories_cubit.dart';
import 'package:echo/cubits/all_categories/all_categories_state.dart';
import 'package:echo/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:echo/views/supplier/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    AllCategoriesCubit.get(context).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<BottomNavbarCubit, BottomNavbarState>(
        builder: (context, state) =>WillPopScope(
          onWillPop: ()async{
           setState(() {
              context.read<BottomNavbarCubit>().counterHomeScreen = 0;
           });
            return true;
          },
          child: Scaffold(
          // appBar: AppBar(
          //   toolbarHeight: 50.h,
          //   title: Image.asset(
          //     "assets/images/logo2.png",
          //     width: 100.w,
          //     height: 40.h,
          //     fit: BoxFit.contain,
          //   ),
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          //   leading: IconButton(
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //       icon: SvgPicture.asset(
          //         Assets.imagesIconBackSquare,
          //         height: 20.h,
          //         color: AppColors.primaryColor,
          //       )),
          // ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Text(
                  "categories".tr(),
                  style: AppTextStyle.headLine().copyWith(color: Colors.black),
                ),
              ),
              BlocBuilder<AllCategoriesCubit, AllCategoriesState>(
                builder: (context, state) {
                  var cubit = AllCategoriesCubit.get(context);
                  return state is GetAllCategoriesLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20.w,
                              mainAxisSpacing: 10.h,
                              childAspectRatio: .9,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                NavigationUtils.navigateTo(
                                  context: context,
                                  destinationScreen: ProductsScreen(
                                      categoryId: cubit
                                          .allCategoriesModel!.data![index].id!),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.15,
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.sp),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: DefaultCachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: cubit.allCategoriesModel!
                                            .data![index].image!,
                                        imageHeight:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        imageWidth:
                                            MediaQuery.of(context).size.width *
                                                0.3),
                                  ),
                                  SizedBox(height: 10.h),
                                  Expanded(
                                    child: Text(
                                      cubit.allCategoriesModel!.data![index].name!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.title().copyWith(
                                          color: Colors.black, fontSize: 14.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            itemCount: cubit.allCategoriesModel!.data!.length,
                          ),
                        );
                },
              ),
            ],
          ),
                
              ),
    ));
  }
}
