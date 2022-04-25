import 'package:flutter/material.dart';

mixin ApiLoadMore {
  bool get hashNextPage;
  set hashNextPage(bool value);
  int get page;
  set page(int value);
  int get limit;
  Future error(res);
  List modelHanlde(data);
  Future apiCall(query);

  static String _offset = 'offset';
  static String _limit = 'limit';
  static String _data = 'data';

  static void config({String? offset, String? limit, String? data}) {
    if (offset != null) {
      _offset = offset;
    }
    if (limit != null) {
      _limit = limit;
    }
    if (data != null) {
      _data = data;
    }
  }

  void nexPage() {
    page = page + limit;
  }

  Future apiGet(isFirst, [Map<String, dynamic>? queries]) async {
    if (isFirst) {
      page = 0;
      hashNextPage = true;
    }
    if (!hashNextPage) throw Exception('No more data');
    Map<String, dynamic> query = {
      _offset: page,
      _limit: '$limit',
    };
    if (queries != null) {
      query.addAll(queries);
    }
    debugPrint('ApiLoadMore $query');
    nexPage();
    final res = await apiCall(query);
    debugPrint('ApiClientgetProductStatus $res');
    if (res['success']) {
      final list = modelHanlde(res[_data]);
      if (list.length < limit) {
        hashNextPage = false;
      }
      return list;
    }
    return error(res);
  }
}
