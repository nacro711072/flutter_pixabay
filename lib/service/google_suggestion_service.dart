import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_suggestion_service.g.dart';

// @RestApi(baseUrl: "https://suggestqueries.google.com")
@RestApi(baseUrl: "https://www.google.com")
abstract class GoogleSuggestionService {
  factory GoogleSuggestionService(Dio dio,
      {String baseUrl}) = _GoogleSuggestionService;

  @GET("/complete/search")
  Future<String> suggestionQuery(
      @Query("q") String q,
      {@Query("client") String client = "chrome"}
  );

}

// @JsonSerializable()
// class GoogleSuggestionRemoteData {
//   final int? total;
//   final int? totalHits;
//   final List<Hit>? hits;
//
//   const GoogleSuggestionRemoteData({this.total, this.totalHits, this.hits});
//
//   factory PixabayRemoteData.fromJson(Map<String, dynamic> json) =>
//       _$PixabayRemoteDataFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PixabayRemoteDataToJson(this);
//
//   @override
//   String toString() {
//     // return "total: $total, totalHits: $totalHits, first hits user image: ${hits?.first.userImageURL}";
//     [
//       "test",
//       [
//         "testosterone",
//         "test speed",
//         "testflight",
//         "test 中文",
//         "testosterone 中文",
//         "testimony",
//         "testgo",
//         "testament",
//         "testify",
//         "testicle",
//         "tester",
//         "testimonial",
//         "testing",
//         "testo",
//         "testosterone正常值"
//       ],
//       ["", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
//       [],
//       {
//         "google:clientdata": {"bpc": false, "tlw": false},
//         "google:suggestrelevance": [
//           601,
//           600,
//           562,
//           561,
//           560,
//           559,
//           558,
//           557,
//           556,
//           555,
//           554,
//           553,
//           552,
//           551,
//           550
//         ],
//         "google:suggestsubtypes": [
//           [512, 433, 131],
//           [512, 433, 131],
//           [512, 433, 131],
//           [512, 433, 131],
//           [512, 433, 131],
//           [512, 433, 131],
//           [512],
//           [512, 433, 131],
//           [512, 433, 131],
//           [512, 433],
//           [512, 433],
//           [512, 433, 131],
//           [512, 433],
//           [512, 433, 131],
//           [512]
//         ],
//         "google:suggesttype": [
//           "QUERY",
//           "QUERY",
//           "QUERY",
//           "QUERY",
//           "QUERY",
//           "QUERY",
//           "QUERY",
//           "QUERY",
//           "QUERY",
//           "QUERY",
//           "QUERY",
//           "QUERY",
//           "QUERY",
//           "QUERY",
//           "QUERY"
//         ],
//         "google:verbatimrelevance": 1300
//       }
//     ]
//     return "total: $total, totalHits: $totalHits";
//   }
// }
//
// @JsonSerializable()
// class Hit {
//   final int? id;
//   final String? pageUrl;
//   final String? type;
//   final String? tags;
//   final String? previewURL;
//   final int? previewWidth;
//   final int? previewHeight;
//   final String? webformatURL;
//   final int? webformatWidth;
//   final int? webformatHeight;
//   final String? largeImageURL;
//   final int? imageWidth;
//
//   final int? imageHeight;
//   final int? imageSize;
//   final int? views;
//   final int? downloads;
//   final int? collections;
//   final int? likes;
//   final int? comments;
//   final int? userId;
//   final String? user;
//   final String? userImageURL;
//
//
//   Hit(this.id,
//       this.pageUrl,
//       this.type,
//       this.tags,
//       this.previewURL,
//       this.previewWidth,
//       this.previewHeight,
//       this.webformatURL,
//       this.webformatWidth,
//       this.webformatHeight,
//       this.largeImageURL,
//       this.imageWidth,
//       this.imageHeight,
//       this.imageSize,
//       this.views,
//       this.downloads,
//       this.collections,
//       this.likes,
//       this.comments,
//       this.userId,
//       this.user,
//       this.userImageURL);
//
//   factory Hit.fromJson(Map<String, dynamic> json) => _$HitFromJson(json);
//
//   Map<String, dynamic> toJson() => _$HitToJson(this);
//
// }
//
