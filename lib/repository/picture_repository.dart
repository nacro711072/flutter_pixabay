
import 'dart:developer';

import '../service/pixabay_service.dart';
import 'package:dio/dio.dart';

class PictureRepository {
  final Dio _dio = Dio(BaseOptions(contentType: "application/json"));
  late final PixabayService _service;

  PictureRepository() {
    _initializeInterceptors();
    _service = PixabayService(_dio);
  }

  Future<PixabayRemoteData> searchImage(String q, {int page = 1, int perPage = 20, CancelToken? cancelToken}) async {
     var response = await _service.search(q, page: page, perPage: perPage);
     return response;
  }

  _initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.putIfAbsent(
              "key", () => "31774191-9ff9a71020a62d34f9b62e0a5");
          return handler.next(options);
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log("request -----> \n path: ${options.path}\n data: ${options.data}\n query: ${options.queryParameters.entries.join(",")}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log("response -----> \n data: ${response.data}");
          return handler.next(response);
        }
      )
    );
  }
}