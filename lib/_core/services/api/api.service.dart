import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@immutable
class ApiService {
  final Dio _client;

  const ApiService(this._client);

  Future<Map<String, dynamic>> get(String path) async {
    final response = await _client.get<Map<String, dynamic>>(path);
    final data = response.data;

    if (response.statusCode == 200 && data != null) return data;
    throw (Exception("Api call $path failed!"));
  }
}
