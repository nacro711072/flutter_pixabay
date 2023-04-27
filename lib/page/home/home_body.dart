import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/image_list_bloc.dart';
import 'component/image_preview_list_view.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageListBloc, ImageListState>(
        builder: (context, state) {
          return _HomeBody(state, onScrollBottom: () => context.read<ImageListBloc>().add(LoadMoreEvent()));
        });
  }
}


class _HomeBody extends StatelessWidget {
  const _HomeBody(this.state, {super.key, this.onScrollBottom});

  final ImageListState state;
  final OnScrollBottom? onScrollBottom;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: state.loading ? 0.3 : 1.0,
          child: IgnorePointer(
            ignoring: state.loading,
            child: ImagePreviewList(
              voList: state.voList, onScrollBottom: onScrollBottom,),
          ),
        ),
        Center(
          child: Visibility(
              visible: state.loading, child: const CircularProgressIndicator()),
        )
      ],
    );
  }

}
