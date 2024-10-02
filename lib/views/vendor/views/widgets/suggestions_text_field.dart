import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/views/vendor/views/widgets/scroll_header_delegete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/services/local/cache_helper/cache_keys.dart';
import '../../../../cubits/main/main_cubit.dart';
import '../../../../model/search/search_suggestions.dart';


class SuggestionsTextField extends StatelessWidget {
  SuggestionsTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.onPressed,
    required this.onSubmitted,
  });

  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final VoidCallback? onPressed;
  final ValueSetter<SearchSuggestionsModel> onSubmitted;
  final SuggestionsBoxController controller = SuggestionsBoxController();

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<SearchSuggestionsModel>(
      suggestionsCallback: (pattern) async {
        final suggestions = await MainCubit.get(context).search(pattern);
        debugPrint('Suggestions: $suggestions');
        return suggestions;
      },
      loadingBuilder: (context) {
        return Center(
          child: Text('loading'.tr()),
        );
      },
      itemSeparatorBuilder: (context, index) {
        return Divider(
          height: 10.h,
          color: Colors.grey[300],
          thickness: 1.h,
          endIndent: 5.w,
          indent: 5.w,
        );
      },
      hideSuggestionsOnKeyboardHide: true,
      layoutArchitecture: (items, controller) {
        var catCount = MainCubit.get(context).catCount;
        var proCount = MainCubit.get(context).proCount;

        return CustomScrollView(
          shrinkWrap: true,
          slivers: [
            if (catCount != 0)
              SliverPersistentHeader(
                pinned: false,
                delegate: SliverHeaderDelegate(
                  maxHeight: 30.h,
                  minHeight: 25.h,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsetsDirectional.only(bottom: 5.h),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      child: Text(
                        'categories'.tr(),
                        style: AppTextStyle.title().copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            SliverList.separated(
              itemBuilder: (context, index) => items.toList()[index],
              itemCount: items.take(catCount).length,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 10.h,
                  color: Colors.grey[300],
                  thickness: 1.h,
                  endIndent: 5.w,
                  indent: 5.w,
                );
              },
            ),
            if (proCount != 0)
              SliverPersistentHeader(
                pinned: false,
                delegate: SliverHeaderDelegate(
                  maxHeight: 30.h,
                  minHeight: 25.h,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsetsDirectional.only(bottom: 5.h),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      child: Text(
                        'products'.tr(),
                        style: AppTextStyle.title().copyWith(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            SliverList.separated(
              itemBuilder: (context, index) => items.skip(catCount).toList()[index],
              itemCount: items.skip(catCount).length,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 10.h,
                  color: Colors.grey[300],
                  thickness: 1.h,
                  endIndent: 5.w,
                  indent: 5.w,
                );
              },
            ),
          ],
        );
      },
      noItemsFoundBuilder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'no_result'.tr(),
            style: TextStyle(fontSize: 12.sp),
          ),
        );
      },
      hideOnEmpty: true,
      itemBuilder: (context, itemData) {
        return ListTile(
          onTap: onPressed,
          contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
          title: Text(
            CacheKeysManger.getLanguageFromCache() == 'ar'
                ? itemData.arName
                : itemData.enName,
            style: AppTextStyle.subTitle(),
          ),
        );
      },
      onSuggestionSelected: onSubmitted,
      minCharsForSuggestions: 1,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * .6),
      ),
      suggestionsBoxController: controller,
      textFieldConfiguration: TextFieldConfiguration(
        onTapOutside: (event) {
          if (controller.suggestionsBox != null) {
            controller.suggestionsBox!.close();
          }
          FocusManager.instance.primaryFocus!.unfocus();
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
          ),
          fillColor: Colors.grey.shade100,
          hintText: hintText,
          floatingLabelStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: suffixIcon ?? IconButton(icon: Icon(Icons.search), onPressed: onPressed),
        ),
      ),
    );
  }
}




// class SuggestionsTextField extends StatelessWidget {
//   SuggestionsTextField({
//     super.key,
//     this.hintText,
//     this.labelText,
//     this.suffixIcon,
//     this.onPressed,
//     required this.onSubmitted,
//   });

//   final String? hintText;
//   final String? labelText;
//   final Widget? suffixIcon;
//   final VoidCallback? onPressed;
//   final ValueSetter<SearchSuggestionsModel> onSubmitted;
//   final SuggestionsBoxController controller = SuggestionsBoxController();
//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadField<SearchSuggestionsModel>(

//       suggestionsCallback: (pattern) async {
//         return MainCubit.get(context).search(pattern);
//       },
//       loadingBuilder: (context) {
//         return Center(
//           child: Text('loading'.tr()),
//         );
//       },
//       itemSeparatorBuilder: (context, index) {
//         return Divider(
//           height: 10.h,
//           color: Colors.grey[300],
//           thickness: 1.h,
//           endIndent: 5.w,
//           indent: 5.w,
//         );
//       },
//       hideSuggestionsOnKeyboardHide: true,

//       layoutArchitecture: (items, controller) {
//         var catCount = MainCubit.get(context).catCount;
//         var proCount = MainCubit.get(context).proCount;
//         return CustomScrollView(
//           shrinkWrap: true,
//           slivers: [
//             if (catCount != 0)
//               SliverPersistentHeader(
//                 pinned: false,
//                 delegate: SliverHeaderDelegate(
//                   maxHeight: 30.h,
//                   minHeight: 25.h,
//                   child: FittedBox(
//                     fit: BoxFit.contain,
//                     child: Container(
//                       alignment: Alignment.center,
//                       margin: EdgeInsetsDirectional.only(bottom: 5.h),
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
//                       child: Text(
//                         'categories'.tr(),
//                         style:
//                             AppTextStyle.title().copyWith(color: Colors.white),
//                         textAlign: TextAlign.center,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.r),
//                         color: AppColors.primaryColor,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             SliverList.separated(
//               itemBuilder: (context, index) => items.toList()[index],
//               itemCount: items.take(catCount).length,
//               separatorBuilder: (context, index) {
//                 return Divider(
//                   height: 10.h,
//                   color: Colors.grey[300],
//                   thickness: 1.h,
//                   endIndent: 5.w,
//                   indent: 5.w,
//                 );
//               },
//               // children: items.take(catCount).toList(),
//             ),
//             if (proCount != 0)
//               SliverPersistentHeader(
//                 pinned: false,
//                 delegate: SliverHeaderDelegate(
//                   maxHeight: 30.h,
//                   minHeight: 25.h,
//                   child: FittedBox(
//                     fit: BoxFit.contain,
//                     child: Container(
//                       alignment: Alignment.center,
//                       margin: EdgeInsetsDirectional.only(bottom: 5.h),
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
//                       child: Text(
//                         'products'.tr(),
//                         style:
//                             AppTextStyle.title().copyWith(color: Colors.white),
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.r),
//                         color: AppColors.primaryColor,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             SliverList.separated(
//               itemBuilder: (context, index) =>
//                   items.skip(catCount).toList()[index],
//               itemCount: items.skip(catCount).length,
//               separatorBuilder: (context, index) {
//                 return Divider(
//                   height: 10.h,
//                   color: Colors.grey[300],
//                   thickness: 1.h,
//                   endIndent: 5.w,
//                   indent: 5.w,
//                 );
//               },
//               // children: items.skip(catCount).toList(),
//             ),
//           ],
//         );
//       },
//       noItemsFoundBuilder: (context) {
//         return Container(
//           padding: EdgeInsets.all(10),
//           child: Text(
//             'no_result'.tr(),
//             style: TextStyle(
//               fontSize: 12.sp,
//             ),
//           ),
//         );
//       },
//       hideOnEmpty: true,
//       itemBuilder: (context, itemData) {
//         return ListTile(
//           // title: Text(
//           //   itemData.type,
//           //   style: TextStyle(
//           //     color: AppColors.primaryColor,
//           //   ),
//           // ),
//           onTap: onPressed,
//           contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
//           title: Text(
//             CacheKeysManger.getLanguageFromCache() == 'ar'
//                 ? itemData.arName
//                 : itemData.enName,
//             style: AppTextStyle.subTitle(),
//           ),
//         );
//       },
//       onSuggestionSelected: onSubmitted,
//       minCharsForSuggestions: 1,
//       suggestionsBoxDecoration: SuggestionsBoxDecoration(
//         borderRadius: BorderRadius.circular(30.r),
//         constraints:
//             BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * .6),
//       ),
//       suggestionsBoxController: controller,
//       textFieldConfiguration: TextFieldConfiguration(
//         onTapOutside: (event) {
//           if (controller.suggestionsBox != null) {
//             controller.suggestionsBox!.close();
//           }
//           FocusManager.instance.primaryFocus!.unfocus();
//         },
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(
//             vertical: 10.h,
//             horizontal: 10.w,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(
//                 30.r,
//               ),

//             ),
//             borderSide: BorderSide(
//               color: AppColors.primaryColor,
//               width: 1,
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(
//                 30.r,
//               ),
//             ),
//             borderSide: BorderSide(
//               color: AppColors.primaryColor,
//               width: 1,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(
//                 30.r,
//               ),
//             ),
//             borderSide: BorderSide(
//               color: AppColors.primaryColor,
//               width: 1,
//             ),
//           ),
//           fillColor: Colors.grey.shade100,
//           hintText: hintText,
//           floatingLabelStyle: TextStyle(
//             color: AppColors.primaryColor,
//             fontSize: 16,
//             fontWeight: FontWeight.w500
//           ),
//           suffixIcon: suffixIcon ??
//               IconButton(icon: Icon(Icons.search), onPressed: onPressed),
//         ),
//       ),
//     );
//   }
// }
