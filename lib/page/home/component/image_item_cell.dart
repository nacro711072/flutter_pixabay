
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/vo/image_item_vo.dart';

class ImageItemCell extends StatelessWidget {
  final ImageItemVO _vo;

  const ImageItemCell(this._vo, {super.key});

  @override
  Widget build(BuildContext context) {
      return Card(
        child: InkWell(
          customBorder: Theme.of(context).cardTheme.shape,
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Image.network(
                      _vo.imageUrl,
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
                        image: _vo.avatarUrl,
                        imageErrorBuilder:
                            (context, error, stack) => Image.asset(
                            'images/pixabay_logo_square.png'),
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(width: 16),
                Expanded(child: Text(_vo.name)),
                const SizedBox(width: 16),
                SizedBox(
                    width: 44,
                    height: 44,
                    child: Image.network(
                      _vo.imageUrl,
                      alignment: Alignment.centerRight,
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          ),
        ),
      );
  }

}