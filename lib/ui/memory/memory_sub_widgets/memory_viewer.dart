import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/ui/album/album_page.dart';
import 'package:sm_bar_master_frontend/ui/memory/memory_view_model.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_page.dart';

class MemoryViewer extends StatelessWidget {
  const MemoryViewer({
    super.key,
    required this.memoryViewModel,
    required this.snapshot,
  });

  final MemoryViewModel memoryViewModel;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              child: snapshot.data![index].imageUrl! == 'lib/assets/image_placeholder_no_image.png' ? Image.asset(
                snapshot.data![index].imageUrl!,
                fit: BoxFit.cover,
              ) : Image.network(
                snapshot.data![index].imageUrl!,
                fit: BoxFit.fill,
              )
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
    );
  }
}
