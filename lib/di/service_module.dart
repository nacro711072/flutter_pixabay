import 'dart:developer';

import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../service/pixabay_service.dart';

@module
abstract class ServiceModule {

  @dev
  Dio getDevDio(Alice alice) {
    var dio = Dio(BaseOptions(contentType: "application/json"));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.putIfAbsent("key", () => PixabayService.KEY);
          return handler.next(options);
        },
      ),
    );
    dio.interceptors.add(alice.getDioInterceptor());
    return dio;
  }

  @prod
  Dio getProDio() {
    var dio = Dio(BaseOptions(contentType: "application/json"));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.putIfAbsent("key", () => PixabayService.KEY);
          return handler.next(options);
        },
      ),
    );

    return dio;
  }


  PixabayService getService(Dio dio) => PixabayService(dio);
}
