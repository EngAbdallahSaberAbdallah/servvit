import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/shared_components/custom_back_button.dart';
import 'package:echo/cubits/customize_request/customize_request_cubit.dart';
import 'package:echo/cubits/design_request/design_request_cubit.dart';
import 'package:echo/views/vendor/views/screens/requests_tab_view/customize_tab_view.dart';
import 'package:echo/views/vendor/views/screens/requests_tab_view/design_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors/app_colors.dart';
import 'custom_product.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward(from: 0);
    getRequests();
  }

  void getRequests() {
    context.read<DesignRequestCubit>().getAllDesignRequests();
    context.read<CustomizeRequestCubit>().getAllCustomizeRequests();
    context.read<DesignRequestCubit>().getAllDesignRequests();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  int indexw = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        leading: CustomBackButton(onPressed: () => Navigator.pop(context)),
        title: Image.asset(
          "assets/images/logo2.png",
          width: 100.w,
          height: 40.h,
          fit: BoxFit.contain,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(
              color: AppColors.primaryColor,
            ),
            tabs: [
              Tab(text: "printed".tr()),
              Tab(text: "customize".tr()),
              Tab(text: "donation".tr()),
            ],
            onTap: (index) {
              setState(() {
                indexw = index;
              });
            },
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: GestureDetector(
              child: TabBarView(
                controller: _tabController,
                children: [
                  DesignTabView(
                    index: 0,
                  ),
                  CustomizeTabView(),
                  DesignTabView(
                    index: 1,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
