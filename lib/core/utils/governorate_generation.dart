import 'dart:convert';

import 'package:flutter/services.dart';

class GovernoratorsGenerator {
  GovernoratorsGenerator._();

  static Future<Iterable<Governorator>> generate() async {
    return await rootBundle
        .loadString('assets/governorators_of_egypt/governorators.json')
        .then((value) {
      return (jsonDecode(value) as List).map((e) => Governorator.fromMap(e));
    });
  }
}

class Governorator {
  String id;
  String ar;
  String en;

  Governorator({
    required this.id,
    required this.ar,
    required this.en,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ar': ar,
      'en': en,
    };
  }

  factory Governorator.fromMap(Map<String, dynamic> map) {
    return Governorator(
      id: map['id'] as String,
      ar: map['ar'] as String,
      en: map['en'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Governorator.fromJson(String source) =>
      Governorator.fromMap(json.decode(source) as Map<String, dynamic>);
}
