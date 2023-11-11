import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Center(
          child: SizedBox(
            width: 1220,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom:12),
                  child: Text('2019.09.27 - 뭔가 멋있는듯한 제목', style: TextStyle(color: Colors.white, fontSize: 35),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 600,
                      height: 600,
                      color: Colors.blueGrey,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: Image.asset(
                              "lib/assets/user_img01.jpg",
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
                              text: 'images matadata here!  images matadata here!   images matadata here!',
                              textStyle: TextStyle(fontSize: 15, color: Colors.white),
                              startAngle: -pi / 2,
                              startAngleAlignment: StartAngleAlignment.start,
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
                      color: Colors.blueGrey,
                      child: const Padding(
                        padding: EdgeInsets.all(45),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text('Title', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800),),
                            ),
                            Text('한줄평', style: TextStyle(color: Colors.white, fontSize: 11),),
                            Text('두줄평', style: TextStyle(color: Colors.white, fontSize: 11),),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
