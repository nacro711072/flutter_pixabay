import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pixabay/autocomplete_list.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: [
        SafeArea(child: SearchBar()),
        // SizedBox(
        //     width: double.infinity, height: kToolbarHeight, child: SearchBar()),
        const Expanded(child: AutoCompleteList())
      ]),
    );
    return Column(children: [SearchBar(), Expanded(child: AutoCompleteList())]);
  }
}

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
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
                        // todo: show suggestion
                      });
                    },
                    onSubmitted: (text) {
                      // todo: query
                      Navigator.pop(context, text);
                    },
                  ))),
        ],
      ),
    );
  }
}
