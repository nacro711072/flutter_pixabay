
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pixabay/page/search/bloc/SearchBloc.dart';

class SuggestionItemCell extends StatelessWidget {
  const SuggestionItemCell(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.search),
              Text(text)
            ]),
      ),
      onTap: () {
        context.read<SearchBloc>().add(text);
      },
    );

  }

}