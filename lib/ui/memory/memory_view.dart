import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/data/datasource/remote_datasource.dart';
import 'package:sm_bar_master_frontend/ui/album/album_page.dart';
import 'package:sm_bar_master_frontend/ui/memory/memory_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_page.dart';

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
              return const CircularProgressIndicator();
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
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (snapshot.data!.isNotEmpty) {
                              bool isDeleted =
                                  await deleteAlbum(snapshot.data![0].albumId!);
                              if (isDeleted) {
                                memoryViewModel.fetchdata();
                              } else {
                                //삭제 실패
                              }
                            } else {
                              //TODO: sncak bar로 알림
                            }
                          },
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
                                    builder: (context) =>
                                        AlbumPage(albumId: snapshot.data![index].albumId!),
                                  ),
                                );
                              },
                              child: SizedBox(
                                child: Image.asset(
                                  snapshot.data![index].imageUrl!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          } else {
                            return ElevatedButton(
                              onPressed: () async {
                                bool result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const NewAlbumPage(),
                                  ),
                                );

                                if (result) {
                                  await memoryViewModel.fetchdata();
                                }
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
