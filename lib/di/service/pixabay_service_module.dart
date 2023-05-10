import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../service/pixabay_service.dart';

@module
abstract class PixabatServiceModule {

  @Named('pixabay')
  @Singleton()
  Dio getPixabayDio(Iterable<Interceptor> baseInterceptors) {
    var dio = Dio(BaseOptions(contentType: "application/json"));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.putIfAbsent("key", () => PixabayService.KEY);
          return handler.next(options);
        },
      ),
    );
    dio.interceptors.addAll(baseInterceptors);
    return dio;
  }

  // @google
  // @Singleton()
  // Dio getGoogleServiceDio(Iterable<Interceptor> interceptors) {
  //   var dio = Dio(BaseOptions(contentType: "text/xml"));
  //   dio.interceptors.add(InterceptorsWrapper(
  //     onResponse: (response, handler) {
  //       final Xml2Json transformer = Xml2Json();
  //       transformer.parse(response.data);
  //       final json = transformer.toGData();
  //       response.data = jsonDecode(json);
  //       return handler.next(response);
  //     }
  //   ));
  //   dio.interceptors.addAll(interceptors);
  //   return dio;
  // }

  // @prod
  // Dio getProDio() {
  //   var dio = Dio(BaseOptions(contentType: "application/json"));
  //   dio.interceptors.add(
  //     InterceptorsWrapper(
  //       onRequest: (options, handler) {
  //         options.queryParameters.putIfAbsent("key", () => PixabayService.KEY);
  //         return handler.next(options);
  //       },
  //     ),
  //   );
  //
  //   return dio;
  // }

  PixabayService getService(@Named('pixabay') Dio dio) => PixabayService( dio);

// GoogleSuggestionService getGoogleSuggestionService(@google Dio dio) => GoogleSuggestionService(dio);
}
