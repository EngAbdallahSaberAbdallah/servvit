import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadioListTile extends StatelessWidget {
  const CustomRadioListTile({Key? key, required this.title, required this.value, required this.groupValue, required this.selectedValue,required this.onChange}) : super(key: key);
  final String title;
  final String value;
  final String? groupValue;
  final String selectedValue;
  final Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      activeColor: Colors.green,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.all(3.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
        side: BorderSide(
          color:selectedValue==title?Colors.green: Colors.black.withOpacity(0.1),
        ),
      ),
      title: Text(title),
      value: value,
      groupValue: groupValue,
      onChanged: onChange
    );
  }
}
