
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/component/placeholder.dart';
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
                    content: CachedNetworkImage(
                      imageUrl: _vo.imageUrl,
                      alignment: Alignment.centerRight,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const ImagePlaceHolder(),
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
                      child: CachedNetworkImage(
                        placeholder: (context, url) => const ImagePlaceHolder(),
                        imageUrl: _vo.avatarUrl,
                        errorWidget: (context, url, error) => const ImagePlaceHolder(),
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(width: 16),
                Expanded(child: Text(_vo.name)),
                const SizedBox(width: 16),
                SizedBox(
                    width: 44,
                    height: 44,
                    child: CachedNetworkImage(
                      imageUrl: _vo.imageUrl,
                      alignment: Alignment.centerRight,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const ImagePlaceHolder(),
                    ))
              ],
            ),
          ),
        ),
      );
  }

}