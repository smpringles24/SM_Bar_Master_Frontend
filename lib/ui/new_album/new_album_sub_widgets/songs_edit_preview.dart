import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:sm_bar_master_frontend/utils/image_data_convert.dart';

import 'package:sm_bar_master_frontend/utils/types.dart';
import 'package:sm_bar_master_frontend/data/model/song_entity.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_view_model.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_sub_widgets/custom_hover_and_clickable_widget.dart';

class SongsEditPreview extends StatelessWidget {
  final NewAlbumViewModel newAlbumViewModel;

  const SongsEditPreview({super.key, required this.newAlbumViewModel});

  @override
  Widget build(BuildContext context) {
    final String songIndexText =
        '${newAlbumViewModel.nowSongIndex + 1} / ${newAlbumViewModel.albumModel.songEntities!.length}';

    return SizedBox(
      width: 1220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomHoverAndClickableWidget(
                      newAlbumViewModel: newAlbumViewModel,
                      type: AlbumSelectedOption.albumDate,
                      child: Text(
                        newAlbumViewModel.albumModel.date!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                    const Text(
                      ' - ',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    CustomHoverAndClickableWidget(
                      newAlbumViewModel: newAlbumViewModel,
                      type: AlbumSelectedOption.albumTitle,
                      child: Text(
                        newAlbumViewModel.albumModel.title!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      songIndexText,
                      style: const TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    IconButton(
                        onPressed: () {
                          newAlbumViewModel.addSongEntity(SongEntity());
                          if (newAlbumViewModel.nowSongIndex <
                              newAlbumViewModel
                                  .albumModel.songEntities!.length) {
                            newAlbumViewModel.setNowSongIndex(
                                newAlbumViewModel.nowSongIndex + 1);
                          }
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 35,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          if (newAlbumViewModel
                                  .albumModel.songEntities!.length ==
                              2) return;
                          if (newAlbumViewModel.nowSongIndex ==
                              newAlbumViewModel
                                  .albumModel.songEntities!.length) {
                            newAlbumViewModel.setNowSongIndex(
                                newAlbumViewModel.nowSongIndex - 1);
                          }
                          newAlbumViewModel
                              .removeSongEntity(newAlbumViewModel.nowSongIndex);
                        },
                        icon: const Icon(
                          Icons.remove,
                          size: 35,
                          color: Colors.white,
                        )),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomHoverAndClickableWidget(
                newAlbumViewModel: newAlbumViewModel,
                type: AlbumSelectedOption.backgroundColor,
                child: Container(
                  width: 600,
                  height: 600,
                  color: Color(
                      int.parse(newAlbumViewModel.albumModel.backgroundColor!)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ClipOval(
                        child: CustomHoverAndClickableWidget(
                          newAlbumViewModel: newAlbumViewModel,
                          type: AlbumSelectedOption.cdImage,
                          child: FutureBuilder<Uint8List?>(
                            future: xfileToUint8List(
                                newAlbumViewModel.newAlbumPreviewImages[
                                    newAlbumViewModel.nowSongIndex]),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Image.memory(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                  width: 550,
                                  height: 550,
                                );
                              } else {
                                return Image.asset(
                                    'lib/assets/image_placeholder_no_image.png',
                                    fit: BoxFit.cover,
                                    width: 550,
                                    height: 550);
                              }
                            },
                          ),
                        ),
                      ),
                      // 중앙 뚫린 부분의 크기 조절
                      Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const ArcText(
                          radius: 250,
                          text:
                              'images matadata here!  images matadata here!   images matadata here!',
                          textStyle:
                              TextStyle(fontSize: 15, color: Colors.white),
                          startAngle: -pi / 2,
                          startAngleAlignment: StartAngleAlignment.start,
                          placement: Placement.outside,
                          direction: Direction.clockwise)
                    ],
                  ),
                ),
              ),
              CustomHoverAndClickableWidget(
                newAlbumViewModel: newAlbumViewModel,
                type: AlbumSelectedOption.backgroundColor,
                child: Container(
                  height: 600,
                  width: 20,
                  color: const Color.fromARGB(255, 44, 57, 63),
                ),
              ),
              CustomHoverAndClickableWidget(
                newAlbumViewModel: newAlbumViewModel,
                type: AlbumSelectedOption.backgroundColor,
                child: Container(
                  height: 600,
                  width: 600,
                  color: Color(
                      int.parse(newAlbumViewModel.albumModel.backgroundColor!)),
                  child: Padding(
                    padding: const EdgeInsets.all(45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: CustomHoverAndClickableWidget(
                            newAlbumViewModel: newAlbumViewModel,
                            type: AlbumSelectedOption.cdTitle,
                            child: Text(
                              newAlbumViewModel
                                  .albumModel
                                  .songEntities![newAlbumViewModel.nowSongIndex - 1]
                                  .title!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        CustomHoverAndClickableWidget(
                          newAlbumViewModel: newAlbumViewModel,
                          type: AlbumSelectedOption.cdReview,
                          child: Text(
                            newAlbumViewModel
                                .albumModel
                                .songEntities![newAlbumViewModel.nowSongIndex - 1]
                                .content!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
