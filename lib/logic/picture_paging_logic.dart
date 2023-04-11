import 'package:dio/dio.dart';
import 'package:flutter_pixabay/repository/picture_repository.dart';

import '../service/pixabay_service.dart';

class PicturePagingLogic {
  PicturePagingLogic(this._repo);

  final PictureRepository _repo;
  ImageQueryIntent? _queryIntent;

  Future<PixabayRemoteData?> searchImage(String query) async {
    var intent = _newQueryIntent(query);
    return await intent.fetchNextPageData();
  }

  Future<PixabayRemoteData?> nextPage() async {
    return await _queryIntent?.fetchNextPageData();
  }

  ImageQueryIntent _newQueryIntent(String query) {
    _queryIntent?.cancel();
    var newIntent = ImageQueryIntent(query, _repo);
    _queryIntent = newIntent;
    return newIntent;
  }
}

class ImageQueryIntent {
  final String _query;
  final PictureRepository _repo;

  int _currentPage = 0;
  bool _isFetching = false;
  CancelToken? _cancelToken;

  ImageQueryIntent(this._query, this._repo);

  Future<PixabayRemoteData?> fetchNextPageData() async {
    if(_isFetching) return null;
    _isFetching = true;

    _cancelToken = CancelToken();
    var searchResponse = await _repo.searchImage(_query, page: _currentPage + 1, cancelToken: _cancelToken);
    _currentPage += 1;
    _isFetching = false;
    return searchResponse;
  }

  cancel() {
    _cancelToken?.cancel();
    _cancelToken = null;
  }

}