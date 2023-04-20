import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../service/pixabay_service.dart';

@module
abstract class ServiceModule {
  Dio getDio() {
    var dio = Dio(BaseOptions(contentType: "application/json"));
    _initializeInterceptors(dio);
    return dio;
  }

  _initializeInterceptors(Dio dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.putIfAbsent("key", () => PixabayService.KEY);
          return handler.next(options);
        },
      ),
    );
  }

  PixabayService getService(Dio dio) => PixabayService(dio);
}
