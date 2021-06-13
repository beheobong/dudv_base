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

  Future apiGet(isFirst,Map<String, dynamic> queries) async {
    if (isFirst) {
      page = 0;
      hashNextPage = true;
    }
    if (!hashNextPage) throw Exception('No more data');
    Map<String, dynamic> query = {'offset': page, 'limit': '$limit'};
    if (queries != null) {
      query.addAll(queries);
    }
    debugPrint('ApiLoadMore $query');
    page = page + limit;
    final res = await apiCall(query);
    debugPrint('ApiClientgetProductStatus $res');
    if (res['success']) {
      final list = modelHanlde(res['data']);
      if (list.length < limit) {
        hashNextPage = false;
      }
      return list;
    }
    return error(res);
  }
}
