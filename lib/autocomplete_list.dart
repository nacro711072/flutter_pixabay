import 'package:flutter/cupertino.dart';

class AutoCompleteList extends StatefulWidget {
  const AutoCompleteList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AutoCompleteListState();
  }
}

class _AutoCompleteListState extends State<AutoCompleteList> {
  final List<String> _list = List.generate(1, (index) { return "test$index"; }, growable: true);

  @override
  Widget build(BuildContext context) {
    if (_list.isEmpty) {
      return const SizedBox.square();
    } else {
      return Column(
        children: [
          const Text("查詢記錄"),
          Expanded(
              child: ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return Text(_list[index]);
                  }))
        ],
      );
    }
  }
}
