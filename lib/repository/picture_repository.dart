
import 'dart:developer';

import 'package:flutter_pixabay/di/injection.dart';
import 'package:injectable/injectable.dart';

import '../service/pixabay_service.dart';
import 'package:dio/dio.dart';

@Injectable()
class PictureRepository {
  final PixabayService _service;

  @factoryMethod
  PictureRepository(this._service);

  Future<PixabayRemoteData> searchImage(String q, {int page = 1, int perPage = 20, CancelToken? cancelToken}) async {
     var response = await _service.search(q, page: page, perPage: perPage);
     return response;
  }

}