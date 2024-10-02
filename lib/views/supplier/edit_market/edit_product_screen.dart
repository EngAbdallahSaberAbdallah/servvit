import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/shared_components/custom_dropdown_formfield.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/default_cached_network_image.dart';
import 'package:echo/core/shared_components/default_text_form_field.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/assets.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:echo/cubits/supplier_market/supplier_market_cubit.dart';
import 'package:echo/cubits/supplier_market/supplier_market_states.dart';
import 'package:echo/layout/main/main_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/supplier_products/supplier_products_model.dart';

class EditProductMarketScreen extends StatefulWidget {
  EditProductMarketScreen({
    Key? key,
    required this.productDetails,
  }) : super(key: key);

  final Data productDetails;

  @override
  State<EditProductMarketScreen> createState() =>
      _EditProductMarketScreenState();
}

class _EditProductMarketScreenState extends State<EditProductMarketScreen> {
  // final List<String> colors;
  var fromController = TextEditingController();

  var toController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fromController.text=widget.productDetails.from!;
    // toController.text=widget.productDetails.to!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50.h,
            title: Image.asset(
              "assets/images/logo2.png",
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
              ),
            )),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        "Quantity",
                        style: AppTextStyle.headLine()
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    DefaultCachedNetworkImage(
                        imageUrl: widget.productDetails.products!.image![0],
                        imageHeight: MediaQuery.of(context).size.height * 0.3,
                        imageWidth: MediaQuery.of(context).size.width * 0.8),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Delivery Time",
                          style: AppTextStyle.title()
                              .copyWith(color: Colors.black),
                        )),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "From",
                                style: AppTextStyle.title()
                                    .copyWith(color: Colors.black),
                              ),
                              SizedBox(height: 5.h),
                              DefaultTextFormField(
                                textInputType: TextInputType.number,
                                controller: fromController,
                                hintText: "Days",
                                borderRadius: 30.sp,
                                validationMsg: "this field is required",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "To",
                                style: AppTextStyle.title()
                                    .copyWith(color: Colors.black),
                              ),
                              SizedBox(height: 5.h),
                              DefaultTextFormField(
                                textInputType: TextInputType.number,
                                controller: toController,
                                hintText: "Days",
                                borderRadius: 30.sp,
                                validationMsg: "this field is required",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    BlocConsumer<SupplierMarketCubit, SupplierMarketStates>(
                      listener: (context, state) {
                        if (state is EditProductFromMarketSuccessState) {
                          toast(text: state.message, color: Colors.green);
                          BottomNavbarCubit.get(context).changeBottomNavbar(2);
                          NavigationUtils.navigateReplacement(
                              context: context,
                              destinationScreen: MainLayout());
                        }
                      },
                      builder: (context, state) =>
                          state is EditProductFromMarketLoadingState
                              ? const Center(child: CircularProgressIndicator())
                              : DefaultButton(
                                  onPress: () {
                                    if (formKey.currentState!.validate()) {
                                      SupplierMarketCubit.get(context)
                                          .editProductFromMarket(
                                        supplierProductId:
                                            widget.productDetails.id!,
                                        from: fromController.text,
                                        to: toController.text,
                                      );
                                    }
                                  },
                                  text: "Edit",
                                  backgroundColor: AppColors.secondaryColor,
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
