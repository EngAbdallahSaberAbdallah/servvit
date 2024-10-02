import 'package:flutter/material.dart';

void logoutDialog(context, {required Function logout}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("تسجيل الخروج"),
            content: const Text("هل انت متأكد من تسجيل الخروج؟"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "إلغاء",
                    style: TextStyle(color: Colors.grey),
                  )),
              TextButton(
                  onPressed: () {
                    logout();
                  },
                  child: const Text("تسجيل الخروج")),
            ],
          ));
}
