import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:sm_bar_master_frontend/data/datasource/remote_datasource.dart';
import 'package:sm_bar_master_frontend/data/model/etc_model.dart';
import 'package:sm_bar_master_frontend/ui/new_album/data_change_dialog.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sm_bar_master_frontend/data/model/song_entity.dart';

class NewAlbumView extends StatelessWidget {
  const NewAlbumView({super.key});

  @override
  Widget build(BuildContext context) {
    NewAlbumViewModel newAlbumViewModel = context.watch<NewAlbumViewModel>();
    NewAlbumViewModel newAlbumViewModelHandler =
        context.read<NewAlbumViewModel>();

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Row(
        children: [
          _IndicatorBar(newAlbumViewModel: newAlbumViewModel),
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
                                newAlbumViewModelHandler:
                                    newAlbumViewModelHandler,
                              ),
                      ),
                      Center(
                        child: SizedBox(
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
                                    newAlbumViewModelHandler.setNowSongIndex(
                                        newAlbumViewModel.nowSongIndex - 1);
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
                                      newAlbumViewModel
                                              .albumModel.songEntities!.length -
                                          1) {
                                    newAlbumViewModelHandler.setNowSongIndex(
                                        newAlbumViewModel.nowSongIndex + 1);
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
                        bool isCreated =
                            await createAlbum(newAlbumViewModel.albumModel);
                        if (isCreated) {
                          Navigator.pop(context, true);
                        } else {
                          Navigator.pop(context, false);
                        }
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
    );
  }
}

class _IndicatorBar extends StatelessWidget {
  const _IndicatorBar({required this.newAlbumViewModel});

  final NewAlbumViewModel newAlbumViewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(99, 255, 255, 255),
      width: 240,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("--- 앨범 ---", style: TextStyle(fontSize: 40)),
          newAlbumViewModel.nowSelected == AlbumSelectedOption.albumDate
              ? const Text("날짜", style: TextStyle(fontSize: 45))
              : const Text("날짜", style: TextStyle(fontSize: 25)),
          newAlbumViewModel.nowSelected == AlbumSelectedOption.albumTitle
              ? const Text("앨범 제목", style: TextStyle(fontSize: 45))
              : const Text("앨범 제목", style: TextStyle(fontSize: 25)),
          newAlbumViewModel.nowSelected == AlbumSelectedOption.backgroundColor
              ? const Text("배경 색", style: TextStyle(fontSize: 45))
              : const Text("배경 색", style: TextStyle(fontSize: 25)),
          const Text("--- CD ---", style: TextStyle(fontSize: 40)),
          newAlbumViewModel.nowSelected == AlbumSelectedOption.cdImage
              ? const Text("칵테일 사진", style: TextStyle(fontSize: 45))
              : const Text("칵테일 사진", style: TextStyle(fontSize: 25)),
          newAlbumViewModel.nowSelected == AlbumSelectedOption.cdTitle
              ? const Text("칵테일 이름", style: TextStyle(fontSize: 45))
              : const Text("칵테일 이름", style: TextStyle(fontSize: 25)),
          newAlbumViewModel.nowSelected == AlbumSelectedOption.cdReview
              ? const Text("한줄평", style: TextStyle(fontSize: 45))
              : const Text("한줄평", style: TextStyle(fontSize: 25)),
        ],
      ),
    );
  }
}

class _SongsEditPreview extends StatelessWidget {
  final NewAlbumViewModel newAlbumViewModel;
  final NewAlbumViewModel newAlbumViewModelHandler;

  const _SongsEditPreview(
      {required this.newAlbumViewModel,
      required this.newAlbumViewModelHandler});

  @override
  Widget build(BuildContext context) {
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
                    MouseRegion(
                      onEnter: (_) => newAlbumViewModel
                          .changeSelectedOption(AlbumSelectedOption.albumDate),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DataChangeDialog(
                                  element: AlbumSelectedOption.albumDate,
                                  albumModel: newAlbumViewModel.albumModel,
                                  nowSongIndex: newAlbumViewModel.nowSongIndex);
                            },
                          );
                        },
                        child: Text(
                          newAlbumViewModel.albumModel.date!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 35),
                        ),
                      ),
                    ),
                    const Text(
                      ' - ',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    MouseRegion(
                      onEnter: (_) => newAlbumViewModel
                          .changeSelectedOption(AlbumSelectedOption.albumTitle),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DataChangeDialog(
                                  element: AlbumSelectedOption.albumTitle,
                                  albumModel: newAlbumViewModel.albumModel,
                                  nowSongIndex: newAlbumViewModel.nowSongIndex);
                            },
                          );
                        },
                        child: Text(
                          newAlbumViewModel.albumModel.title!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 35),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${newAlbumViewModel.nowSongIndex + 1} / ${newAlbumViewModel.albumModel.songEntities!.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    IconButton(
                        onPressed: () {
                          newAlbumViewModelHandler.addSongEntity(SongEntity());
                          if (newAlbumViewModel.nowSongIndex <
                              newAlbumViewModel
                                      .albumModel.songEntities!.length -
                                  1) {
                            newAlbumViewModelHandler.setNowSongIndex(
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
                          //TODO: Song삭제
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
              MouseRegion(
                onEnter: (_) => newAlbumViewModel
                    .changeSelectedOption(AlbumSelectedOption.backgroundColor),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DataChangeDialog(
                            element: AlbumSelectedOption.backgroundColor,
                            albumModel: newAlbumViewModel.albumModel,
                            nowSongIndex: newAlbumViewModel.nowSongIndex);
                      },
                    );
                  },
                  child: Container(
                    width: 600,
                    height: 600,
                    color: Color(int.parse(
                        newAlbumViewModel.albumModel.backgroundColor!)),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: MouseRegion(
                            onEnter: (_) =>
                                newAlbumViewModel.changeSelectedOption(
                                    AlbumSelectedOption.cdImage),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DataChangeDialog(
                                        element: AlbumSelectedOption.cdImage,
                                        albumModel:
                                            newAlbumViewModel.albumModel,
                                        nowSongIndex:
                                            newAlbumViewModel.nowSongIndex);
                                  },
                                );
                              },
                              child: Image.asset(
                                newAlbumViewModel
                                    .albumModel
                                    .songEntities![
                                        newAlbumViewModel.nowSongIndex]
                                    .imageUrl!,
                                fit: BoxFit.cover,
                                width: 550,
                                height: 550,
                              ),
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
              ),
              MouseRegion(
                onEnter: (_) => newAlbumViewModel
                    .changeSelectedOption(AlbumSelectedOption.backgroundColor),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DataChangeDialog(
                            element: AlbumSelectedOption.backgroundColor,
                            albumModel: newAlbumViewModel.albumModel,
                            nowSongIndex: newAlbumViewModel.nowSongIndex);
                      },
                    );
                  },
                  child: Container(
                    height: 600,
                    width: 20,
                    color: const Color.fromARGB(255, 44, 57, 63),
                  ),
                ),
              ),
              MouseRegion(
                onEnter: (_) => newAlbumViewModel
                    .changeSelectedOption(AlbumSelectedOption.backgroundColor),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DataChangeDialog(
                            element: AlbumSelectedOption.backgroundColor,
                            albumModel: newAlbumViewModel.albumModel,
                            nowSongIndex: newAlbumViewModel.nowSongIndex);
                      },
                    );
                  },
                  child: Container(
                    height: 600,
                    width: 600,
                    color: Color(int.parse(
                        newAlbumViewModel.albumModel.backgroundColor!)),
                    child: Padding(
                      padding: const EdgeInsets.all(45),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: MouseRegion(
                              onEnter: (_) =>
                                  newAlbumViewModel.changeSelectedOption(
                                      AlbumSelectedOption.cdTitle),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DataChangeDialog(
                                          element: AlbumSelectedOption.cdTitle,
                                          albumModel:
                                              newAlbumViewModel.albumModel,
                                          nowSongIndex:
                                              newAlbumViewModel.nowSongIndex);
                                    },
                                  );
                                },
                                child: Text(
                                  newAlbumViewModel
                                      .albumModel
                                      .songEntities![
                                          newAlbumViewModel.nowSongIndex]
                                      .title!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ),
                          MouseRegion(
                            onEnter: (_) =>
                                newAlbumViewModel.changeSelectedOption(
                                    AlbumSelectedOption.cdReview),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DataChangeDialog(
                                        element: AlbumSelectedOption.cdReview,
                                        albumModel:
                                            newAlbumViewModel.albumModel,
                                        nowSongIndex:
                                            newAlbumViewModel.nowSongIndex);
                                  },
                                );
                              },
                              child: Text(
                                newAlbumViewModel
                                    .albumModel
                                    .songEntities![
                                        newAlbumViewModel.nowSongIndex]
                                    .content!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _AlbumEditPreview extends StatelessWidget {
  late NewAlbumViewModel newAlbumViewModel;
  _AlbumEditPreview({required this.newAlbumViewModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        onEnter: (_) => newAlbumViewModel
            .changeSelectedOption(AlbumSelectedOption.albumImage),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DataChangeDialog(
                    element: AlbumSelectedOption.albumImage,
                    albumModel: newAlbumViewModel.albumModel,
                    nowSongIndex: newAlbumViewModel.nowSongIndex);
              },
            );
          },
          child: Image.asset(
            newAlbumViewModel.albumModel.imageUrl!,
            height: 600,
            width: 600,
          ),
        ),
      ),
    );
  }
}
