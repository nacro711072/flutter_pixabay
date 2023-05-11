
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/page/search/component/suggestion_list_widget.dart';

import 'component/search_history_list.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: const [
      SearchHistoryList(),
      SuggestionListWidget()
    ],);
  }

}