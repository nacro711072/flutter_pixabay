import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pixabay/page/search/bloc/SuggestionBloc.dart';
import 'package:flutter_pixabay/page/search/component/suggestion_item_cell.dart';

class SuggestionListWidget extends StatelessWidget {
  const SuggestionListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestionBloc, SuggestionState>(
        // buildWhen: (previous, current) => current.visiable,
        builder: (context, state) {
      var suggestions = state.suggestions;

      return Visibility(
        visible: state.visible,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) =>
                  SuggestionItemCell(suggestions[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: suggestions.length),
        ),
      );
    });
  }
}
