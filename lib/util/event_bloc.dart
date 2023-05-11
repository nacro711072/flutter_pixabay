
import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';

typedef EventListener = void Function(dynamic event);

abstract class EventBloc<T> extends Bloc<T, void> {

  EventBloc(this.onEventListener): super(Void) {
    on((event, emit) => Void);
  }

  final EventListener onEventListener;

  @override
  void onEvent(T event) {
    super.onEvent(event);
    onEventListener(event);
  }
}
