
import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ServiceBaseModule {

  @dev
  Iterable<Interceptor> getDevInterceptors(Alice alice) {
    return [alice.getDioInterceptor(), LogInterceptor()];
  }

  @prod
  Iterable<Interceptor> getProdInterceptors() {
    return [];
  }

}