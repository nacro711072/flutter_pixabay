import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/di/injection.dart';

import '../../entity/vo/image_item_vo.dart';
import '../../logic/picture_paging_logic.dart';
import '../../repository/picture_repository.dart';
import '../../service/pixabay_service.dart';

class HomeArguments {
  final String query;

  const HomeArguments(this.query);
}

class MyHomePage extends StatefulWidget {
  static const routerName = "/";

  final HomeArguments? args;

  const MyHomePage({super.key, required this.title, this.args});

  final String title;

  String get queryTarget {
    return args?.query ?? 'cat';
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PicturePagingLogic _picturePagingLogic =
      PicturePagingLogic(getIt<PictureRepository>());

  bool _isLoading = true;

  final List<ImageItemVO> _vo = List.empty(growable: true);

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _startFetchImage(widget.queryTarget);

    _scrollController.addListener(() {
      var scrollPosition = _scrollController.position;
      var isNearBottom =
          scrollPosition.pixels > scrollPosition.maxScrollExtent * 0.9;

      if (isNearBottom) {
        _nextPage();
      }
    });
  }

  _startFetchImage(String query) {
    setState(() {
      _isLoading = true;
    });

    _picturePagingLogic
        .searchImage(query)
        .then((value) => {if (value != null) _updateImages(value, true)});
  }

  _nextPage() {
    setState(() {
      _isLoading = true;
    });

    _picturePagingLogic
        .nextPage()
        .then((value) => {if (value != null) _updateImages(value, false)});
  }

  _updateImages(PixabayRemoteData data, bool reset) {
    setState(() {
      var vos = data.hits?.map((e) => ImageItemVO(e.id ?? 0, e.user ?? "",
              e.userImageURL ?? "", e.previewURL ?? "")) ??
          List.empty();
      if (reset) _vo.clear();
      _vo.addAll(vos);
      _isLoading = false;
    });
  }

  _onClickSearch() async {
    final result = await Navigator.pushNamed(context, '/search');
    if (result == null) return;
    if (!mounted) return;

    if (result is String) {
      _startFetchImage(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _onClickSearch();
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: _isLoading ? 0.3 : 1.0,
            child: IgnorePointer(
              ignoring: _isLoading,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                controller: _scrollController,
                itemCount: _vo.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      customBorder: Theme.of(context).cardTheme.shape,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Image.network(
                                  _vo.elementAt(index).imageUrl,
                                  alignment: Alignment.centerRight,
                                ),
                              );
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  shape: BoxShape.circle),
                              padding: const EdgeInsets.all(2),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        'images/pixabay_logo_square.png',
                                    image: _vo.elementAt(index).avatarUrl,
                                    imageErrorBuilder:
                                        (context, error, stack) => Image.asset(
                                            'images/pixabay_logo_square.png'),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const SizedBox(width: 16),
                            Expanded(child: Text(_vo.elementAt(index).name)),
                            const SizedBox(width: 16),
                            SizedBox(
                                width: 44,
                                height: 44,
                                child: Image.network(
                                  _vo.elementAt(index).imageUrl,
                                  alignment: Alignment.centerRight,
                                  fit: BoxFit.cover,
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child: Visibility(
                visible: _isLoading, child: const CircularProgressIndicator()),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
