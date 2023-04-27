
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/image_list_bloc.dart';
import 'home_body.dart';

class HomeArguments {
  final String query;

  const HomeArguments(this.query);
}

class MyHomePage extends StatelessWidget {
  static const routerName = "/";

  final HomeArguments? args;

  const MyHomePage({super.key, required this.title, this.args});

  final String title;

  String get queryTarget {
    return args?.query ?? 'cat';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageListBloc.create(),
      child: _MyHomePageStateWidget(title, queryTarget),
    );
  }
}

class _MyHomePageStateWidget extends StatefulWidget {
  final String title;
  final String query;

  const _MyHomePageStateWidget(this.title, this.query);


  @override
  State<StatefulWidget> createState() {
    return _MyHomePageBlocState();
  }
}

class _MyHomePageBlocState extends State<_MyHomePageStateWidget> {

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
      body: const HomeBody(),
    );
  }

  _onClickSearch() async {
    final result = await Navigator.pushNamed(context, '/search');
    if (!mounted) return null;

    if (result is String) {
      BlocProvider.of<ImageListBloc>(context).add(QueryEvent(result));
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ImageListBloc>(context).add(QueryEvent(widget.query));
  }
}
