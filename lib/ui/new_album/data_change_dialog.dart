import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/data/model/etc_model.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_view_model.dart';

class DataChangeDialog extends StatelessWidget {
  final NewAlbumData newAlbumData;
  final TextEditingController _controller = TextEditingController();
  late AlbumSelectedOption element;

  DataChangeDialog(
      {required this.element, required this.newAlbumData, super.key});

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
                      case AlbumSelectedOption.date:
                        newAlbumData.date = _controller.text;
                        break;
                      case AlbumSelectedOption.albumTitle:
                        newAlbumData.albumTitle = _controller.text;
                        break;
                      case AlbumSelectedOption.backgroundColor:
                        newAlbumData.backgroundColor = _controller.text;
                        break;
                      case AlbumSelectedOption.cdImage:
                        newAlbumData.cdImage = _controller.text;
                        break;
                      case AlbumSelectedOption.cocktailName:
                        newAlbumData.cocktailName = _controller.text;
                        break;
                      case AlbumSelectedOption.review:
                        newAlbumData.review = _controller.text;
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
  if (element == AlbumSelectedOption.date) {
    return '날짜';
  } else if (element == AlbumSelectedOption.albumTitle)
    return '앨범 제목';
  else if (element == AlbumSelectedOption.backgroundColor)
    return '배경색';
  else if (element == AlbumSelectedOption.cdImage)
    return 'CD 이미지';
  else if (element == AlbumSelectedOption.cocktailName)
    return '칵테일 이름';
  else if (element == AlbumSelectedOption.review)
    return '리뷰';
  else
    return '오류';
}
