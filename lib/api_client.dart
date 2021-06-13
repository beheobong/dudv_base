import 'package:flutter/material.dart';

abstract class ApiClient {
  final int limit = 40;
  final BuildContext contex;

  ApiClient(this.contex) {
    init();
  }

  void init() async {}

  int page = 0;
  bool hashNextPage = true;
  Future errorHandle(Map<String, dynamic> res) async {
    if (res.containsKey('message') && res['message'] != null) {
      throw BaseException(res['message']);
    }
    throw BaseException('Something was wrong');
  }
}

class BaseException implements Exception {
  final message;

  BaseException([this.message]);

  String toString() {
    if (message == null) return "Exception";
    return message;
  }
}
