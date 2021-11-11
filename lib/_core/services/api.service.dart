import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@immutable
class ApiService {
  final Dio _client;

  const ApiService(this._client);

  Future<T> get<T>(String path) async {
    final Response<T> response = await _client.get<T>(path);
    final data = response.data;

    if (response.statusCode == 200 && data != null) return data;
    throw (Exception("Api call $path failed!"));
  }
}
