import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/ImageListBloc.dart';
import 'component/image_preview_view.dart';

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
  final _imageListBloc = ImageListBloc(ImageListState.initState());

  @override
  void initState() {
    super.initState();

    _startFetchImage(widget.queryTarget);
  }

  _startFetchImage(String query) {
    _imageListBloc.add(QueryEvent(query));
  }

  _nextPage() {
    _imageListBloc.add(LoadMoreEvent());
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
      body: BlocBuilder(
        bloc: _imageListBloc,
        builder: (context, state) {
          var imageState = state as ImageListState;
          return Stack(
            children: [
              Opacity(
                opacity: imageState.loading ? 0.3 : 1.0,
                child: IgnorePointer(
                  ignoring: imageState.loading,
                  child: ImagePreviewList(voList: imageState.voList, onScrollBottom: _nextPage,),
                ),
              ),
              Center(
                child: Visibility(
                    visible: imageState.loading, child: const CircularProgressIndicator()),
              )
            ],
          );
        },

      ),
    );
  }
}
