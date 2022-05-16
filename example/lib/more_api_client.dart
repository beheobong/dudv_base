import 'package:dudv_base/dudv_base.dart';
import 'package:flutter/material.dart';
import 'api_client.dart';

class MoreApiClient extends ApiClient with ApiLoadMore {
  MoreApiClient(BuildContext contex) : super(contex);

  @override
  Future apiCall(query) {
    throw UnimplementedError();
  }

  @override
  Future error(res) {
    throw UnimplementedError();
  }

  @override
  List modelHanlde(data) {
    throw UnimplementedError();
  }
}
