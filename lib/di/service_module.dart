import 'dart:developer';

import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../service/pixabay_service.dart';

@module
abstract class ServiceModule {

  Dio getDio(Alice alice) {
    var dio = Dio(BaseOptions(contentType: "application/json"));
    _initializeInterceptors(dio, alice);
    return dio;
  }

  _initializeInterceptors(Dio dio, Alice alice) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.putIfAbsent("key", () => PixabayService.KEY);
          return handler.next(options);
        },
      ),
    );
    dio.interceptors.add(alice.getDioInterceptor());
  }

  PixabayService getService(Dio dio) => PixabayService(dio);
}
