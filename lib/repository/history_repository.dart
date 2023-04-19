
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable()
class QueryHistoryRepository {
  static const _spHistoryKey = "SP_HISTORY_KEY";
  static const _max = 10;

  final SharedPreferences _sp;

  @factoryMethod
  QueryHistoryRepository.from(this._sp);

  List<String> getHistory() {
    return _sp.getStringList(_spHistoryKey)?.reversed.toList() ?? List.empty();
  }

  saveQuery(String query) async {
    var newList = _sp.getStringList(_spHistoryKey) ?? List.empty(growable: true);
    newList.remove(query);
     newList.add(query);

    var diff = (newList.length - _max);
    if (diff > 0) {
      newList.removeRange(0, diff);
    }
    await _sp.setStringList(_spHistoryKey, newList);
  }
}