import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:location_screen/attendence_store/model/members.dart';

class ProductRepo {
  static Future<List<Member>> loadAllMembers() async {
    final response = await rootBundle.loadString('assets/members.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Member.fromJson(json as Map<String, dynamic>)).toList();
  }
}