import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/injection.dart';
import '../../../entity/vo/image_item_vo.dart';
import '../../../logic/picture_paging_logic.dart';
import '../../../repository/picture_repository.dart';
import '../../../service/pixabay_service.dart';


typedef ImageListEvent = _ImageListEvent;

class ImageListBloc<Event extends ImageListEvent>
    extends Bloc<Event, ImageListState> {

  final PicturePagingLogic _picturePagingLogic = PicturePagingLogic(
      getIt<PictureRepository>());
  final List<ImageItemVO> _vo = List.empty(growable: true);

  ImageListBloc(super.initialState) {
    on((event, emit)
    async {
      if (event is QueryEvent) {
        emit(ImageListState.loading(_vo));
        var value = await _picturePagingLogic.searchImage(event.query);
        if (value != null) _vo.update(value, true, emit);

      } else if (event is LoadMoreEvent) {
        emit(ImageListState.loading(_vo));
        var value = await _picturePagingLogic.nextPage();
        if (value != null) _vo.update(value, false, emit);
      }
    });
  }

  ImageListBloc.create() : this(ImageListState.initState());

  @override
  void onEvent(Event event) {
    super.onEvent(event);
  }
}

abstract class _ImageListEvent {}

class QueryEvent extends _ImageListEvent {
  QueryEvent(this.query);

  final String query;
}

class LoadMoreEvent extends _ImageListEvent {
  LoadMoreEvent();
}

class ImageListState {

  ImageListState.initState() {
    loading = true;
    voList = List.empty();
  }

  ImageListState.loading(List<ImageItemVO> old) {
    loading = true;
    voList = old;
  }

  ImageListState.ready(List<ImageItemVO> old) {
    loading = false;
    voList = old;
  }

  late final bool loading;
  late final List<ImageItemVO> voList;

}

extension _UpdateImage on List<ImageItemVO> {

  update(PixabayRemoteData data, bool reset, Emitter<ImageListState> emit) {
    var vos = data.hits?.map((e) => ImageItemVO(e.id ?? 0, e.user ?? "",
        e.userImageURL ?? "", e.previewURL ?? "")) ??
        List.empty();

    if (reset) {
      clear();
    }
    addAll(vos);
    emit(ImageListState.ready(this));
  }

}
