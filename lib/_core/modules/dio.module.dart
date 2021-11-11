import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterDioModule {
  @lazySingleton
  Dio client() =>
      Dio()..options.baseUrl = "https://thecocktaildb.com/api/json/v1/1";
}
