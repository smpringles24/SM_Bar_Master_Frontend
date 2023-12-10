import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sm_bar_master_frontend/data/datasource/remote_datasource.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_sub_widgets/album_edit_preview.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_sub_widgets/page_controller.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_sub_widgets/selection_indicator_bar.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_sub_widgets/songs_edit_preview.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_view_model.dart';

class NewAlbumView extends StatelessWidget {
  const NewAlbumView({super.key});

  @override
  Widget build(BuildContext context) {
    NewAlbumViewModel newAlbumViewModel = context.watch<NewAlbumViewModel>();

    return WillPopScope(
      //뒤로가기 프리징 방지
      onWillPop: () async {
        Navigator.pop(context, false);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Row(
          children: [
            SelectionIndicatorBar(newAlbumViewModel: newAlbumViewModel),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      color: const Color(0xFF81B71A),
                      child: const Center(
                        child: Text(
                          "새로운 앨범 추가",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 45,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Stack(
                      children: [
                        Center(
                          child: newAlbumViewModel.nowSongIndex == 0
                              ? AlbumEditPreview(
                                  newAlbumViewModel: newAlbumViewModel)
                              : SongsEditPreview(
                                  newAlbumViewModel: newAlbumViewModel,
                                ),
                        ),
                        Center(
                          child: CustomPageController(
                            newAlbumViewModel: newAlbumViewModel,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          await createAlbum(newAlbumViewModel)
                              .then((_) => {Navigator.pop(context, true)});
                        },
                        child: const Text(
                          "추가하기!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
