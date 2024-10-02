import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/cubits/main/main_cubit.dart';
import 'package:echo/cubits/main/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/services/local/cache_helper/cache_keys.dart';
import '../../../../core/shared_components/custom_popup_review.dart';
import '../../../../core/shared_components/login_first.dart';
import '../../../../core/utils/assets.dart';
import '../widgets/review_item.dart';

class CustomersReviewsScreen extends StatefulWidget {
  const CustomersReviewsScreen({super.key});

  @override
  State<CustomersReviewsScreen> createState() => _CustomersReviewsScreenState();
}

class _CustomersReviewsScreenState extends State<CustomersReviewsScreen> {
  var messageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<MainCubit>().getAllReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "customer_reviews".tr(),
          style: AppTextStyle.title(),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          if (state is GetAllReviewsSuccessState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: state.model.data!.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                            child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ReviewItem(
                              img: state.model.data![index].client!.image!,
                              description:
                                  state.model.data![index].description!,
                              name: state.model.data![index].client!.name!,
                            );
                          },
                          itemCount: state.model.data!.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 10.h,
                            );
                          },
                        ))
                      ],
                    )
                  :  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/no_sessions.svg",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * .4,
                          ),
                        ],
                      ),
                    ],
                  ),
            );
          }
          else if (state is GetAllReviewsLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (state is GetAllReviewsErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          else {
            return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          if(CacheKeysManger.getUserTokenFromCache()=="")
          {
            defaultLogin(context: context);
          }else{
            customPopUpReview(
                context: context, message: messageController, formKey: formKey);
          }

        },
        label: Text(
          'add_review'.tr(),
          style: TextStyle(color: Colors.white),
        ),
        icon: Image.asset(
          Assets.imagesCustomerReviews,
          width: MediaQuery.of(context).size.width * .08,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
