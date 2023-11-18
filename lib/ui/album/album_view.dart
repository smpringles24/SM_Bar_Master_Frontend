import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:provider/provider.dart';
import 'package:sm_bar_master_frontend/data/datasource/remote_datasource.dart';
import 'package:sm_bar_master_frontend/data/model/album_model.dart';
import 'package:sm_bar_master_frontend/ui/album/album_view_model.dart';

class AlbumView extends StatelessWidget {
  final int albumId;

  const AlbumView({required this.albumId, super.key});

  @override
  Widget build(BuildContext context) {
    Future<AlbumModel> albumModel = getAlbumById(albumId);
    final albumViewModel = context.watch<AlbumViewModel>();
    final albumViewModelHandler = context.read<AlbumViewModel>();

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
                    ? SizedBox(
                        width: 1220,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                '${snapshot.data!.date} - ${snapshot.data!.title}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 35),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 600,
                                  height: 600,
                                  color: Color(int.parse(
                                      snapshot.data!.backgroundColor!)),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      ClipOval(
                                        child: Image.asset(
                                          snapshot
                                              .data!
                                              .songEntities![
                                                  albumViewModel.nowSongIndex]
                                              .imageUrl!,
                                          fit: BoxFit.cover,
                                          width: 550,
                                          height: 550,
                                        ),
                                      ),
                                      Container(
                                        width: 70, // 중앙 뚫린 부분의 크기 조절
                                        height: 70,
                                        decoration: const BoxDecoration(
                                          color: Colors.white, // 중앙 색상
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const ArcText(
                                          radius: 250,
                                          text:
                                              'images matadata here!  images matadata here!   images matadata here!',
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                          startAngle: -pi / 2,
                                          startAngleAlignment:
                                              StartAngleAlignment.start,
                                          placement: Placement.outside,
                                          direction: Direction.clockwise)
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 600,
                                  width: 20,
                                  color: const Color.fromARGB(255, 71, 92, 102),
                                ),
                                Container(
                                  height: 600,
                                  width: 600,
                                  color: Color(int.parse(
                                      snapshot.data!.backgroundColor!)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(45),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 15),
                                          child: Text(
                                            snapshot
                                                .data!
                                                .songEntities![
                                                    albumViewModel.nowSongIndex]
                                                .title!,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 32),
                                          ),
                                        ),
                                        Text(
                                          snapshot
                                              .data!
                                              .songEntities![
                                                  albumViewModel.nowSongIndex]
                                              .content!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    : Image.asset(
                        snapshot.data!.imageUrl!,
                        height: 600,
                        width: 600,
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
                          if (albumViewModel.nowSongIndex >= 0) {
                            albumViewModelHandler.setNowSongIndex(
                                albumViewModel.nowSongIndex - 1);
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
                            albumViewModelHandler.setNowSongIndex(
                                albumViewModel.nowSongIndex + 1);
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
            ]);
          }
          return const Text('데이터가 없습니다.');
        },
      ),
    );
  }
}
