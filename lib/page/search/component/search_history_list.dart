import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/di/injection.dart';
import 'package:flutter_pixabay/repository/history_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryList extends StatefulWidget {
  const SearchHistoryList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchHistoryListState();
  }
}

class _SearchHistoryListState extends State<SearchHistoryList> {
  final QueryHistoryRepository _repository = getIt<QueryHistoryRepository>();

  late List<String> _list;

  @override
  void initState() {
    super.initState();
    _list = _repository.getHistory();
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
            padding: EdgeInsets.zero,
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
