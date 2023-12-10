import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_view_model.dart';


class CustomPageController extends StatelessWidget {
  const CustomPageController({super.key, 
    required this.newAlbumViewModel,
  });

  final NewAlbumViewModel newAlbumViewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            constraints: const BoxConstraints.tightFor(
              width: 100,
              height: 100,
            ),
            onPressed: () {
              if (newAlbumViewModel.nowSongIndex > 0) {
                newAlbumViewModel
                    .setNowSongIndex(newAlbumViewModel.nowSongIndex - 1);
              }
            },
            icon: const Icon(
              Icons.arrow_left,
              color: Colors.greenAccent,
              size: 70,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          IconButton(
            constraints: const BoxConstraints.tightFor(
              width: 100,
              height: 100,
            ),
            onPressed: () {
              if (newAlbumViewModel.nowSongIndex <
                  newAlbumViewModel.albumModel.songEntities!.length) {
                newAlbumViewModel
                    .setNowSongIndex(newAlbumViewModel.nowSongIndex + 1);
              }
            },
            icon: const Icon(
              Icons.arrow_right,
              color: Colors.greenAccent,
              size: 70,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
