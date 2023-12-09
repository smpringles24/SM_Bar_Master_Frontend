import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:provider/provider.dart';

import 'package:sm_bar_master_frontend/data/datasource/remote_datasource.dart';
import 'package:sm_bar_master_frontend/data/model/etc_model.dart';
import 'package:sm_bar_master_frontend/ui/new_album/data_change_dialog.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_view_model.dart';
import 'package:sm_bar_master_frontend/data/model/song_entity.dart';
import 'package:sm_bar_master_frontend/utils/data_convert.dart';

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
            _SelectionIndicatorBar(newAlbumViewModel: newAlbumViewModel),
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
                          child: newAlbumViewModel.nowSongIndex == -1
                              ? _AlbumEditPreview(
                                  newAlbumViewModel: newAlbumViewModel)
                              : _SongsEditPreview(
                                  newAlbumViewModel: newAlbumViewModel,
                                ),
                        ),
                        Center(
                            child: _PageController(
                          newAlbumViewModel: newAlbumViewModel,
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          await createAlbum(newAlbumViewModel.albumModel)
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

class _PageController extends StatelessWidget {
  const _PageController({
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
              if (newAlbumViewModel.nowSongIndex >= 0) {
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
                  newAlbumViewModel.albumModel.songEntities!.length - 1) {
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

class _SelectionIndicatorBar extends StatelessWidget {
  final NewAlbumViewModel newAlbumViewModel;

  const _SelectionIndicatorBar({required this.newAlbumViewModel});

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

class _SongsEditPreview extends StatelessWidget {
  final NewAlbumViewModel newAlbumViewModel;

  const _SongsEditPreview({required this.newAlbumViewModel});

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
                                      .albumModel.songEntities!.length -
                                  1) {
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
                              1) return;
                          if (newAlbumViewModel.nowSongIndex ==
                              newAlbumViewModel
                                      .albumModel.songEntities!.length -
                                  1) {
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
                          child: Image.asset(
                            newAlbumViewModel
                                .albumModel
                                .songEntities![newAlbumViewModel.nowSongIndex]
                                .imageUrl!,
                            fit: BoxFit.cover,
                            width: 550,
                            height: 550,
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
                                  .songEntities![newAlbumViewModel.nowSongIndex]
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
                                .songEntities![newAlbumViewModel.nowSongIndex]
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

class CustomHoverAndClickableWidget extends StatelessWidget {
  final NewAlbumViewModel newAlbumViewModel;
  final AlbumSelectedOption type;
  final Widget child;

  const CustomHoverAndClickableWidget({
    super.key,
    required this.newAlbumViewModel,
    required this.type,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => newAlbumViewModel.changeSelectedOption(type),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DataChangeDialog(
                newAlbumViewModel: newAlbumViewModel,
                element: type,
              );
            },
          );
        },
        child: child,
      ),
    );
  }
}

class _AlbumEditPreview extends StatelessWidget {
  final NewAlbumViewModel newAlbumViewModel;

  const _AlbumEditPreview({required this.newAlbumViewModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomHoverAndClickableWidget(
        newAlbumViewModel: newAlbumViewModel,
        type: AlbumSelectedOption.albumImage,
        child: FutureBuilder<Uint8List?>(
          future:
              xfileToUint8List(newAlbumViewModel.newAlbumTitlePreviewImage),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: 600,
                height: 600,
                child: Image.memory(snapshot.data!),
              );
            } else {
              return Container(
                width: 600,
                height: 600,
                color: Colors.white,
              );
            }
          },
        ),
      ),
    );
  }
}
