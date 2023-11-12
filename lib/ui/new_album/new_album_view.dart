import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_view_model.dart';
import 'package:provider/provider.dart';

class NewAlbumView extends StatelessWidget {
  const NewAlbumView({super.key});

  @override
  Widget build(BuildContext context) {
    NewAlbumViewModel newAlbumViewModel =
        Provider.of<NewAlbumViewModel>(context);
    print(newAlbumViewModel.nowSelected);

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Row(
        children: [
          Container(
            color: const Color.fromARGB(99, 255, 255, 255),
            width: 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                newAlbumViewModel.nowSelected == selectedOption.date
                    ? const Text("날짜", style: TextStyle(fontSize: 45))
                    : const Text("날짜", style: TextStyle(fontSize: 25)),
                newAlbumViewModel.nowSelected == selectedOption.albumTitle
                    ? const Text("앨범 제목", style: TextStyle(fontSize: 45))
                    : const Text("앨범 제목", style: TextStyle(fontSize: 25)),
                newAlbumViewModel.nowSelected == selectedOption.backgroundColor
                    ? const Text("배경 색", style: TextStyle(fontSize: 45))
                    : const Text("배경 색", style: TextStyle(fontSize: 25)),
                newAlbumViewModel.nowSelected == selectedOption.cdImage
                    ? const Text("CD 이미지", style: TextStyle(fontSize: 45))
                    : const Text("CD 이미지", style: TextStyle(fontSize: 25)),
                newAlbumViewModel.nowSelected == selectedOption.cocktailName
                    ? const Text("칵테일 이름", style: TextStyle(fontSize: 45))
                    : const Text("칵테일 이름", style: TextStyle(fontSize: 25)),
                newAlbumViewModel.nowSelected == selectedOption.review
                    ? const Text("한줄평", style: TextStyle(fontSize: 45))
                    : const Text("한줄평", style: TextStyle(fontSize: 25)),
              ],
            ),
          ),
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
                  child: Stack(children: [
                    _AlbumEditPreview(newAlbumViewModel: newAlbumViewModel),
                  ]),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "추가하기!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        )),
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

class _AlbumEditPreview extends StatelessWidget {
  String date = "2019.09.27";
  String albumTitle = "뭔가 멋있는듯한 제목";
  String backgroundColor = "0xFF475C66";
  String cdImage = "lib/assets/user_img01.jpg";
  String cocktailName = "칵테일 이름";
  String comment = "한줄평";
  NewAlbumViewModel newAlbumViewModel;

  _AlbumEditPreview({required this.newAlbumViewModel});

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
              children: [
                MouseRegion(
                  onEnter: (_) => newAlbumViewModel
                      .changeSelectedOption(selectedOption.date),
                  child: Text(
                    date,
                    style: const TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ),
                const Text(
                  ' - ',
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
                MouseRegion(
                  onEnter: (_) => newAlbumViewModel
                      .changeSelectedOption(selectedOption.albumTitle),
                  child: Text(
                    albumTitle,
                    style: const TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                onEnter: (_) => newAlbumViewModel
                    .changeSelectedOption(selectedOption.backgroundColor),
                child: Container(
                  width: 600,
                  height: 600,
                  color: Color(int.parse(backgroundColor)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ClipOval(
                        child: MouseRegion(
                          onEnter: (_) => newAlbumViewModel
                              .changeSelectedOption(selectedOption.cdImage),
                          child: Image.asset(
                            cdImage,
                            fit: BoxFit.cover,
                            width: 550,
                            height: 550,
                          ),
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
              MouseRegion(
                onEnter: (_) => newAlbumViewModel
                    .changeSelectedOption(selectedOption.backgroundColor),
                child: Container(
                  height: 600,
                  width: 20,
                  color: const Color.fromARGB(255, 44, 57, 63),
                ),
              ),
              MouseRegion(
                onEnter: (_) => newAlbumViewModel
                    .changeSelectedOption(selectedOption.backgroundColor),
                child: Container(
                  height: 600,
                  width: 600,
                  color: Color(int.parse(backgroundColor)),
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
                                    selectedOption.cocktailName),
                            child: Text(
                              cocktailName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        MouseRegion(
                          onEnter: (_) => newAlbumViewModel
                              .changeSelectedOption(selectedOption.review),
                          child: Text(
                            comment,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ],
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
