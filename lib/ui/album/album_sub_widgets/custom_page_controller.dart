import 'package:flutter/material.dart';

import 'package:sm_bar_master_frontend/data/model/album_model.dart';
import 'package:sm_bar_master_frontend/ui/album/album_view_model.dart';

class CustomPageController extends StatelessWidget {
  const CustomPageController({
    super.key,
    required this.albumViewModel,
    required this.snapshot,
  });

  final AlbumViewModel albumViewModel;
  final AsyncSnapshot<AlbumModel> snapshot;

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
              if (albumViewModel.nowSongIndex >= 0) {
                albumViewModel.setNowSongIndex(albumViewModel.nowSongIndex - 1);
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
              if (albumViewModel.nowSongIndex <
                  snapshot.data!.songEntities!.length - 1) {
                albumViewModel.setNowSongIndex(albumViewModel.nowSongIndex + 1);
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
