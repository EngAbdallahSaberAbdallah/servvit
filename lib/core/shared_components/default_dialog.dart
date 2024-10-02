import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/navigation_utility.dart';

Future defaultAlertDialog({
  required BuildContext context,
  required String title,
  String? buttonTitle,
  required Widget content,
  void Function()? onPress,
}) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: content,
              actions: [
                TextButton(
                  onPressed: () {
                    NavigationUtils.navigateBack(context: context);
                  },
                  child: const Text("رجوع"),
                ),
                TextButton(
                    onPressed: onPress, child: Text(buttonTitle ?? "ارسال")),
              ],
            ));
