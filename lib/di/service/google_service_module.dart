import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../service/google_suggestion_service.dart';
import '../../service/pixabay_service.dart';

@module
abstract class GoogleServiceModule {

  @Named('google')
  Dio getGoogleServiceDio(Iterable<Interceptor> interceptors) {
    var dio = Dio(BaseOptions(contentType: "text/xml"));
    // dio.interceptors.add(InterceptorsWrapper(
    //   onResponse: (response, handler) {
    //     final Xml2Json transformer = Xml2Json();
    //     transformer.parse(response.data);
    //     final json = transformer.toGData();
    //     response.data = jsonDecode(json);
    //     return handler.next(response);
    //   }
    // ));
    dio.interceptors.addAll(interceptors);
    return dio;
  }

  GoogleSuggestionService getGoogleSuggestionService(@Named('google') Dio dio) => GoogleSuggestionService(dio);
}
