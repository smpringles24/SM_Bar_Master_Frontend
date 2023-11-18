import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/data/model/album_model.dart';
import 'package:sm_bar_master_frontend/data/model/etc_model.dart';

class DataChangeDialog extends StatelessWidget {
  AlbumModel albumModel;
  final TextEditingController _controller = TextEditingController();
  late AlbumSelectedOption element;
  final int nowSongIndex;

  DataChangeDialog(
      {required this.element,
      required this.albumModel,
      required this.nowSongIndex,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('값 수정하기'),
      content: Container(
        height: 200,
        width: 350,
        color: Colors.black38,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: elementToKorean(element),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    switch (element) {
                      case AlbumSelectedOption.albumDate:
                        albumModel.date = _controller.text;
                        break;
                      case AlbumSelectedOption.albumTitle:
                        albumModel.title = _controller.text;
                        break;
                      case AlbumSelectedOption.albumImage:
                        albumModel.imageUrl = _controller.text;
                        break;
                      case AlbumSelectedOption.backgroundColor:
                        albumModel.backgroundColor = _controller.text;
                        break;
                      case AlbumSelectedOption.cdImage:
                        albumModel.songEntities![nowSongIndex].imageUrl =
                            _controller.text;
                        break;
                      case AlbumSelectedOption.cdTitle:
                        albumModel.songEntities![nowSongIndex].title =
                            _controller.text;
                        break;
                      case AlbumSelectedOption.cdReview:
                        albumModel.songEntities![nowSongIndex].content =
                            _controller.text;
                        break;
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('수정'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 영어로 된 열거형을 한글로 바꿔주는 함수
String elementToKorean(AlbumSelectedOption element) {
  if (element == AlbumSelectedOption.albumDate) {
    return '날짜';
  } else if (element == AlbumSelectedOption.albumTitle) {
    return '앨범 제목';
  } else if (element == AlbumSelectedOption.albumImage) {
    return '앨범 이미지';
  } else if (element == AlbumSelectedOption.backgroundColor) {
    return '배경색';
  } else if (element == AlbumSelectedOption.cdImage) {
    return 'CD 이미지';
  } else if (element == AlbumSelectedOption.cdTitle) {
    return '칵테일 이름';
  } else if (element == AlbumSelectedOption.cdReview) {
    return '리뷰';
  } else {
    return '오류';
  }
}
