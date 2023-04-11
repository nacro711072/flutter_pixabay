import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_pixabay/logic/picture_paging_logic.dart';
import 'package:flutter_pixabay/repository/picture_repository.dart';
import 'package:flutter_pixabay/service/pixabay_service.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'entity/vo/image_item_vo.dart';
import 'list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PicturePagingLogic _picturePagingLogic =
      PicturePagingLogic(PictureRepository());

  bool _isLoading = true;

  final List<ImageItemVO> _vo = List.empty(growable: true);

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    _picturePagingLogic
        .searchImage("cat")
        .then((value) => {if (value != null) _updateImages(value, true)});

    _scrollController.addListener(() {
      var scrollPosition = _scrollController.position;
      var isNearBottom =
          scrollPosition.pixels > scrollPosition.maxScrollExtent * 0.9;

      if (isNearBottom) {
        setState(() {
          _isLoading = true;
        });

        _picturePagingLogic
            .nextPage()
            .then((value) => {if (value != null) _updateImages(value, false)});
      }

    });
  }

  _updateImages(PixabayRemoteData data, bool clear) {
    setState(() {
      var vos = data.hits?.map((e) => ImageItemVO(e.id ?? 0, e.user ?? "",
              e.userImageURL ?? "", e.previewURL ?? "")) ??
          List.empty();
      if (clear) _vo.clear();
      _vo.addAll(vos);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          controller: _scrollController,
          itemCount: _vo.length,
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                          color: Colors.black12, shape: BoxShape.circle),
                      padding: const EdgeInsets.all(2),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'images/pixabay_logo_square.png',
                            image: _vo.elementAt(index).avatarUrl,
                            imageErrorBuilder: (context, error, stack) =>
                                Image.asset('images/pixabay_logo_square.png'),
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
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
