import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/utils/types.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_view_model.dart';

class SelectionIndicatorBar extends StatelessWidget {
  final NewAlbumViewModel newAlbumViewModel;

  const SelectionIndicatorBar({super.key, required this.newAlbumViewModel});

  TextStyle getStyle(AlbumSelectedOption option) {
    const normalTextStyle = TextStyle(fontSize: 25);
    const selectedTextStyle = TextStyle(fontSize: 45);
    return newAlbumViewModel.nowSelected == option
        ? selectedTextStyle
        : normalTextStyle;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(99, 255, 255, 255),
      width: 240,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("--- 앨범 ---", style: TextStyle(fontSize: 40)),
          Text("날짜", style: getStyle(AlbumSelectedOption.albumDate)),
          Text("앨범 제목", style: getStyle(AlbumSelectedOption.albumTitle)),
          Text("배경 색", style: getStyle(AlbumSelectedOption.backgroundColor)),
          const Text("--- CD ---", style: TextStyle(fontSize: 40)),
          Text("칵테일 사진", style: getStyle(AlbumSelectedOption.cdImage)),
          Text("칵테일 이름", style: getStyle(AlbumSelectedOption.cdTitle)),
          Text("한줄평", style: getStyle(AlbumSelectedOption.cdReview)),
        ],
      ),
    );
  }
}
