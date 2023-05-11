import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pixabay/di/injection.dart';
import 'package:flutter_pixabay/repository/suggestion_repository.dart';

typedef SuggestionEvent = _SuggestionEvent;

class SuggestionBloc<Event extends SuggestionEvent>
    extends Bloc<Event, SuggestionState> {
  final SuggestionRepository suggestionRepository =
      getIt<SuggestionRepository>();
  Future<void>? _timer;
  String? latestQuery;

  SuggestionBloc(super.initialState) {
    on((event, emit) async {
      if (event is QueryEvent) {
        _timer?.ignore();
        latestQuery = event.query;

        if (event.query.trim().isEmpty) {
          emit(SuggestionState.hide());
          return;
        }

        var debounceTime = (latestQuery == null || latestQuery!.isEmpty) ? 0 : 100;
        _timer = await Future.delayed(Duration(milliseconds: debounceTime), () async {
          var result = await suggestionRepository.getSuggestions(event.query);
          if (latestQuery == event.query && result.isNotEmpty) {
            emit(SuggestionState.show(result.cast<String>()));
          }
          return null;
        });
      }
    });
  }
}

abstract class _SuggestionEvent {}

class QueryEvent extends _SuggestionEvent {
  QueryEvent(this.query);

  final String query;
}

class SuggestionState {
  SuggestionState.show(this.suggestions) {
    visible = true;
  }

  SuggestionState.hide() {
    visible = false;
    suggestions = List.empty();
  }

  // late final String query;
  late final List<String> suggestions;
  late final bool visible;
}
