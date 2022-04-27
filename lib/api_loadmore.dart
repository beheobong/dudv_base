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
  static int _page = 0;

  static void config({
    String? offset,
    String? limit,
    String? data,
    int? page,
  }) {
    if (offset != null) {
      _offset = offset;
    }
    if (limit != null) {
      _limit = limit;
    }
    if (data != null) {
      _data = data;
    }
    if (page != null) {
      _page = page;
    }
  }

  void nexPage() {
    page = page + limit;
  }

  Future apiGet(isFirst, [Map<String, dynamic>? queries, int? initPage]) async {
    if (isFirst) {
      page = initPage ?? _page;
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
