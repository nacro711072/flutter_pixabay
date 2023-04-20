import 'package:flutter/cupertino.dart';
import 'package:flutter_pixabay/entity/vo/image_item_vo.dart';

import 'image_item_cell.dart';

typedef OnScrollBottom = void Function();

class ImagePreviewList extends StatelessWidget {
  static const double _defaultScrollBottomThreshold = 0.9;

  const ImagePreviewList(
      {super.key,
      this.threshold = _defaultScrollBottomThreshold,
      this.onScrollBottom,
      required this.voList});

  final double threshold;
  final OnScrollBottom? onScrollBottom;
  final List<ImageItemVO> voList;

  @override
  Widget build(BuildContext context) {
    return _ImagePreviewStateWidget(
      threshold: threshold,
      onScrollBottom: onScrollBottom,
      voList: voList,
    );
  }
}

class _ImagePreviewStateWidget extends StatefulWidget {
  const _ImagePreviewStateWidget(
      {super.key, required this.threshold, this.onScrollBottom, required this.voList});

  final double threshold;
  final OnScrollBottom? onScrollBottom;
  final List<ImageItemVO> voList;

  @override
  State<StatefulWidget> createState() {
    return _ImagePreviewState();
  }
}

class _ImagePreviewState extends State<_ImagePreviewStateWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      var scrollPosition = _scrollController.position;
      var isNearBottom = scrollPosition.pixels >
          scrollPosition.maxScrollExtent * widget.threshold;

      if (isNearBottom) {
        widget.onScrollBottom?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      controller: _scrollController,
      itemCount: widget.voList.length,
      itemBuilder: (context, index) {
        return ImageItemCell(widget.voList[index]);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
