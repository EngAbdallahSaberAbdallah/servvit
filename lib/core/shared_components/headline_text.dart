import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Headline extends StatelessWidget {
  const Headline({
    super.key,
    required this.text,
    this.action,
    this.trailingText,
    this.fontSize,
  });
  final String text;
  final String? trailingText;
  final void Function()? action;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: fontSize != null
                ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: fontSize!,
                    )
                : Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        if (trailingText != null)
          TextButton(
            onPressed: action,
            child: Text(
              trailingText!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
      ],
    );
  }
}
