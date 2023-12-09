import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sm_bar_master_frontend/data/datasource/remote_datasource.dart';
import 'package:sm_bar_master_frontend/data/model/album_model.dart';
import 'package:sm_bar_master_frontend/ui/album/album_sub_widgets/album_preview.dart';
import 'package:sm_bar_master_frontend/ui/album/album_sub_widgets/custom_page_controller.dart';
import 'package:sm_bar_master_frontend/ui/album/album_sub_widgets/songs_preview.dart';
import 'package:sm_bar_master_frontend/ui/album/album_view_model.dart';

class AlbumView extends StatelessWidget {
  final int albumId;

  const AlbumView({required this.albumId, super.key});

  @override
  Widget build(BuildContext context) {
    Future<AlbumModel> albumModel = getAlbumById(albumId);
    final albumViewModel = context.watch<AlbumViewModel>();

    return Scaffold(
      backgroundColor: Colors.black87,
      body: FutureBuilder(
        future: albumModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('에러 발생: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Stack(children: [
              Center(
                child: albumViewModel.nowSongIndex != -1
                    ? SongsPreview(
                        albumViewModel: albumViewModel, snapshot: snapshot)
                    : AlbumPreview(snapshot: snapshot),
              ),
              Center(
                child: CustomPageController(
                    albumViewModel: albumViewModel, snapshot: snapshot),
              ),
            ]);
          }
          return const Text('데이터가 없습니다.');
        },
      ),
    );
  }
}

