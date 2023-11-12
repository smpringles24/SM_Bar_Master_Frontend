import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/ui/album/album_page.dart';
import 'package:sm_bar_master_frontend/ui/memory/memory_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_page.dart';

class Album {
  final String imageUrl;

  Album({required this.imageUrl});
}

List<Album> albumData = [
  Album(imageUrl: 'lib/assets/album_sample01.png'),
  Album(imageUrl: 'lib/assets/album_sample02.png'),
  Album(imageUrl: 'lib/assets/album_sample01.png'),
  Album(imageUrl: 'lib/assets/album_sample02.png'),
  Album(imageUrl: 'lib/assets/album_sample01.png'),
  Album(imageUrl: 'lib/assets/album_sample02.png'),
  Album(imageUrl: 'lib/assets/album_sample01.png'),
  Album(imageUrl: 'lib/assets/album_sample02.png'),
  Album(imageUrl: 'lib/assets/album_sample01.png'),
  Album(imageUrl: 'lib/assets/album_sample02.png'),
  Album(imageUrl: 'lib/assets/album_sample01.png'),
  Album(imageUrl: 'lib/assets/album_sample02.png'),
  // ... 추가 앨범 데이터 ...
  // 데이터가 15개 미만이면, 나머지 항목들은 미리보기 이미지를 사용합니다.
];

class MemoryView extends StatelessWidget {
  const MemoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final memoryViewModel = Provider.of<MemoryViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.black87,
      body: FutureBuilder(
          future: memoryViewModel.memoryPreviewImages,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // 로딩 중 화면
            } else if (snapshot.hasError) {
              return Text('에러 발생: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "2019.09",
                          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 35),
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 25.0,
                          mainAxisSpacing: 25.0,
                        ),
                        itemCount: snapshot.data!.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < snapshot.data!.length) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AlbumPage(),
                                  ),
                                );
                              },
                              child: SizedBox(
                                child: Image.asset(
                                  "lib/assets/placeholder.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          } else {
                            return ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const NewAlbumPage(),
                                  ),
                                );
                              },
                              child: const Text("앨범 추가"),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    color: Colors.black87,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 500,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Text('데이터가 없습니다.');
            }
          }),
    );
  }
}
