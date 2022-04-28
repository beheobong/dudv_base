import 'dart:convert';

import 'package:flutter/material.dart';

abstract class ApiClient {
  ApiClient(this.contex) {
    init();
  }

  final BuildContext contex;
  bool hashNextPage = true;
  final int limit = 40;
  int page = 0;

  void init() {}

  Future errorHandle(Map<String, dynamic> res) async {
    if (res['Data'] is Map<String, dynamic> &&
        res['Data'].containsKey('Message')) {
      throw BaseException(res['Data']['Message']);
    } else if (res.containsKey('message') && res['message'] != null) {
      throw BaseException(json.encode(res));
    } else if (res.containsKey('Message') && res['Message'] != null) {
      throw BaseException(res['Message']);
    }
    throw BaseException('Đã có lỗi xảy ra');
  }
}

class BaseException implements Exception {
  BaseException(this.message);

  final String? message;

  @override
  String toString() {
    if (message == null) return "Exception";
    return message!;
  }
}
