import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pixabay/autocomplete_list.dart';
import 'package:flutter_pixabay/di/injection.dart';
import 'package:flutter_pixabay/repository/history_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: const [
        SafeArea(child: SearchBar()),
        // SizedBox(
        //     width: double.infinity, height: kToolbarHeight, child: SearchBar()),
        Expanded(child: AutoCompleteList())
      ]),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  final QueryHistoryRepository _repository = getIt<QueryHistoryRepository>();
  // final SharedPreferences _sp = getIt<SharedPreferences>();
  var _debounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kToolbarHeight,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              padding: EdgeInsets.zero,
              splashRadius: 20,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        hintText: 'search image. ex: cat',
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, style: BorderStyle.none)),
                        isCollapsed: true,
                        suffixIcon: SizedBox(
                            child: IconButton(
                          icon: const Icon(Icons.clear),
                          splashRadius: 12,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            _controller.clear();
                          },
                        ))),
                    maxLines: 1,
                    textInputAction: TextInputAction.search,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (text) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(milliseconds: 250), () {
                        // todo: filter suggestion
                      });
                    },
                    onSubmitted: (text) {
                      _repository.saveQuery(text);
                      Navigator.pop(context, text);
                    },
                  ))),
        ],
      ),
    );
  }
}
