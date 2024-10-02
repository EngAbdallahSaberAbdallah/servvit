import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
/// this method is used to convert number to compact format
///
/// [compact format] means that the number will be converted to K,M,B,T
/// compact representations, e.g. "1.2M" instead of "1,200,000".
///
/// if the number is greater than [convertAfter] it will be converted to compact format
///
/// else it will be converted to normal format with comma like this 1,000,000
///
/// [convertAfter] default value is 0 and it means that all numbers will be converted to compact format
///
/// [convertAfter] value is 3 it means that all numbers greater than 3 will be converted to compact format
///
String getNumberFormat(
  String? number, {
  int? convertAfter,
}) {
  if (number == null) {
    return 'null';
  } else {
    if (convertAfter != null) {
      if (number.length >= convertAfter) {
        return NumberFormat.compact(
                locale: CacheKeysManger.getLanguageFromCache())
            .format(double.parse(number));
      }
    }
    return NumberFormat('#,###', CacheKeysManger.getLanguageFromCache())
        .format(double.parse(number));
  }
}

extension FormatingNumber on int {
  String ft() {
    return NumberFormat('####', 'ar').format(this);
  }

  static final List<String> arabics = [
    '٠',
    '١',
    '٢',
    '٣',
    '٤',
    '٥',
    '٦',
    '٧',
    '٨',
    '٩'
  ];

  num cvt() {
    var res = StringBuffer();
    if (CacheKeysManger.getLanguageFromCache() == 'ar') {
      this.toString().characters.forEach((element) {
        res.write(arabics[int.parse(element)]);
      });
    }
    return num.parse(res.toString());
  }
}
