import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pixabay/page/search/bloc/SearchBloc.dart';
import 'package:flutter_pixabay/page/search/search_body.dart';
import 'package:flutter_pixabay/di/injection.dart';
import 'package:flutter_pixabay/repository/history_repository.dart';
import 'package:flutter_pixabay/repository/suggestion_repository.dart';

import 'bloc/SuggestionBloc.dart';

class SearchPage extends StatelessWidget {
  final QueryHistoryRepository _queryHistoryRepository =
      getIt<QueryHistoryRepository>();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => SuggestionBloc(SuggestionState.hide())),
            BlocProvider(
                create: (context) => SearchBloc((query) {
                      if (query != null) {
                        _queryHistoryRepository.saveQuery(query);
                      }
                      Navigator.pop(context, query);
                    })),
          ],
          child: Column(children: const [
            SafeArea(child: SearchBar()),
            Expanded(child: SearchBody())
          ])),
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
  final SuggestionRepository _suggestionRepository =
      getIt<SuggestionRepository>();

  // final SharedPreferences _sp = getIt<SharedPreferences>();

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
                      context.read<SuggestionBloc>().add(QueryEvent(text));
                    },
                    onSubmitted: (text) {
                      context.read<SearchBloc>().add(text);
                    },
                  ))),
        ],
      ),
    );
  }
}
