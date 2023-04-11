// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pixabay_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PixabayRemoteData _$PixabayRemoteDataFromJson(Map<String, dynamic> json) =>
    PixabayRemoteData(
      total: json['total'] as int?,
      totalHits: json['totalHits'] as int?,
      hits: (json['hits'] as List<dynamic>?)
          ?.map((e) => Hit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PixabayRemoteDataToJson(PixabayRemoteData instance) =>
    <String, dynamic>{
      'total': instance.total,
      'totalHits': instance.totalHits,
      'hits': instance.hits,
    };

Hit _$HitFromJson(Map<String, dynamic> json) => Hit(
      json['id'] as int?,
      json['pageUrl'] as String?,
      json['type'] as String?,
      json['tags'] as String?,
      json['previewURL'] as String?,
      json['previewWidth'] as int?,
      json['previewHeight'] as int?,
      json['webformatURL'] as String?,
      json['webformatWidth'] as int?,
      json['webformatHeight'] as int?,
      json['largeImageURL'] as String?,
      json['imageWidth'] as int?,
      json['imageHeight'] as int?,
      json['imageSize'] as int?,
      json['views'] as int?,
      json['downloads'] as int?,
      json['collections'] as int?,
      json['likes'] as int?,
      json['comments'] as int?,
      json['userId'] as int?,
      json['user'] as String?,
      json['userImageURL'] as String?,
    );

Map<String, dynamic> _$HitToJson(Hit instance) => <String, dynamic>{
      'id': instance.id,
      'pageUrl': instance.pageUrl,
      'type': instance.type,
      'tags': instance.tags,
      'previewURL': instance.previewURL,
      'previewWidth': instance.previewWidth,
      'previewHeight': instance.previewHeight,
      'webformatURL': instance.webformatURL,
      'webformatWidth': instance.webformatWidth,
      'webformatHeight': instance.webformatHeight,
      'largeImageURL': instance.largeImageURL,
      'imageWidth': instance.imageWidth,
      'imageHeight': instance.imageHeight,
      'imageSize': instance.imageSize,
      'views': instance.views,
      'downloads': instance.downloads,
      'collections': instance.collections,
      'likes': instance.likes,
      'comments': instance.comments,
      'userId': instance.userId,
      'user': instance.user,
      'userImageURL': instance.userImageURL,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _PixabayService implements PixabayService {
  _PixabayService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://pixabay.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PixabayRemoteData> search(
    q, {
    lang = "en",
    id,
    imageType = "all",
    orientation = "all",
    category,
    minWidth = 0,
    minHeight = 0,
    colors,
    editorsChoice = false,
    safeSearch = false,
    order = "popular",
    page = 1,
    perPage = 20,
    callback,
    pretty = false,
    cancelToken,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'q': q,
      r'lang': lang,
      r'id': id,
      r'image_type': imageType,
      r'orientation': orientation,
      r'category': category,
      r'min_width': minWidth,
      r'min_height': minHeight,
      r'colors': colors,
      r'editors_choice': editorsChoice,
      r'safesearch': safeSearch,
      r'order': order,
      r'page': page,
      r'per_page': perPage,
      r'callback': callback,
      r'pretty': pretty,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PixabayRemoteData>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api',
              queryParameters: queryParameters,
              data: _data,
              cancelToken: cancelToken,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PixabayRemoteData.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
