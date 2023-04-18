import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/di/injection.dart';
import 'package:flutter_pixabay/repository/history_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutoCompleteList extends StatefulWidget {
  const AutoCompleteList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AutoCompleteListState();
  }
}

class _AutoCompleteListState extends State<AutoCompleteList> {
  final QueryHistoryRepository _repository = getIt<QueryHistoryRepository>();

  // final SharedPreferences _sp = getIt<SharedPreferences>(instanceName: "SharedPreferences");
  // final QueryHistoryRepository _repository = QueryHistoryRepository.from(getIt<SharedPreferences>());
  late List<String> _list;

  @override
  void initState() {
    super.initState();
    _list = _repository.getHistory();
    // _list = List.generate(1, (index) => "test");
  }

  @override
  Widget build(BuildContext context) {
    if (_list.isEmpty) {
      return const SizedBox.square();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "查詢記錄",
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
              child: ListView.separated(
            itemCount: _list.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  var text = _list[index];
                  _repository.saveQuery(text);
                  Navigator.pop(context, text);
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: Text(
                      _list[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          ))
        ],
      );
    }
  }
}
