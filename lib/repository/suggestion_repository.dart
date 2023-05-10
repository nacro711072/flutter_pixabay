
import 'package:flutter_pixabay/service/google_suggestion_service.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SuggestionRepository {
  final GoogleSuggestionService _service;

  @factoryMethod
  SuggestionRepository(this._service);

  Future<List<dynamic>> getSuggestions(String q) async {
    var response = await _service.suggestionQuery(q);
    if (response == null || response.isEmpty || response.length < 2) return List.empty();
    return response[1] as List<dynamic>;
  }
}