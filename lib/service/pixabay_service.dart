import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'pixabay_service.g.dart';

@RestApi(baseUrl: "https://pixabay.com")
abstract class PixabayService {
  factory PixabayService(Dio dio, {String baseUrl}) = _PixabayService;

  // static final baseUrl = "https://pixabay.com";
  static const KEY = "31774191-9ff9a71020a62d34f9b62e0a5";

  @GET("/api")
  Future<PixabayRemoteData> search(@Query("q") String q,
      // This value may not exceed 100 characters.
      {@Query("lang") String lang = "en", // cs, da, de, en, es, fr, id, it, hu, nl, no, pl, pt, ro, sk, fi, sv, tr, vi, th, bg, ru, el, ja, ko, zh
      @Query("id") String? id,
      @Query("image_type") String imageType =
          "all", // "all", "photo", "illustration", "vector"
      @Query("orientation") String orientation =
          "all", // "all", "horizontal", "vertical"
      @Query("category") String? category, // backgrounds, fashion, nature, science, education, feelings, health, people, religion, places, animals, industry, computer, food, sports, transportation, travel, buildings, business, music
      @Query("min_width") int minWidth = 0,
      @Query("min_height") int minHeight = 0,
      @Query("colors") String? colors, // grayscale", "transparent", "red", "orange", "yellow", "green", "turquoise", "blue", "lilac", "pink", "white", "gray", "black", "brown"
      @Query("editors_choice") bool editorsChoice = false,
      @Query("safesearch") bool safeSearch = false,
      @Query("order") String order = "popular", // "popular", "latest"
      @Query("page") int page = 1,
      @Query("per_page") int perPage = 20,
      @Query("callback") String? callback,
      @Query("pretty") bool pretty = false,
      @CancelRequest() CancelToken? cancelToken}
      // Indent JSON output. This option should not be used in production.
      );

}

@JsonSerializable()
class PixabayRemoteData {
  final int? total;
  final int? totalHits;
  final List<Hit>? hits;

  const PixabayRemoteData({this.total, this.totalHits, this.hits});

  factory PixabayRemoteData.fromJson(Map<String, dynamic> json) => _$PixabayRemoteDataFromJson(json);

  Map<String, dynamic> toJson() => _$PixabayRemoteDataToJson(this);

  @override
  String toString() {
    // return "total: $total, totalHits: $totalHits, first hits user image: ${hits?.first.userImageURL}";
    return "total: $total, totalHits: $totalHits";
  }
}

@JsonSerializable()
class Hit {
  final int? id;
  final String? pageUrl;
  final String? type;
  final String? tags;
  final String? previewURL;
  final int? previewWidth;
  final int? previewHeight;
  final String? webformatURL;
  final int? webformatWidth;
  final int? webformatHeight;
  final String? largeImageURL;
  final int? imageWidth;

  final int? imageHeight;
  final int? imageSize;
  final int? views;
  final int? downloads;
  final int? collections;
  final int? likes;
  final int? comments;
  final int? userId;
  final String? user;
  final String? userImageURL;


  Hit(
      this.id,
      this.pageUrl,
      this.type,
      this.tags,
      this.previewURL,
      this.previewWidth,
      this.previewHeight,
      this.webformatURL,
      this.webformatWidth,
      this.webformatHeight,
      this.largeImageURL,
      this.imageWidth,
      this.imageHeight,
      this.imageSize,
      this.views,
      this.downloads,
      this.collections,
      this.likes,
      this.comments,
      this.userId,
      this.user,
      this.userImageURL);

  factory Hit.fromJson(Map<String, dynamic> json) => _$HitFromJson(json);

  Map<String, dynamic> toJson() => _$HitToJson(this);

}


